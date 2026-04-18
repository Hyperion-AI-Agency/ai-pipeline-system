# SOP: Integration Testing

Standard operating procedure for writing integration tests in the Lead Alliances Video Pipeline.

**Tech stack:** FastAPI + SQLAlchemy (async) + Celery + Redis + PostgreSQL + Pydantic v2 | React + Vitest + React Testing Library + TanStack Query

---

## 1. When to Use Integration Tests

Integration tests verify that multiple components work together correctly. They sit between unit tests (fast, isolated) and E2E tests (slow, full-stack).

| Test Type | Speed | Dependencies | Use for |
|---|---|---|---|
| **Unit** | Fast (<1ms) | None (all mocked) | Pure logic, validation, transformations |
| **Integration** | Medium (10-500ms) | Real DB, mocked external APIs | CRUD + routes, service orchestration, task workflows |
| **E2E** | Slow (1-10s) | Full frontend + mocked API | User flows, navigation, auth transitions |

### Use Integration Tests For

- **API route testing:** Request -> route handler -> CRUD -> DB -> response
- **Service layer with real DB:** BatchService creating records, VideoService updating counters
- **Celery task logic with DB:** Task reads/writes to DB but uses mocked external APIs (S3, TTS, etc.)
- **Redis pub/sub events:** EventService emitting and receiving events
- **Connected React components:** Components wired to React Query with mocked API responses

### Do NOT Use Integration Tests For

- Pure function logic (use unit tests)
- Full user flows spanning multiple pages (use E2E tests)
- External API behavior (use unit tests with mocks)
- CSS/visual regression (use E2E screenshots or Storybook)

---

## 2. Backend Integration: Testing with Real DB

### Test Database Setup

#### conftest.py for Database Tests

```python
# apps/api/__tests__/integration/conftest.py
import asyncio
import uuid
from collections.abc import AsyncGenerator

import pytest
from sqlalchemy import text
from sqlalchemy.ext.asyncio import (
    AsyncSession,
    async_sessionmaker,
    create_async_engine,
)

from api.core.models import BaseModel as SQLABaseModel

# Use a dedicated test database
TEST_DATABASE_URL = "postgresql+asyncpg://postgres:postgres@localhost:5432/api_test"


@pytest.fixture(scope="session")
def event_loop():
    """Create a single event loop for the entire test session."""
    loop = asyncio.new_event_loop()
    yield loop
    loop.close()


@pytest.fixture(scope="session")
async def engine():
    """Create the test database engine (once per session)."""
    engine = create_async_engine(TEST_DATABASE_URL, echo=False)
    async with engine.begin() as conn:
        await conn.run_sync(SQLABaseModel.metadata.create_all)
    yield engine
    async with engine.begin() as conn:
        await conn.run_sync(SQLABaseModel.metadata.drop_all)
    await engine.dispose()


@pytest.fixture
async def db_session(engine) -> AsyncGenerator[AsyncSession, None]:
    """Provide a transactional session that rolls back after each test."""
    async_session = async_sessionmaker(engine, expire_on_commit=False)
    async with async_session() as session:
        async with session.begin():
            yield session
            await session.rollback()
```

**Key design decisions:**

1. **Session-scoped engine:** Creating the engine and running `metadata.create_all` once is expensive. Do it once per test session.
2. **Per-test session with rollback:** Each test gets a fresh session wrapped in a transaction that rolls back. This ensures complete data isolation without the cost of re-creating tables.
3. **Separate test database:** Never run integration tests against the development database. Use `api_test` or a dynamically-created database.

### Database Fixtures for Test Data

