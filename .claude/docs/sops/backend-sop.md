# Backend SOP — FastAPI + SQLAlchemy + Celery

> Production-grade patterns for async Python backends. Copy-paste ready.

---

## 1. Project Structure

```
apps/api/
├── api/
│   ├── app.py                 # Application factory
│   ├── main.py                # Uvicorn entrypoint
│   ├── settings.py            # Pydantic Settings (single source of truth)
│   ├── exceptions.py          # Global exception handlers
│   ├── rate_limit.py          # SlowAPI rate limiter
│   ├── core/
│   │   ├── models.py          # BaseModel (DeclarativeBase + timestamps)
│   │   ├── crud.py            # Generic BaseCrud[M, C, U]
│   │   ├── schemas.py         # PageResponse, ErrorResponse, shared types
│   │   └── exceptions.py      # Custom exception hierarchy
│   ├── deps/
│   │   ├── db.py              # Async engines, session factory, SessionDep
│   │   ├── auth.py            # Cookie auth, AuthDep
│   │   ├── redis.py           # Redis pools (async + sync), AsyncRedisDep
│   │   ├── storage.py         # S3 client, file validation, S3ClientDep
│   │   ├── celery.py          # Celery app, async_task decorator, TaskContext
│   │   └── tasks.py           # Shared/scheduled Celery tasks
│   ├── {domain}/
│   │   ├── routes.py          # APIRouter with endpoints
│   │   ├── models/            # SQLAlchemy models
│   │   ├── schemas.py         # Pydantic Create/Update/Read schemas
│   │   ├── crud.py            # Domain-specific CRUD (extends BaseCrud)
│   │   ├── service.py         # Business logic orchestration
│   │   ├── enums.py           # str,Enum status fields
│   │   └── tasks.py           # Celery tasks for this domain
│   └── storage/
│       └── service.py         # S3 wrapper with retry
├── migrations/                # Alembic (autogenerate only)
├── __tests__/                 # pytest
└── pyproject.toml             # Poetry + ruff + mypy + pytest config
```

**Rule:** Each domain is a self-contained module. Routes import from crud/service. Services receive all dependencies via constructor. No cross-domain imports except through schemas.

---

## 2. Settings — Pydantic BaseSettings

```python
from typing import Literal
from pydantic import AliasChoices, Field, HttpUrl, PostgresDsn, computed_field
from pydantic_settings import BaseSettings, SettingsConfigDict

class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        env_ignore_empty=True,
        extra="ignore",
        env_prefix="API_",                # All vars: API_SECRET_KEY, API_DATABASE_URL, etc.
    )

    # ─── Core ──────────────────────────────────────────────────────────
    PROJECT_NAME: str = "API"
    SECRET_KEY: str
    ENVIRONMENT: Literal["local", "staging", "production"] = "local"

    # ─── Database ──────────────────────────────────────────────────────
    DATABASE_URL: PostgresDsn = PostgresDsn(
        "postgresql+asyncpg://postgres:postgres@localhost:5432/api"
    )

    # ─── Server ────────────────────────────────────────────────────────
    SERVER_HOST: str = "0.0.0.0"
    SERVER_PORT: int = Field(
        default=8000,
        validation_alias=AliasChoices("PORT", "API_SERVER_PORT"),  # Flexible naming
    )
    SWAGGER_HIDE: bool = False

    # ─── Object Storage (S3-compatible) ────────────────────────────────
    S3_ENDPOINT: str
    S3_ACCESS_KEY_ID: str
    S3_SECRET_ACCESS_KEY: str
    S3_BUCKET_NAME: str
    S3_REGION: str = "us-east-1"

    # ─── Celery ────────────────────────────────────────────────────────
    CELERY_BROKER_URL: str = "redis://localhost:6379/0"
    CELERY_RESULT_BACKEND: str = "redis://localhost:6379/0"
    CELERY_TASK_TIME_LIMIT: int = 1800
    CELERY_TASK_SOFT_TIME_LIMIT: int = 1500

    # ─── File Uploads ──────────────────────────────────────────────────
    UPLOAD_ALLOWED_EXTENSIONS: list[str] = [".xlsx", ".csv"]
    UPLOAD_MAX_FILE_SIZE: int = 10 * 1024 * 1024  # 10 MB

    # ─── CORS ──────────────────────────────────────────────────────────
    CORS_ORIGINS: list[str] = ["http://localhost:5173"]

    # ─── Observability ─────────────────────────────────────────────────
    SENTRY_DSN: HttpUrl | None = None
    SENTRY_TRACES_SAMPLE_RATE: float = Field(default=0.1, ge=0.0, le=1.0)

    # ─── Computed ──────────────────────────────────────────────────────
    @computed_field
    @property
    def docs_url(self) -> str | None:
        return None if self.SWAGGER_HIDE else "/docs"

    @computed_field
    @property
    def openapi_url(self) -> str | None:
        return None if self.SWAGGER_HIDE else "/openapi.json"

settings = Settings()   # Singleton — import this everywhere
```

