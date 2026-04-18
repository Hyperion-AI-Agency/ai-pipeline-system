# Claude Agent SOP — LLM Guide for Building Applications

> Standard operating procedures for Claude Code when building fullstack applications.
> Drop this into `.claude/` as part of CLAUDE.md or reference it as a doc.

---

## 1. Mandatory Workflow

Never jump straight to code. Always follow this sequence:

```
/prime → /plan → Review → /implement
```

1. **Prime** — Read project docs, understand architecture, current state
2. **Plan** — Design implementation with file-level specificity, get user approval
3. **Implement** — Execute the plan, write tests first (TDD)

---

## 2. Project Initialization Checklist

When setting up a new project from this template:

### Backend (FastAPI)
- [ ] Copy `apps/api/` structure
- [ ] Configure `settings.py` with `env_prefix="API_"`
- [ ] Set up `core/models.py` (BaseModel with timestamps)
- [ ] Set up `core/crud.py` (Generic BaseCrud)
- [ ] Set up `core/schemas.py` (PageResponse, ErrorResponse)
- [ ] Set up `deps/db.py` (dual engine: pooled for FastAPI, NullPool for Celery)
- [ ] Set up `deps/auth.py` (cookie sessions with itsdangerous)
- [ ] Set up `deps/redis.py` (dual pool: shared for FastAPI, standalone for Celery)
- [ ] Set up `deps/storage.py` (S3 Protocol + ValidateUpload)
- [ ] Set up `deps/celery.py` (async_task decorator + TaskContext)
- [ ] Set up `exceptions.py` (global handlers)
- [ ] Set up `app.py` (application factory with lifespan)
- [ ] Create `.env.example`
- [ ] Initialize Alembic: `alembic init migrations`

### Frontend (React)
- [ ] Scaffold with Vite + React + SWC
- [ ] Install TanStack Router (file-based routing)
- [ ] Install TanStack Query (React Query)
- [ ] Set up shadcn/ui components
- [ ] Configure Orval for API client generation
- [ ] Set up `global.css` with @theme tokens and CSS variables
- [ ] Create auth guard (`beforeLoad` pattern)
- [ ] Create root layout (Toaster, sidebar)
- [ ] Set up custom Axios instance with 401 interceptor