```python
# apps/api/__tests__/integration/conftest.py (continued)

from api.batches.models.batch import Batch
from api.batches.enums import BatchStatus
from api.videos.models.video import Video
from api.videos.enums import VideoStatus, VideoStage


@pytest.fixture
async def sample_batch(db_session: AsyncSession) -> Batch:
    """Insert a sample batch into the test database."""
    batch = Batch(
        name="Integration Test Batch",
        status=BatchStatus.processing,
        total_videos=3,
        column_mapping={"script": "script_text"},
        file_name="test.xlsx",
        file_key="batches/test/original.xlsx",
    )
    db_session.add(batch)
    await db_session.flush()
    return batch


@pytest.fixture
async def sample_video(db_session: AsyncSession, sample_batch: Batch) -> Video:
    """Insert a sample video linked to the sample batch."""
    video = Video(
        batch_id=sample_batch.id,
        script_text="Integration test script",
        voice_id="rachel",
        status=VideoStatus.processing,
        current_stage=VideoStage.queued,
    )
    db_session.add(video)
    await db_session.flush()
    return video
```

---

## 3. API Route Testing with TestClient

### Setup

FastAPI's `TestClient` (or `httpx.AsyncClient`) allows testing route handlers with real request/response cycles.

```python
# apps/api/__tests__/integration/conftest.py (continued)
from httpx import ASGITransport, AsyncClient

from api.app import create_app
from api.deps.auth import get_current_session
from api.deps.db import get_session


@pytest.fixture
async def app(db_session: AsyncSession):
    """Create a FastAPI app with the test DB session injected."""
    app = create_app()

    # Override DB session dependency
    async def override_get_session():
        yield db_session

    # Override auth dependency (bypass for integration tests)
    async def override_get_current_session():
        return True

    app.dependency_overrides[get_session] = override_get_session
    app.dependency_overrides[get_current_session] = override_get_current_session

    yield app
    app.dependency_overrides.clear()


@pytest.fixture
async def client(app) -> AsyncGenerator[AsyncClient, None]:
    """Async HTTP client for testing routes."""
    async with AsyncClient(
        transport=ASGITransport(app=app),
        base_url="http://test",
    ) as client:
        yield client
```

### Route Test Examples

```python
# apps/api/__tests__/integration/test_batch_routes.py

async def test_list_batches_returns_empty_page(client: AsyncClient):
    """GET /batches returns empty paginated response when no batches exist."""
    response = await client.get("/api/v1/batches/")
    assert response.status_code == 200

    data = response.json()
    assert data["items"] == []
    assert data["total"] == 0
    assert data["page"] == 1


async def test_list_batches_returns_created_batch(
    client: AsyncClient, sample_batch: Batch
):
    """GET /batches returns batches that exist in the database."""
    response = await client.get("/api/v1/batches/")
    assert response.status_code == 200

    data = response.json()
    assert data["total"] == 1
    assert data["items"][0]["name"] == "Integration Test Batch"
    assert data["items"][0]["id"] == str(sample_batch.id)


async def test_get_batch_returns_404_for_missing_id(client: AsyncClient):
    """GET /batches/{id} returns 404 for non-existent batch."""
    fake_id = uuid.uuid4()
    response = await client.get(f"/api/v1/batches/{fake_id}")
    assert response.status_code == 404


async def test_get_batch_returns_batch_detail(
    client: AsyncClient, sample_batch: Batch
):
    """GET /batches/{id} returns full batch details."""
    response = await client.get(f"/api/v1/batches/{sample_batch.id}")
    assert response.status_code == 200

    data = response.json()
    assert data["name"] == "Integration Test Batch"
    assert data["status"] == "processing"
    assert data["total_videos"] == 3


async def test_delete_batch_returns_204(
    client: AsyncClient, sample_batch: Batch
):
    """DELETE /batches/{id} deletes the batch and returns 204."""
    with patch("api.batches.routes.cleanup_batch_files") as mock_cleanup:
        response = await client.delete(f"/api/v1/batches/{sample_batch.id}")
        assert response.status_code == 204
        mock_cleanup.delay.assert_called_once_with(str(sample_batch.id))
```

### Testing Upload Routes