**Key decisions:**
- `env_prefix="API_"` — namespaces all env vars, avoids collisions in Docker
- `computed_field` — derived config (hide docs in prod, auto-reload in dev)
- `AliasChoices` — accept multiple env var names for the same setting
- Singleton at module level — import `settings` directly, never re-instantiate

---

## 3. Application Factory

```python
from collections.abc import AsyncGenerator
from contextlib import asynccontextmanager
from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware

@asynccontextmanager
async def lifespan(app: FastAPI) -> AsyncGenerator[None, None]:
    """Startup: init services. Shutdown: close connections."""
    init_sentry()
    yield
    await shutdown_redis()

def create_application() -> FastAPI:
    app = FastAPI(
        title=settings.PROJECT_NAME,
        docs_url=settings.docs_url,
        openapi_url=settings.openapi_url,
        lifespan=lifespan,
    )

    # Rate limiting
    app.state.limiter = limiter
    app.add_exception_handler(RateLimitExceeded, _rate_limit_exceeded_handler)

    # CORS
    app.add_middleware(
        CORSMiddleware,
        allow_origins=settings.CORS_ORIGINS,
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    # Error handlers
    register_exception_handlers(app)

    # Routes — versioned API prefix
    app.include_router(core_router)               # /health, /
    API_V1 = "/api/v1"
    app.include_router(auth_router, prefix=API_V1)
    app.include_router(videos_router, prefix=API_V1)
    # ... more routers

    return app
```

---

## 4. Database — Async SQLAlchemy

### Base Model

```python
from datetime import UTC, datetime
from sqlalchemy import DateTime
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column

class BaseModel(DeclarativeBase):
    __abstract__ = True

    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=False),
        default=lambda: datetime.now(UTC).replace(tzinfo=None),
        nullable=False,
    )
    updated_at: Mapped[datetime | None] = mapped_column(
        DateTime(timezone=False),
        default=lambda: datetime.now(UTC).replace(tzinfo=None),
        onupdate=lambda: datetime.now(UTC).replace(tzinfo=None),
        nullable=True,
    )
```

### Dual Engine Pattern (FastAPI + Celery)

```python
from collections.abc import AsyncGenerator
from contextlib import asynccontextmanager
from typing import Annotated
from fastapi import Depends
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine
from sqlalchemy.pool import NullPool

# FastAPI engine — connection pool with pre-ping for stale connection detection
engine = create_async_engine(
    str(settings.DATABASE_URL),
    echo=False,
    future=True,
    pool_size=5,
    max_overflow=10,
    pool_pre_ping=True,
)

# Celery engine — NullPool avoids event-loop mismatch with asyncpg
_celery_engine = create_async_engine(
    str(settings.DATABASE_URL),
    echo=False,
    future=True,
    poolclass=NullPool,
)


async def get_db() -> AsyncGenerator[AsyncSession, None]:
    """FastAPI dependency — yields a session from the pooled engine."""
    async with AsyncSession(engine) as session:
        try:
            yield session
        finally:
            await session.close()


@asynccontextmanager
async def async_session_factory() -> AsyncGenerator[AsyncSession, None]:
    """Celery task context — NullPool engine, expire_on_commit=False."""
    async with AsyncSession(_celery_engine, expire_on_commit=False) as session:
        try:
            yield session
        finally:
            await session.close()


async def save(session: AsyncSession, db_object: object) -> None:
    """Add, commit, and refresh a database object."""
    session.add(db_object)
    await session.commit()
    await session.refresh(db_object)


SessionDep = Annotated[AsyncSession, Depends(get_db)]
```