### Infrastructure
- [ ] Set up pnpm workspace + Turborepo
- [ ] Create `docker-compose.local.yml` (Postgres, Redis, Traefik)
- [ ] Create `docker-compose.prod.yml` (with Let's Encrypt)
- [ ] Set up GitHub Actions CI (tests, lint, type check)
- [ ] Configure semantic-release

---

## 3. Adding a New Domain/Feature

Follow this exact order:

### Step 1: Backend Model
```
api/{domain}/models/{entity}.py
```
- Extend `BaseModel` (gets timestamps automatically)
- UUID primary key with `default=uuid.uuid4`
- Use `str, enum.Enum` for status fields
- Define relationships with `cascade="all, delete-orphan"`

### Step 2: Backend Schema
```
api/{domain}/schemas.py
```
- `{Entity}Create` — required fields, validation
- `{Entity}Update` — all fields optional (for PATCH)
- `{Entity}Read` — full response with `model_config = {"from_attributes": True}`

### Step 3: Backend CRUD
```
api/{domain}/crud.py
```
- Extend `BaseCrud[Model, CreateSchema, UpdateSchema]`
- Add domain-specific queries as methods

### Step 4: Backend Routes
```
api/{domain}/routes.py
```
- Create `APIRouter` with prefix, tags, auth dependency
- Use typed dependencies: `CrudDep`, `AuthDep`, `VideoDep`
- Standard endpoints: GET (list + detail), POST, PATCH, DELETE

### Step 5: Migration
```bash
alembic revision --autogenerate -m "add {entity} table"
alembic upgrade head
```

### Step 6: Register Router
```python
# app.py
app.include_router(new_router, prefix=API_V1_STR)
```

### Step 7: Regenerate API Client
```bash
pnpm run generate-api
```

### Step 8: Frontend Page
```
apps/react/src/routes/app/{domain}/
├── index.tsx           # List page
├── $entityId.tsx       # Detail page
└── _components/        # Route-specific components
```

### Step 9: Tests
- Backend: `apps/api/__tests__/test_{domain}.py`
- E2E: `apps/react/e2e/{domain}.spec.ts`

---

## 4. Code Quality Rules

### Python
- **No `Any` types** — use Protocols or proper types
- **Ruff** for linting + formatting (line-length 88)
- **MyPy strict** for type checking
- **Alembic autogenerate only** — never hand-write migrations
- **`str, enum.Enum`** for all status/stage fields
- **Async everywhere** — routes, CRUD, services
- **Services own logic, CRUDs own data, routes are thin**
- **Constructor injection** — services receive all deps via `__init__`

### TypeScript
- **Strict mode** — no `any`
- **Orval hooks** for all API calls — no hardcoded URLs
- **lucide-react** for icons — never custom SVGs
- **recharts** for charts — never custom SVG charts
- **sonner** for toasts — not shadcn wrapper
- **Route-specific `_components/`** — co-locate with routes
- **CSS variables + @theme tokens** — no inline styles

### General
- **Conventional Commits** — `feat:`, `fix:`, `chore:`, `refactor:`
- **TDD** — tests before implementation
- **No over-engineering** — only build what's needed now

---

## 5. Dependency Injection Cheat Sheet

```python
# Pattern: Annotated[Type, Depends(provider)]

# Database session
SessionDep = Annotated[AsyncSession, Depends(get_db)]

# Auth guard
AuthDep = Annotated[dict, Depends(get_current_session)]

# Redis client
AsyncRedisDep = Annotated[aioredis.Redis, Depends(get_async_redis)]

# S3 client
S3ClientDep = Annotated[S3Client, Depends(get_s3_client)]

# File validation (factory pattern)
ValidatedFileDep = Annotated[ValidatedFile, Depends(ValidateUpload())]

# Services (auto-resolved via __init__ type hints)
StorageDep = Annotated[StorageService, Depends()]
EventServiceDep = Annotated[EventService, Depends()]

# Resource fetcher (404 guard)
async def get_entity_or_404(entity_id: uuid.UUID = Path(), crud: EntityCrud = Depends()) -> Entity:
    entity = await crud.get(entity_id)
    if not entity:
        raise HTTPException(status_code=404, detail="Not found")
    return entity

EntityDep = Annotated[Entity, Depends(get_entity_or_404)]
```

---

## 6. Celery Task Checklist

When adding a new background task:

1. Define the task with `@async_task` decorator
2. Use `task_context()` for DB, storage, events access
3. Never import `async_pool` — use `create_async_redis()` in tasks
4. Register the task module in `celery_app` `include` list
5. For scheduled tasks, add to `beat_schedule` in celery config
6. Log at each stage transition for observability
7. Handle failures gracefully — update status, log error, emit progress

```python
@async_task(celery_app, bind=True, max_retries=0)
async def process_entity(self, entity_data: dict) -> dict:
    async with task_context() as ctx:
        entity = EntityCreate.model_validate(entity_data)
        service = EntityService(session=ctx.session, storage=ctx.storage)
        try:
            result = await service.process(entity)
            return result.model_dump()
        except Exception as error:
            logger.error("Failed: %s", error)
            raise
```

---

## 7. File Naming Conventions

| Type | Convention | Example |
|------|-----------|---------|
| Python module | `snake_case.py` | `video_service.py` |
| Python class | `PascalCase` | `VideoService` |
| React component | `kebab-case.tsx` | `video-header.tsx` |
| React component (export) | `PascalCase` | `export function VideoHeader()` |
| Hook | `use-{name}.ts` | `use-event-source.ts` |
| Utility | `{name}.ts` | `format.ts` |
| Route | TanStack file convention | `$videoId.tsx`, `_components/` |
| Test (Python) | `test_{module}.py` | `test_videos.py` |
| Test (TS) | `{name}.test.tsx` | `video-header.test.tsx` |
| E2E test | `{feature}.spec.ts` | `videos.spec.ts` |
| Enum | `PascalCase(str, enum.Enum)` | `VideoStatus` |
| API route | kebab-case URL | `/api/v1/videos` |

---

## 8. Error Handling Strategy

### Backend

```
Exception hierarchy:
  PipelineError (base)
  ├── PipelineStageError(stage, message)
  ├── StorageError(operation, key, cause)
  └── BatchParseError

Global handlers catch:
  HTTPException → ErrorResponse JSON
  RequestValidationError → ErrorResponse with detail
  Exception → 500 + log traceback
```

### Frontend

```
Orval mutation → onError callback → toast.error()
401 response → Axios interceptor → redirect to /login
Network error → React Query retry (3x)
```

---

## 9. Common Commands

```bash
# Development
pnpm dev                         # Start all apps (Turbo)
pnpm build                       # Build everything
pnpm lint                        # Lint all packages
pnpm test                        # Run all tests

# Backend
poetry run pytest                # Backend tests
poetry run pytest --cov          # With coverage
alembic revision --autogenerate -m "msg"  # New migration
alembic upgrade head             # Apply migrations

# API Client
pnpm run generate-api            # Regenerate from OpenAPI spec

# Docker
docker compose -f docker-compose.local.yml up -d  # Local infra
docker compose -f docker-compose.prod.yml up -d    # Production

# Git
git checkout -b hyp-123-feature  # New feature branch
```

---

## 10. Anti-Patterns to Avoid

| Don't | Do Instead |
|-------|-----------|
| Hardcode API URLs | Use Orval-generated hooks |
| Use `any` / `Any` types | Use Protocols, proper types |
| Hand-write migrations | `alembic revision --autogenerate` |
| Create custom SVGs | Use lucide-react / recharts |
| Use shadcn toast | Use sonner directly |
| Import `async_pool` in Celery | Use `create_async_redis()` |
| Put route components in `components/` | Use `_components/` next to route |
| Use inline `style={{}}` | Use Tailwind utility classes |
| Use string literals for status | Use `str, enum.Enum` |
| Put auth logic in QueryClient | Use route `beforeLoad` guards |
| Write tests after code | TDD — tests first |
| Use `redirect()` in axios interceptors | Only hard redirect on 401 |
| Add unnecessary abstractions | Keep it simple, build what's needed |
| Skip `/prime → /plan → /implement` | Always follow the workflow |