```python
async def test_upload_batch_creates_batch_record(
    client: AsyncClient, db_session: AsyncSession
):
    """POST /batches/upload creates a batch and returns 201."""
    # Mock storage and Celery to avoid external deps
    with (
        patch("api.batches.service.celery_app") as mock_celery,
        patch.object(StorageService, "upload_file"),
    ):
        response = await client.post(
            "/api/v1/batches/upload",
            data={
                "batch_name": "Upload Test",
                "column_mapping": '{"script": "script_text"}',
            },
            files={"file": ("test.xlsx", b"fake excel data", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")},
        )

    assert response.status_code == 201
    data = response.json()
    assert data["name"] == "Upload Test"
```

### Testing Error Responses

```python
async def test_upload_batch_rejects_invalid_column_mapping(client: AsyncClient):
    """POST /batches/upload returns 400 for invalid JSON in column_mapping."""
    response = await client.post(
        "/api/v1/batches/upload",
        data={
            "batch_name": "Bad Mapping",
            "column_mapping": "not-valid-json",
        },
        files={"file": ("test.xlsx", b"data", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")},
    )

    assert response.status_code == 400
    assert "Invalid column_mapping" in response.json()["detail"]
```

---

## 4. Testing Celery Tasks in Isolation

Celery tasks should be tested without a running worker. Mock the `task_context` to provide controlled dependencies.

### Pattern: Testing Async Celery Tasks

```python
# apps/api/__tests__/integration/test_batch_tasks.py
from unittest.mock import AsyncMock, MagicMock, patch

from api.batches.tasks import process_batch
from api.batches.enums import BatchStatus


async def test_process_batch_parses_file_and_dispatches_videos():
    """process_batch parses the uploaded file and dispatches video tasks."""
    batch_id = str(uuid.uuid4())

    mock_batch = MagicMock()
    mock_batch.id = uuid.UUID(batch_id)
    mock_batch.file_key = f"batches/{batch_id}/original.xlsx"
    mock_batch.file_name = "test.xlsx"
    mock_batch.column_mapping = {"script": "script_text"}
    mock_batch.status = BatchStatus.processing
    mock_batch.total_videos = 0
    mock_batch.pending_count = 0
    mock_batch.failed_count = 0

    mock_session = AsyncMock()
    mock_storage = MagicMock()
    mock_events = AsyncMock()

    # Mock the file download to return a valid CSV
    csv_content = b"script_text\nBuy now!\nGreat deal!"
    mock_storage.download_file.return_value = csv_content

    mock_ctx = MagicMock()
    mock_ctx.session = mock_session
    mock_ctx.storage = mock_storage
    mock_ctx.events = mock_events

    with (
        patch("api.batches.tasks.task_context") as mock_task_ctx,
        patch("api.batches.tasks.BatchCrud") as MockBatchCrud,
        patch("api.batches.tasks.process_video") as mock_process_video,
    ):
        # Setup context manager
        mock_task_ctx.return_value.__aenter__ = AsyncMock(return_value=mock_ctx)
        mock_task_ctx.return_value.__aexit__ = AsyncMock(return_value=False)

        # Setup BatchCrud
        mock_crud = AsyncMock()
        mock_crud.get.return_value = mock_batch
        mock_crud.db_session = mock_session
        MockBatchCrud.return_value = mock_crud

        # Call the underlying async function (not the Celery-wrapped version)
        # The actual Celery task wraps this with async_to_sync
        result = await process_batch.__wrapped__(None, batch_id)

    assert result.batch_id == batch_id
    assert result.videos_created > 0
    assert mock_process_video.delay.called


async def test_process_batch_handles_empty_file():
    """process_batch sets batch to failed when file has no rows."""
    batch_id = str(uuid.uuid4())

    mock_batch = MagicMock()
    mock_batch.id = uuid.UUID(batch_id)
    mock_batch.file_key = "batches/test/original.csv"
    mock_batch.file_name = "empty.csv"
    mock_batch.column_mapping = {}
    mock_batch.status = BatchStatus.processing

    mock_ctx = MagicMock()
    mock_ctx.session = AsyncMock()
    mock_ctx.storage = MagicMock()
    mock_ctx.storage.download_file.return_value = b"script_text\n"  # Headers only
    mock_ctx.events = AsyncMock()

    with (
        patch("api.batches.tasks.task_context") as mock_task_ctx,
        patch("api.batches.tasks.BatchCrud") as MockBatchCrud,
    ):
        mock_task_ctx.return_value.__aenter__ = AsyncMock(return_value=mock_ctx)
        mock_task_ctx.return_value.__aexit__ = AsyncMock(return_value=False)
        mock_crud = AsyncMock()
        mock_crud.get.return_value = mock_batch
        mock_crud.db_session = mock_ctx.session
        MockBatchCrud.return_value = mock_crud

        result = await process_batch.__wrapped__(None, batch_id)

    assert result.error is not None
    assert mock_batch.status == BatchStatus.failed
```