**Why two engines:**
- FastAPI runs one event loop for the app lifetime — connection pool is safe to reuse.
- Celery `async_to_sync` creates a new event loop per task invocation — pooled connections bind to the wrong loop and break. NullPool = fresh connection every time.

### Domain Model Example

```python
import uuid
from sqlalchemy import ForeignKey, String, Text
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import Mapped, mapped_column, relationship

class Video(BaseModel):
    __tablename__ = "videos"

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    batch_id: Mapped[uuid.UUID | None] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("batches.id", ondelete="CASCADE"),
        nullable=True,
        index=True,
    )
    script_text: Mapped[str] = mapped_column(Text, nullable=False)
    status: Mapped[VideoStatus] = mapped_column(
        String(20), nullable=False, default=VideoStatus.processing, index=True
    )

    # Relationships
    batch: Mapped["Batch | None"] = relationship(back_populates="videos")
    shots: Mapped[list["Shot"]] = relationship(
        back_populates="video",
        cascade="all, delete-orphan",
        order_by="Shot.order",
    )

    # Computed properties for S3 key derivation
    @property
    def s3_prefix(self) -> str:
        return f"videos/{self.id}"
```

---

## 5. Schemas — Create / Update / Read

```python
import uuid
from pydantic import BaseModel, Field

class VideoCreate(BaseModel):
    script_text: str = Field(min_length=1)
    voice_id: str
    batch_id: uuid.UUID | None = None

class VideoUpdate(BaseModel):
    script_text: str | None = None    # All fields optional for PATCH
    voice_id: str | None = None

class VideoRead(BaseModel):
    id: uuid.UUID
    script_text: str
    status: VideoStatus
    model_config = {"from_attributes": True}  # ORM mode
```

### Pagination Wrapper (Generic)

```python
import math
from typing import Generic, TypeVar
from pydantic import BaseModel

T = TypeVar("T")

class PageResponse(BaseModel, Generic[T]):
    items: list[T]
    page: int
    page_size: int
    total: int
    total_pages: int

    @classmethod
    def create(
        cls, items: list[T], total: int, page: int, page_size: int
    ) -> "PageResponse[T]":
        return cls(
            items=items,
            page=page,
            page_size=page_size,
            total=total,
            total_pages=math.ceil(total / page_size) if page_size > 0 else 0,
        )
```

### Standard Error Response

```python
from typing import Any, Literal

class ErrorResponse(BaseModel):
    status: Literal["error"] = "error"
    message: str
    detail: Any | None = None
```

---

## 6. Generic CRUD

```python
from typing import Generic, TypeVar
from pydantic import BaseModel
from sqlalchemy import func, select
from sqlalchemy.orm import DeclarativeBase

ModelType = TypeVar("ModelType", bound=DeclarativeBase)
CreateSchemaType = TypeVar("CreateSchemaType", bound=BaseModel)
UpdateSchemaType = TypeVar("UpdateSchemaType", bound=BaseModel)

class BaseCrud(Generic[ModelType, CreateSchemaType, UpdateSchemaType]):
    def __init__(self, session: SessionDep, model: type[ModelType]):
        self.db_session = session
        self.model = model

    async def create(self, obj_in: CreateSchemaType) -> ModelType:
        obj_data = obj_in.model_dump(exclude_unset=True)
        db_obj = self.model(**obj_data)
        await save(self.db_session, db_obj)
        return db_obj

    async def get(self, record_id: uuid.UUID) -> ModelType | None:
        return await self.db_session.get(self.model, record_id)

    async def get_multi(self, page: int = 1, page_size: int = 50) -> PageResponse[ModelType]:
        total = await self.count()
        offset = (page - 1) * page_size
        statement = (
            select(self.model)
            .order_by(self.model.created_at.desc())
            .offset(offset)
            .limit(page_size)
        )
        result = await self.db_session.execute(statement)
        items = list(result.scalars().all())
        return PageResponse.create(items=items, total=total, page=page, page_size=page_size)

    async def update(self, record_id: uuid.UUID, obj_in: UpdateSchemaType) -> ModelType | None:
        db_obj = await self.get(record_id)
        if not db_obj:
            return None
        for field, value in obj_in.model_dump(exclude_unset=True).items():
            setattr(db_obj, field, value)
        await save(self.db_session, db_obj)
        return db_obj

    async def delete(self, record_id: uuid.UUID) -> bool:
        db_obj = await self.get(record_id)
        if not db_obj:
            return False
        await self.db_session.delete(db_obj)
        await self.db_session.commit()
        return True

    async def count(self) -> int:
        statement = select(func.count()).select_from(self.model)
        result = await self.db_session.execute(statement)
        return result.scalar_one() or 0

    async def exists(self, record_id: uuid.UUID) -> bool:
        return await self.get(record_id) is not None
```

