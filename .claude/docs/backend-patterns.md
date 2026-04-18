# Backend Code Patterns

## Async vs Sync

- **Pipeline stage services (TTS, image gen, storage, video editor) are sync.** No `asyncio.to_thread`. Celery runs `--pool=solo` with `async_task` wrapping via `asgiref.async_to_sync`.
- **DB and Redis are async** — SQLAlchemy async sessions, aioredis.
- The `async_task` decorator in `deps/celery.py` converts async Celery task functions to sync via asgiref.

## Database

- **Two engines in `deps/db.py`**: FastAPI gets a pooled engine (`pool_size=5, pool_pre_ping=True`). Celery gets a NullPool engine (`async_session_factory()`). This avoids asyncpg event loop mismatch.
- **FastAPI routes** use `SessionDep` (dependency injection via `get_db`).
- **Celery tasks** use `async with async_session_factory() as session`.
- Alembic migrations: always use `alembic revision --autogenerate`, never hand-write.

## Module Structure

Each domain (videos, batches, shots) follows:

```
domain/
├── models/        # SQLAlchemy models
├── schemas.py     # Pydantic request/response schemas
├── routes.py      # FastAPI router
├── crud.py        # DB operations (extends BaseCrud)
├── enums.py       # str enums for status fields
└── service.py     # business logic (if needed)
```

## Service Pattern

Services receive all dependencies via constructor (no global imports of clients):

```python
class VideoService:
    def __init__(self, session, storage, events, tts, segmentation, shots, editor):
        ...
```

Wired in `pipeline/tasks.py` where everything is instantiated. This makes services testable — tests pass mocks.

## Settings

- All config in `api/settings.py` as a single Pydantic `Settings` class with `env_prefix="API_"`.
- Production validator ensures required secrets are set when `ENVIRONMENT != "local"`.
- API keys are read from settings and **passed as constructor args** to services, not read inside services.

## Error Handling

- Pipeline failures: `PipelineStageError(stage, message)` — includes which stage failed.
- Storage failures: `StorageError(operation, key)`.
- `generate_video` catches all exceptions, marks video as `failed` with the error message, cleans up R2 artifacts, emits SSE, updates batch counters, then re-raises.

## Rate Limiting

- `slowapi` with per-endpoint limits: auth login `10/min`, upload `5/min`, export-zip `3/min`, default `60/min`.
- Limiter defined in `api/rate_limit.py`, attached to app in `app.py`.
- Rate-limited endpoints need `request: Request` as first param (required by slowapi).

## File Downloads

Use `StreamingResponse` with a generator for file exports (ZIPs, etc.) — don't buffer the entire response in memory:

```python
def generate_zip():
    buffer = io.BytesIO()
    with zipfile.ZipFile(buffer, "w", zipfile.ZIP_DEFLATED) as zf:
        for index, video in enumerate(finished, 1):
            try:
                data = storage.download_file(r2_key)
                zf.writestr(f"video-{index:03d}-{str(video.id)[:8]}.mp4", data)
            except Exception as error:
                logger.warning("Failed to download video %s: %s", video.id, error)
                continue
    buffer.seek(0)
    yield buffer.read()

return StreamingResponse(generate_zip(), media_type="application/zip", headers={...})
```

Validate inputs and check for empty results *before* the generator — raise `HTTPException` early so errors aren't swallowed inside the stream.

## Function Design

- **One function, one job.** A function that resolves a value must not also mutate an object. A function that saves to DB must not also emit events. Keep side effects in the caller, keep helpers pure.
- Every function must have a docstring.

## Schema Design

- **Schemas own their formatting.** If a schema needs a string representation (for prompts, logs, etc.), put the method on the schema — not in the caller. Example: `WordTimestamp.to_indexed_str(index)`, `SegmentationInput.build_prompt()`.
- **Schemas own their construction from external data.** Factory classmethods like `AICost.from_chain_result(result)` or `Video.from_parsed_row(row, batch_id)` keep parsing logic on the schema, not scattered across services.
- **Input schemas bundle related params.** When a function takes 4+ related params, bundle them into an input schema (e.g. `SegmentationInput` instead of `script_text, word_timestamps, style, prompt, template_context`).

## Type Annotations

- No `Any` types. Use `Protocol` classes for external clients (e.g., `S3Client` in `deps/storage.py`).
- **Never use string annotations** for types — always `list[Video]`, never `list["Video"]`. Import the type directly.
- **All variable names must be descriptive** — never `r`, `i`, `t`, `e`, `v`, `b`. Use `row`, `index`, `totals`, `error`, `video`, `batch`. Single-letter names are only acceptable in list comprehensions over obvious contexts (e.g. `[s.cost for s in shots]`).
- Result models use `model_config = {"frozen": True}`.