### Pattern: Testing Sync Celery Tasks

```python
def test_cleanup_batch_files_deletes_s3_prefix():
    """cleanup_batch_files deletes all files under the batch S3 prefix."""
    batch_id = str(uuid.uuid4())

    with patch("api.batches.tasks.StorageService") as MockStorage:
        mock_storage = MagicMock()
        mock_storage.delete_prefix.return_value = 5
        MockStorage.return_value = mock_storage

        # Call the task function directly (bypass Celery worker)
        cleanup_batch_files(batch_id)

        mock_storage.delete_prefix.assert_called_once_with(f"batches/{batch_id}/")
```

---

## 5. Testing Redis Pub/Sub Events

### EventService Integration Test

```python
# apps/api/__tests__/integration/test_event_service.py
import asyncio

import pytest
from redis.asyncio import Redis

from api.events.service import EventService
from api.batches.schemas import BatchProgressEvent


@pytest.fixture
async def redis_client():
    """Connect to a test Redis instance."""
    client = Redis.from_url("redis://localhost:6379/1")  # Use DB 1 for tests
    yield client
    await client.flushdb()
    await client.aclose()


@pytest.fixture
async def event_service(redis_client):
    return EventService(redis_client)


async def test_emit_and_subscribe_round_trip(event_service: EventService):
    """Events emitted on a channel can be received by a subscriber."""
    channel = "test:batch:abc"
    event = BatchProgressEvent(batch_id="abc", status="processing")

    received_events: list[BatchProgressEvent] = []

    async def subscribe():
        async for evt in event_service.subscribe(channel, BatchProgressEvent):
            received_events.append(evt)
            break  # Stop after receiving one event

    # Start subscriber, emit event, wait for receipt
    subscriber_task = asyncio.create_task(subscribe())
    await asyncio.sleep(0.1)  # Give subscriber time to connect
    await event_service.emit(channel, event)

    await asyncio.wait_for(subscriber_task, timeout=2.0)

    assert len(received_events) == 1
    assert received_events[0].batch_id == "abc"
    assert received_events[0].status == "processing"


async def test_subscribe_skips_invalid_events(event_service: EventService, redis_client):
    """Invalid JSON on the channel is logged and skipped, not raised."""
    channel = "test:batch:invalid"

    received_events = []

    async def subscribe():
        async for evt in event_service.subscribe(channel, BatchProgressEvent):
            received_events.append(evt)
            break

    subscriber_task = asyncio.create_task(subscribe())
    await asyncio.sleep(0.1)

    # Send invalid JSON first, then a valid event
    await redis_client.publish(channel, b"not-valid-json")
    valid_event = BatchProgressEvent(batch_id="xyz", status="completed")
    await redis_client.publish(channel, valid_event.model_dump_json())

    await asyncio.wait_for(subscriber_task, timeout=2.0)

    # Should have received only the valid event
    assert len(received_events) == 1
    assert received_events[0].batch_id == "xyz"
```

---

## 6. Frontend Integration: Connected Components with Mocked API

Frontend integration tests verify that components correctly integrate with React Query, routing, and the API client layer.

### Setup: Test Providers Wrapper