**Subclass:**

```python
class VideoCrud(BaseCrud[Video, VideoCreate, VideoUpdate]):
    def __init__(self, session: SessionDep) -> None:
        super().__init__(session=session, model=Video)

    async def get_by_batch(self, batch_id: uuid.UUID) -> list[Video]:
        stmt = select(Video).where(Video.batch_id == batch_id)
        result = await self.db_session.execute(stmt)
        return list(result.scalars().all())
```

---

## 7. Dependency Injection — Annotated + Depends

```python
from typing import Annotated
from fastapi import Depends, Path, HTTPException

# Primitive dependencies
SessionDep = Annotated[AsyncSession, Depends(get_db)]
AuthDep = Annotated[dict, Depends(get_current_session)]
AsyncRedisDep = Annotated[aioredis.Redis, Depends(get_async_redis)]
S3ClientDep = Annotated[S3Client, Depends(get_s3_client)]
ValidatedFileDep = Annotated[ValidatedFile, Depends(ValidateUpload())]

# Service dependencies (auto-resolved via __init__ type hints)
StorageDep = Annotated[StorageService, Depends()]
EventServiceDep = Annotated[EventService, Depends()]
VideoCrudDep = Annotated[VideoCrud, Depends()]

# Resource fetcher dependency (404 guard)
async def get_video_or_404(
    video_id: uuid.UUID = Path(),
    crud: VideoCrud = Depends(),
) -> Video:
    video = await crud.get(video_id)
    if not video:
        raise HTTPException(status_code=404, detail="Video not found")
    return video

VideoDep = Annotated[Video, Depends(get_video_or_404)]
```

**Usage in routes:**

```python
@router.get("/{video_id}", response_model=VideoRead)
async def get_video(video: VideoDep, auth: AuthDep) -> VideoRead:
    return VideoRead.model_validate(video)
```

---

## 8. Route Patterns

```python
from fastapi import APIRouter, Depends, Query

router = APIRouter(
    prefix="/videos",
    tags=["videos"],
    dependencies=[Depends(get_current_session)],  # Auth guard on all routes
)

@router.get("/", response_model=PageResponse[VideoRead])
async def list_videos(
    crud: VideoCrudDep,
    page: int = Query(default=1, ge=1),
    page_size: int = Query(default=50, ge=1, le=100),
) -> PageResponse[VideoRead]:
    page_resp = await crud.get_multi(page=page, page_size=page_size)
    page_resp.items = [VideoRead.model_validate(v) for v in page_resp.items]
    return page_resp

@router.post("/", response_model=VideoRead, status_code=201)
async def create_video(body: VideoCreate, crud: VideoCrudDep) -> VideoRead:
    video = await crud.create(body)
    return VideoRead.model_validate(video)

@router.patch("/{video_id}", response_model=VideoRead)
async def update_video(video: VideoDep, body: VideoUpdate, crud: VideoCrudDep) -> VideoRead:
    updated = await crud.update(video.id, body)
    return VideoRead.model_validate(updated)

@router.delete("/{video_id}", status_code=204)
async def delete_video(video: VideoDep, crud: VideoCrudDep) -> None:
    await crud.delete(video.id)
```

---

## 9. Global Exception Handlers

```python
from fastapi import FastAPI, HTTPException, Request
from fastapi.exceptions import RequestValidationError
from fastapi.responses import JSONResponse

def register_exception_handlers(app: FastAPI) -> None:

    @app.exception_handler(HTTPException)
    async def http_exception_handler(request: Request, exc: HTTPException) -> JSONResponse:
        return JSONResponse(
            status_code=exc.status_code,
            content=ErrorResponse(message=str(exc.detail)).model_dump(),
        )

    @app.exception_handler(RequestValidationError)
    async def validation_exception_handler(request: Request, exc: RequestValidationError) -> JSONResponse:
        return JSONResponse(
            status_code=422,
            content=ErrorResponse(message="Validation error", detail=exc.errors()).model_dump(),
        )

    @app.exception_handler(Exception)
    async def unhandled_exception_handler(request: Request, exc: Exception) -> JSONResponse:
        logger.exception("Unhandled exception: %s", exc)
        return JSONResponse(
            status_code=500,
            content=ErrorResponse(message="Internal server error").model_dump(),
        )
```

