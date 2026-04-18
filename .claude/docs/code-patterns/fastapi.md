# FastAPI Code Patterns

> Source: [FastAPI Docs](https://fastapi.tiangolo.com/) — Bigger Applications, Dependencies, Testing

## Project Structure

```
apps/api/
├── api/
│   ├── app.py              # Application factory (create_application)
│   ├── main.py             # Entrypoint (uvicorn)
│   ├── settings.py         # Pydantic BaseSettings
│   ├── exceptions.py       # Exception handlers
│   ├── core/               # Health, root routes
│   │   ├── __init__.py
│   │   └── routes.py
│   ├── <domain>/           # Feature module (one per domain)
│   │   ├── __init__.py
│   │   ├── routes.py       # APIRouter endpoints
│   │   ├── schemas.py      # Pydantic request/response models
│   │   ├── models.py       # SQLAlchemy models
│   │   ├── crud.py         # Database operations
│   │   └── service.py      # Business logic
│   └── deps/               # Shared dependencies
│       ├── __init__.py
│       ├── db.py           # Database session
│       ├── auth.py         # Auth dependencies
│       ├── celery.py       # Celery app config
│       ├── tasks.py        # Celery task definitions
│       └── sentry.py       # Sentry init
├── __tests__/              # pytest tests
├── migrations/             # Alembic migrations
├── Dockerfile
├── pyproject.toml
└── docker-entrypoint.sh
```

## APIRouter Pattern

Each domain gets its own router with prefix and tags:

```python
# api/signals/routes.py
from fastapi import APIRouter, Depends
from api.signals.schemas import SignalResponse, SignalCreate
from api.signals.service import SignalService
from api.deps.auth import get_current_user

router = APIRouter(prefix="/signals", tags=["signals"])

@router.get("/", response_model=list[SignalResponse])
async def list_signals(user = Depends(get_current_user)):
    service = SignalService()
    return await service.get_active(user.id)

@router.post("/", response_model=SignalResponse, status_code=201)
async def create_signal(data: SignalCreate, user = Depends(get_current_user)):
    service = SignalService()
    return await service.create(data, user.id)
```

Register in app factory:

```python
# api/app.py
from api.signals.routes import router as signals_router

app.include_router(signals_router, prefix="/api/v1")
```

## Dependency Injection

### Reusable dependencies with `Depends()`

```python
from typing import Annotated
from fastapi import Depends

# Define once
async def get_db():
    async with async_session() as session:
        yield session

# Reuse everywhere
DbSession = Annotated[AsyncSession, Depends(get_db)]

@router.get("/signals/")
async def list_signals(db: DbSession):
    return await db.execute(select(Signal))
```

### Sub-dependencies (dependency chains)

```python
async def get_current_user(token: str = Depends(oauth2_scheme)):
    user = decode_token(token)
    if not user:
        raise HTTPException(status_code=401)
    return user

async def get_admin_user(user = Depends(get_current_user)):
    if not user.is_admin:
        raise HTTPException(status_code=403)
    return user

@router.delete("/signals/{id}")
async def delete_signal(id: str, admin = Depends(get_admin_user)):
    ...
```

### Global dependencies

```python
app = FastAPI(dependencies=[Depends(verify_api_key)])
```

## Pydantic Schemas

Separate request and response models:

```python
# api/signals/schemas.py
from pydantic import BaseModel
from datetime import datetime

class SignalCreate(BaseModel):
    event_name: str
    bookmaker: str
    odds: float

class SignalResponse(BaseModel):
    id: str
    event_name: str
    bookmaker: str
    odds: float
    status: str
    created_at: datetime

    model_config = {"from_attributes": True}
```

## Settings

All config via environment variables, validated by Pydantic:

```python
# api/settings.py
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_ignore_empty=True,
        extra="ignore",
        env_prefix="API_",
    )

    DATABASE_URL: PostgresDsn
    SECRET_KEY: str
    ENVIRONMENT: Literal["local", "staging", "production"] = "local"
    CELERY_BROKER_URL: str = "redis://localhost:6379/0"

settings = Settings()
```

## Celery Tasks

Define tasks in `deps/tasks.py`, import celery app from `deps/celery.py`:

```python
# api/deps/tasks.py
from api.deps.celery import celery_app

@celery_app.task(bind=True, max_retries=3)
def process_signal(self, signal_id: str):
    try:
        # business logic
        ...
    except Exception as exc:
        self.retry(exc=exc, countdown=60)
```

Dispatch from routes:

```python
from api.deps.tasks import process_signal

@router.post("/signals/")
async def create_signal(data: SignalCreate):
    signal = await crud.create(data)
    process_signal.delay(signal.id)  # async background task
    return signal
```

## Testing

Use `TestClient` for sync tests, `httpx.AsyncClient` for async:

```python
# __tests__/test_signals.py
from fastapi.testclient import TestClient
from api.app import create_application

client = TestClient(create_application())

def test_list_signals():
    response = client.get("/api/v1/signals/")
    assert response.status_code == 200
    assert isinstance(response.json(), list)

def test_create_signal_unauthorized():
    response = client.post("/api/v1/signals/", json={"event_name": "test"})
    assert response.status_code == 401
```

## Error Handling

- Raise `HTTPException` with proper status codes
- Register global exception handlers in `exceptions.py`
- Never return 500 with sensitive error details
- Log errors with structured logging, not `print()`

## Rules

- **One router per domain** — don't put signals and scanner in the same file
- **Schemas validate boundaries** — always use Pydantic for request/response
- **Dependencies for cross-cutting concerns** — auth, db, rate limiting
- **Background tasks via Celery** — never block request handlers
- **Alembic for migrations** — `alembic revision --autogenerate -m "description"`