```typescript
// apps/react/src/__tests__/test-utils.tsx
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { render, type RenderOptions } from "@testing-library/react";
import type { ReactElement } from "react";

function createTestQueryClient() {
  return new QueryClient({
    defaultOptions: {
      queries: {
        retry: false,
        gcTime: 0,
        staleTime: 0,
      },
      mutations: {
        retry: false,
      },
    },
  });
}

export function renderWithProviders(
  ui: ReactElement,
  options?: Omit<RenderOptions, "wrapper">,
) {
  const queryClient = createTestQueryClient();

  function Wrapper({ children }: { children: React.ReactNode }) {
    return (
      <QueryClientProvider client={queryClient}>{children}</QueryClientProvider>
    );
  }

  return { ...render(ui, { wrapper: Wrapper, ...options }), queryClient };
}
```

### Connected Component Test

```typescript
// apps/react/src/components/dashboard/__tests__/batch-list.integration.test.tsx
import { describe, it, expect, vi, beforeEach } from "vitest";
import { screen, waitFor } from "@testing-library/react";
import { renderWithProviders } from "@/__tests__/test-utils";
import { BatchList } from "../batch-list";

// Mock the Orval-generated API hook
vi.mock("@/api/client", () => ({
  useGetBatches: vi.fn(),
}));

import { useGetBatches } from "@/api/client";

describe("BatchList (integration)", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it("renders loading skeleton while fetching", () => {
    vi.mocked(useGetBatches).mockReturnValue({
      data: undefined,
      isLoading: true,
      error: null,
    } as ReturnType<typeof useGetBatches>);

    renderWithProviders(<BatchList />);
    expect(screen.getByTestId("batch-list-skeleton")).toBeInTheDocument();
  });

  it("renders batch rows after data loads", async () => {
    vi.mocked(useGetBatches).mockReturnValue({
      data: {
        items: [
          {
            id: "abc-123",
            name: "Q1 Campaign",
            status: "completed",
            total_videos: 5,
            completed_count: 5,
            failed_count: 0,
            pending_count: 0,
          },
        ],
        total: 1,
        page: 1,
        page_size: 50,
        total_pages: 1,
      },
      isLoading: false,
      error: null,
    } as ReturnType<typeof useGetBatches>);

    renderWithProviders(<BatchList />);

    await waitFor(() => {
      expect(screen.getByText("Q1 Campaign")).toBeInTheDocument();
    });
    expect(screen.getByText("Completed")).toBeInTheDocument();
  });

  it("shows error state when query fails", async () => {
    vi.mocked(useGetBatches).mockReturnValue({
      data: undefined,
      isLoading: false,
      error: new Error("Network error"),
    } as ReturnType<typeof useGetBatches>);

    renderWithProviders(<BatchList />);

    await waitFor(() => {
      expect(screen.getByText(/error/i)).toBeInTheDocument();
    });
  });

  it("shows empty state when no batches exist", async () => {
    vi.mocked(useGetBatches).mockReturnValue({
      data: {
        items: [],
        total: 0,
        page: 1,
        page_size: 50,
        total_pages: 0,
      },
      isLoading: false,
      error: null,
    } as ReturnType<typeof useGetBatches>);

    renderWithProviders(<BatchList />);

    await waitFor(() => {
      expect(screen.getByText("No batches yet")).toBeInTheDocument();
    });
  });
});
```

### Testing Mutations

```typescript
import userEvent from "@testing-library/user-event";

vi.mock("@/api/client", () => ({
  useDeleteBatch: vi.fn(),
  useGetBatches: vi.fn(),
}));

import { useDeleteBatch, useGetBatches } from "@/api/client";

it("calls delete mutation and shows confirmation", async () => {
  const user = userEvent.setup();
  const mutateFn = vi.fn();

  vi.mocked(useDeleteBatch).mockReturnValue({
    mutate: mutateFn,
    isPending: false,
  } as ReturnType<typeof useDeleteBatch>);

  // Setup list data...
  vi.mocked(useGetBatches).mockReturnValue({
    data: { items: [{ id: "abc", name: "Test" }], total: 1, page: 1, page_size: 50, total_pages: 1 },
    isLoading: false,
    error: null,
  } as ReturnType<typeof useGetBatches>);

  renderWithProviders(<BatchList />);

  // Open action menu and click delete
  await user.click(screen.getByRole("button", { name: /open menu/i }));
  await user.click(screen.getByRole("menuitem", { name: /delete/i }));

  // Confirm deletion
  await user.click(screen.getByRole("button", { name: /confirm/i }));

  expect(mutateFn).toHaveBeenCalledWith("abc");
});
```