---

## 10. Custom Exception Hierarchy

```python
class PipelineError(Exception):
    """Base exception for all pipeline-related errors."""

class PipelineStageError(PipelineError):
    def __init__(self, stage: str, message: str) -> None:
        self.stage = stage
        super().__init__(f"{stage}: {message}")

class StorageError(PipelineError):
    def __init__(self, operation: str, key: str, cause: Exception | None = None) -> None:
        self.operation = operation
        self.key = key
        self.cause = cause
        super().__init__(f"Storage {operation} failed for '{key}'")
```

---

## 11. Auth — Signed Cookie Sessions

```python
from itsdangerous import BadSignature, SignatureExpired, URLSafeTimedSerializer

def get_serializer() -> URLSafeTimedSerializer:
    return URLSafeTimedSerializer(settings.SECRET_KEY)

SerializerDep = Annotated[URLSafeTimedSerializer, Depends(get_serializer)]

def get_current_session(
    serializer: SerializerDep,
    session: str | None = Cookie(default=None),
) -> dict:
    if session is None:
        raise HTTPException(status_code=401, detail="Not authenticated")
    try:
        data: dict = serializer.loads(session, max_age=settings.SESSION_MAX_AGE)
    except SignatureExpired:
        raise HTTPException(status_code=401, detail="Session expired")
    except BadSignature:
        raise HTTPException(status_code=401, detail="Invalid session")
    return data

AuthDep = Annotated[dict, Depends(get_current_session)]

def create_session_cookie(serializer: URLSafeTimedSerializer, data: dict) -> str:
    return serializer.dumps(data)
```

---

## 12. Redis — Dual Pool Pattern

```python
import redis
import redis.asyncio as aioredis

# Sync pool (non-async usage)
sync_pool = redis.ConnectionPool.from_url(settings.CELERY_BROKER_URL)

# Async pool for FastAPI (single event loop, safe to reuse)
async_pool = aioredis.ConnectionPool.from_url(settings.CELERY_BROKER_URL)

async def get_async_redis():
    """FastAPI dependency — shared pool."""
    client = aioredis.Redis(connection_pool=async_pool)
    try:
        yield client
    finally:
        await client.aclose()

def create_async_redis() -> aioredis.Redis:
    """Celery tasks — standalone client, caller must aclose()."""
    return aioredis.from_url(settings.CELERY_BROKER_URL)

async def shutdown_redis() -> None:
    await async_pool.aclose()
    sync_pool.disconnect()

AsyncRedisDep = Annotated[aioredis.Redis, Depends(get_async_redis)]
```

**Rule:** Never import `async_pool` in Celery tasks. Always use `create_async_redis()`.

---

## 13. S3 Storage — Protocol + Service + Retry

### Client (Protocol for type safety)

```python
from typing import Annotated, Protocol, runtime_checkable
import boto3

@runtime_checkable
class S3Client(Protocol):
    def put_object(self, *, Bucket: str, Key: str, Body: bytes, ContentType: str) -> dict: ...
    def get_object(self, *, Bucket: str, Key: str) -> dict: ...
    def generate_presigned_url(self, method: str, Params: dict, ExpiresIn: int) -> str: ...
    def delete_object(self, *, Bucket: str, Key: str) -> dict: ...
    def delete_objects(self, *, Bucket: str, Delete: dict) -> dict: ...
    def get_paginator(self, operation: str) -> object: ...

s3_client: S3Client = boto3.client(
    "s3",
    endpoint_url=settings.S3_ENDPOINT,
    aws_access_key_id=settings.S3_ACCESS_KEY_ID,
    aws_secret_access_key=settings.S3_SECRET_ACCESS_KEY,
    region_name=settings.S3_REGION,
)

S3ClientDep = Annotated[S3Client, Depends(get_s3_client)]
```

### File Upload Validation (Dependency Factory)

```python
from dataclasses import dataclass
from pathlib import PurePosixPath

@dataclass(frozen=True, slots=True)
class ValidatedFile:
    filename: str
    contents: bytes
    extension: str

def ValidateUpload(
    allowed_extensions: set[str] = settings.UPLOAD_ALLOWED_EXTENSIONS,
    max_size_bytes: int = settings.UPLOAD_MAX_FILE_SIZE,
):
    async def _validate(file: UploadFile) -> ValidatedFile:
        if not file.filename:
            raise HTTPException(400, "Filename is required")
        ext = PurePosixPath(file.filename).suffix.lower()
        if ext not in allowed_extensions:
            raise HTTPException(400, f"Unsupported: {ext}. Allowed: {', '.join(sorted(allowed_extensions))}")
        contents = await file.read()
        if len(contents) > max_size_bytes:
            raise HTTPException(400, f"File too large. Max {max_size_bytes // 1024 // 1024}MB")
        return ValidatedFile(filename=file.filename, contents=contents, extension=ext)
    return _validate

ValidatedFileDep = Annotated[ValidatedFile, Depends(ValidateUpload())]
```

### Storage Service (with retry)

```python
class StorageService:
    def __init__(self, client: S3ClientDep) -> None:
        self._client = client
        self._bucket = settings.S3_BUCKET_NAME

    @pipeline_retry()
    def upload_file(self, key: str, data: bytes, content_type: str) -> None:
        try:
            self._client.put_object(Bucket=self._bucket, Key=key, Body=data, ContentType=content_type)
        except Exception as e:
            raise StorageError("upload", key, cause=e) from e

    @pipeline_retry()
    def download_file(self, key: str) -> bytes:
        try:
            response = self._client.get_object(Bucket=self._bucket, Key=key)
            return response["Body"].read()
        except Exception as e:
            raise StorageError("download", key, cause=e) from e

    def stream_file(self, key: str, chunk_size: int = 1024 * 1024) -> Generator[bytes, None, None]:
        response = self._client.get_object(Bucket=self._bucket, Key=key)
        body = response["Body"]
        while chunk := body.read(chunk_size):
            yield chunk

    def generate_presigned_url(self, key: str, expires_in: int = 3600) -> str:
        return self._client.generate_presigned_url(
            "get_object",
            Params={"Bucket": self._bucket, "Key": key},
            ExpiresIn=expires_in,
        )

    def stream_zip(self, files: list[tuple[str, str]]) -> Generator[bytes, None, None]:
        buffer = io.BytesIO()
        with zipfile.ZipFile(buffer, "w", zipfile.ZIP_DEFLATED) as zf:
            for s3_key, archive_name in files:
                try:
                    zf.writestr(archive_name, self.download_file(s3_key))
                except Exception:
                    logger.warning("ZIP: failed to download %s", s3_key)
        buffer.seek(0)
        yield buffer.read()

    def delete_prefix(self, prefix: str) -> int:
        deleted = 0
        paginator = self._client.get_paginator("list_objects_v2")
        for page in paginator.paginate(Bucket=self._bucket, Prefix=prefix):
            objects = page.get("Contents", [])
            if not objects:
                continue
            self._client.delete_objects(
                Bucket=self._bucket,
                Delete={"Objects": [{"Key": obj["Key"]} for obj in objects]},
            )
            deleted += len(objects)
        return deleted

StorageDep = Annotated[StorageService, Depends()]
```

---

## 14. Celery — Async Task Decorator + Task Context

### Async Task Decorator

```python
from asgiref.sync import async_to_sync
from celery import Celery, Task
from functools import wraps
from typing import ParamSpec, TypeVar

_P = ParamSpec("_P")
_R = TypeVar("_R")

def async_task(app: Celery, *args, **kwargs):
    """Register async functions as Celery tasks via asgiref."""
    def _decorator(func):
        sync_call = async_to_sync(func)
        @app.task(*args, **kwargs)
        @wraps(func)
        def _decorated(*args, **kwargs):
            return sync_call(*args, **kwargs)
        return _decorated
    return _decorator
```

### Task Context (DI for background tasks)

```python
from dataclasses import dataclass
from contextlib import asynccontextmanager

@dataclass
class TaskContext:
    session: AsyncSession
    storage: StorageService
    events: EventService

@asynccontextmanager
async def task_context() -> AsyncGenerator[TaskContext, None]:
    redis_client = create_async_redis()
    try:
        async with async_session_factory() as session:
            yield TaskContext(
                session=session,
                storage=StorageService(s3_client),
                events=EventService(redis_client),
            )
    finally:
        await redis_client.aclose()
```