---

## 7. Test File Organization (Integration)

```
apps/api/__tests__/
  conftest.py                          # Shared unit test fixtures
  integration/
    conftest.py                        # DB engine, session, app, client fixtures
    test_batch_routes.py               # Batch API route tests
    test_video_routes.py               # Video API route tests
    test_settings_routes.py            # Settings API route tests
    test_dashboard_routes.py           # Dashboard API route tests
    test_batch_tasks.py                # Celery batch task tests
    test_video_tasks.py                # Celery video task tests
    test_event_service.py              # Redis pub/sub tests

apps/react/src/__tests__/
  test-utils.tsx                       # renderWithProviders, createTestQueryClient
  integration/
    batch-list.integration.test.tsx     # Connected component tests
    video-detail.integration.test.tsx
    settings-form.integration.test.tsx
```

---

## 8. Running Integration Tests

### Backend

```bash
# Run all tests (unit + integration)
cd apps/api && poetry run pytest

# Run only integration tests
poetry run pytest __tests__/integration/

# Run with verbose output
poetry run pytest __tests__/integration/ -v

# Run a specific test file
poetry run pytest __tests__/integration/test_batch_routes.py

# Run a specific test
poetry run pytest __tests__/integration/test_batch_routes.py::test_list_batches_returns_empty_page
```

### Frontend

```bash
# Run all tests
cd apps/react && pnpm test

# Run integration tests only
pnpm test src/__tests__/integration/

# Run in watch mode
pnpm test --watch
```

---

## 9. Prerequisites and Environment

### Backend Integration Tests Require

- **PostgreSQL:** A running instance with a `api_test` database
- **Redis:** A running instance (tests use DB 1 to avoid conflicts)
- Both can be provided via Docker Compose:

```bash
# Start test dependencies
docker compose up -d postgres redis

# Create test database
docker compose exec postgres createdb -U postgres api_test
```

### Frontend Integration Tests Require

- No external services (all API calls are mocked)
- Just `pnpm install` and `pnpm test`

---

## 10. Anti-Patterns to Avoid

| Anti-Pattern | Why it is wrong | Correct approach |
|---|---|---|
| Hitting real external APIs (S3, TTS, Gemini) | Slow, flaky, costs money | Mock external boundaries, test DB integration only |
| Sharing data between integration tests | Order-dependent failures | Use per-test session with rollback |
| Using `sleep()` for async coordination | Slow and unreliable | Use `asyncio.wait_for()` with timeouts |
| Testing DB schema creation/migration | Already covered by Alembic | Test business logic against existing schema |
| Duplicating unit test coverage | Wastes time, slower | Integration tests cover the glue; unit tests cover logic |
| Not cleaning up Redis state | Leaks between test runs | Use `flushdb()` in fixture teardown or use a test-specific DB number |
| Testing Celery task scheduling | Framework concern | Test the task function directly, mock `celery_app.send_task()` |
| Using production database URL | Data corruption risk | Always use a dedicated `api_test` database |

---

## 11. Checklist: Before Submitting Integration Tests

- [ ] Tests use the `db_session` fixture with transaction rollback (no manual cleanup)
- [ ] External APIs (S3, TTS, Gemini, ElevenLabs) are mocked -- never called
- [ ] Celery tasks are tested by calling the function directly, not via worker
- [ ] Redis tests use a separate DB number (e.g., DB 1) and `flushdb` on teardown
- [ ] FastAPI route tests use `dependency_overrides` for session and auth
- [ ] Frontend integration tests create a fresh `QueryClient` per test
- [ ] All async tests properly await their assertions
- [ ] Test database URL is not the production/development database
- [ ] Tests pass in isolation: running a single test file works without other tests
- [ ] No `test.only` or `pytest.mark.skip` left in committed code