### Usage

```python
@async_task(celery_app, bind=True, max_retries=0)
async def process_video(self, video_data: dict, batch_id: str | None = None) -> dict:
    async with task_context() as ctx:
        service = VideoService(session=ctx.session, storage=ctx.storage, events=ctx.events)
        result = await service.generate(VideoCreate.model_validate(video_data))
        return result.model_dump()
```

### Celery App Config

```python
celery_app = Celery(
    "worker",
    broker=settings.CELERY_BROKER_URL,
    backend=settings.CELERY_RESULT_BACKEND,
    include=["api.deps.tasks", "api.videos.tasks"],
)

celery_app.conf.update(
    task_serializer="json",
    accept_content=["json", "pydantic_json"],
    result_serializer="pydantic_json",
    timezone="UTC",
    enable_utc=True,
    task_track_started=True,
    task_time_limit=settings.CELERY_TASK_TIME_LIMIT,
    task_soft_time_limit=settings.CELERY_TASK_SOFT_TIME_LIMIT,
    worker_prefetch_multiplier=4,
    worker_max_tasks_per_child=1000,
    result_expires=3600,
    beat_schedule={
        "cleanup-expired": {
            "task": "api.deps.tasks.cleanup_expired",
            "schedule": 86400,
        },
    },
)
```

---

## 15. Events — SSE via Redis Pub/Sub

```python
class EventService:
    def __init__(self, client: AsyncRedisDep) -> None:
        self._client = client

    async def emit(self, channel: str, event: BaseModel) -> None:
        await self._client.publish(channel, event.model_dump_json())

    async def subscribe(self, channel: str, schema: type[BaseModel]) -> AsyncGenerator[BaseModel, None]:
        pubsub = self._client.pubsub()
        try:
            await pubsub.subscribe(channel)
            async for message in pubsub.listen():
                if message["type"] != "message":
                    continue
                try:
                    yield schema.model_validate_json(message["data"])
                except (ValidationError, ValueError):
                    logger.warning("Invalid event on %s", channel)
        finally:
            await pubsub.unsubscribe(channel)
            await pubsub.close()

EventServiceDep = Annotated[EventService, Depends()]
```

---

## 16. Service Layer Pattern

```python
class VideoService:
    """Orchestrates business logic. All dependencies via constructor."""

    def __init__(
        self,
        session: AsyncSession,
        storage: StorageService,
        events: EventService,
        video_crud: VideoCrud,
        tts: TTSService,
        segmentation: SegmentationService,
    ) -> None:
        self._session = session
        self._storage = storage
        self._events = events
        self._video_crud = video_crud
        self._tts = tts
        self._segmentation = segmentation

    async def generate(self, video_input: VideoCreate) -> VideoGenerationResult:
        video = await self._video_crud.create(video_input)
        await self._emit_progress(video)
        try:
            return await self._run_pipeline(video)
        except Exception as error:
            await self._handle_failure(video, error)
            raise

    async def _handle_failure(self, video: Video, error: Exception) -> None:
        logger.error("Video %s failed at %s: %s", video.id, video.current_stage, error)
        video.status = VideoStatus.failed
        video.error_message = f"Failed at {video.current_stage}: {error}"
        await self._session.commit()
        await self._emit_progress(video)
```

**Rule:** Services own orchestration. CRUDs own data access. Routes are thin — they wire dependencies and return responses.

---

## 17. Enum Pattern for Status Fields

```python
import enum

class VideoStatus(str, enum.Enum):
    processing = "processing"
    finished = "finished"
    failed = "failed"
    expired = "expired"

class VideoStage(str, enum.Enum):
    queued = "queued"
    tts = "tts"
    segmentation = "segmentation"
    image_gen = "image_gen"
    assembly = "assembly"
    done = "done"
```

**Why `str, enum.Enum`:**
- SQLAlchemy stores the string value directly
- Pydantic serializes/deserializes automatically
- Orval generates TypeScript enums from the OpenAPI spec
- Never use string literals in queries — always `VideoStatus.processing`

---

## 18. Migrations — Alembic Autogenerate Only

```bash
# Generate migration from model changes
alembic revision --autogenerate -m "add file_size column to videos"

# Apply migrations
alembic upgrade head
```

**Rule:** Never hand-write migration files. Model changes → autogenerate → review → apply.
