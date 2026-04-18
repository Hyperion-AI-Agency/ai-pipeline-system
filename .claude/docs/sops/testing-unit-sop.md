# SOP: Unit Testing (Backend pytest + Frontend Vitest)

Standard operating procedure for writing unit tests in the Lead Alliances Video Pipeline.

---

## Part A: Backend Unit Testing (pytest)

**Tech stack:** FastAPI + SQLAlchemy (async) + Celery + Pydantic v2 + pytest + pytest-asyncio

**Key paths:**
- `apps/api/__tests__/` -- test directory
- `apps/api/api/core/crud.py` -- `BaseCrud` (generic CRUD operations)
- `apps/api/api/core/schemas.py` -- `PageResponse`, `AICost`, `ErrorResponse`
- `apps/api/api/videos/service.py` -- `VideoService` (pipeline orchestrator)
- `apps/api/api/batches/service.py` -- `BatchService`
- `apps/api/api/events/service.py` -- `EventService` (Redis pub/sub)
- `apps/api/api/settings.py` -- `Settings` (Pydantic BaseSettings)

---

### A.1 Test File Organization

```
apps/api/__tests__/
  conftest.py              # Shared fixtures: mock session, mock storage, factories
  helpers.py               # Test helper functions (model builders, assertion utils)
  test_core_crud.py        # BaseCrud tests
  test_core_schemas.py     # PageResponse, AICost tests
  test_video_service.py    # VideoService pipeline tests
  test_video_schemas.py    # VideoCreate/VideoRead validation
  test_video_enums.py      # VideoStatus, VideoStage enum tests
  test_batch_service.py    # BatchService tests
  test_batch_schemas.py    # BatchCreate/BatchRead validation
  test_event_service.py    # EventService tests
  test_settings.py         # Settings validation
  test_parser.py           # PandasFileParser tests
  test_pipeline_tts.py     # TTS provider tests
  test_pipeline_seg.py     # Segmentation provider tests
  test_pipeline_image.py   # Image generation provider tests
```

### A.2 Async Test Patterns

#### Configuration

Use `pytest-asyncio` with auto mode in `pyproject.toml`:

```toml
[tool.pytest.ini_options]
asyncio_mode = "auto"
```

This eliminates the need for `@pytest.mark.asyncio` on every test. All `async def test_*` functions are automatically recognized as async tests.

#### Basic Async Test

```python
async def test_crud_get_returns_none_for_missing_id(mock_session):
    """get() returns None when the record does not exist."""
    mock_session.get.return_value = None
    crud = BaseCrud(mock_session, FakeModel)

    result = await crud.get(uuid.uuid4())

    assert result is None
    mock_session.get.assert_awaited_once()
```

#### Async Fixtures

```python
@pytest.fixture
async def video_service(mock_session, mock_storage, mock_events):
    """VideoService with all dependencies mocked."""
    app_settings_crud = AsyncMock(spec=AppSettingsCrud)
    video_crud = AsyncMock(spec=VideoCrud)
    providers = MagicMock(spec=PipelineProviders)

    return VideoService(
        session=mock_session,
        storage=mock_storage,
        events=mock_events,
        app_settings=app_settings_crud,
        video_crud=video_crud,
        providers=providers,
    )
```

---

### A.3 Mock Patterns

#### MagicMock vs AsyncMock

```python
from unittest.mock import AsyncMock, MagicMock, patch

# Use AsyncMock for async methods (awaitable)
mock_session = AsyncMock(spec=AsyncSession)
mock_session.get.return_value = some_model_instance

# Use MagicMock for sync objects
mock_storage = MagicMock(spec=StorageService)
mock_storage.upload_file.return_value = None
mock_storage.download_file.return_value = b"file contents"

# Use AsyncMock for the EventService (all methods are async)
mock_events = AsyncMock(spec=EventService)
```

#### The spec= Parameter

Always use `spec=` to ensure your mocks fail when you call methods that do not exist on the real class:

```python
# CORRECT: will raise AttributeError if you call mock.nonexistent_method()
mock = MagicMock(spec=StorageService)

# WRONG: silently accepts any attribute access, hides bugs
mock = MagicMock()
```

#### Pydantic model_construct for Test Models

Use `model_construct()` to create Pydantic models without validation (faster, and allows invalid states for edge-case testing):

```python
# For normal test data, use regular construction
video_create = VideoCreate(
    script_text="Buy now!",
    voice_id="rachel",
)

# For testing edge cases or building response objects quickly
video_read = VideoRead.model_construct(
    id=uuid.uuid4(),
    script_text="Test",
    voice_id="rachel",
    status=VideoStatus.finished,
    current_stage=VideoStage.done,
    created_at=datetime.now(),
)
```

#### Mocking SQLAlchemy Session

```python
@pytest.fixture
def mock_session():
    """Async session mock with common query patterns."""
    session = AsyncMock(spec=AsyncSession)

    # Mock scalar queries (count, exists)
    mock_result = MagicMock()
    mock_result.scalar_one.return_value = 5
    session.execute.return_value = mock_result

    # Mock commit and flush
    session.commit = AsyncMock()
    session.flush = AsyncMock()

    return session
```

#### Mocking Session for get_multi (Pagination)

```python
async def test_get_multi_returns_paginated_results(mock_session):
    """get_multi() returns PageResponse with correct pagination."""
    items = [FakeModel(id=uuid.uuid4()) for _ in range(3)]

    # Mock count query
    count_result = MagicMock()
    count_result.scalar_one.return_value = 3

    # Mock items query
    items_result = MagicMock()
    items_result.scalars.return_value.all.return_value = items

    mock_session.execute.side_effect = [count_result, items_result]

    crud = BaseCrud(mock_session, FakeModel)
    page = await crud.get_multi(page=1, page_size=50)

    assert page.total == 3
    assert len(page.items) == 3
    assert page.page == 1
```

---

### A.4 Testing BaseCrud

Test each CRUD operation with mocked session:

```python
class FakeModel(BaseModel):
    """Minimal model for testing BaseCrud."""
    __tablename__ = "fake"
    id: Mapped[uuid.UUID] = mapped_column(primary_key=True, default=uuid.uuid4)
    name: Mapped[str] = mapped_column()


async def test_create_persists_and_returns_model(mock_session):
    crud = BaseCrud(mock_session, FakeModel)
    schema = FakeCreateSchema(name="test")

    result = await crud.create(schema)

    assert result.name == "test"
    mock_session.add.assert_called_once()
    mock_session.commit.assert_awaited_once()


async def test_delete_returns_false_when_not_found(mock_session):
    mock_session.get.return_value = None
    crud = BaseCrud(mock_session, FakeModel)

    result = await crud.delete(uuid.uuid4())

    assert result is False
    mock_session.delete.assert_not_awaited()
```

---

### A.5 Testing Services

Services have multiple dependencies. Use dependency injection via constructor args, mock all collaborators.

```python
async def test_batch_service_create_batch_uploads_to_s3(mock_session):
    """create_batch uploads file to S3 and dispatches Celery task."""
    mock_crud = AsyncMock(spec=BatchCrud)
    mock_storage = MagicMock(spec=StorageService)
    batch_model = MagicMock(spec=Batch)
    batch_model.id = uuid.uuid4()
    mock_crud.create.return_value = batch_model
    mock_crud.get.return_value = batch_model

    service = BatchService(crud=mock_crud, storage=mock_storage)

    with patch("api.batches.service.celery_app") as mock_celery:
        result = await service.create_batch(
            contents=b"file data",
            file_name="test.xlsx",
            batch_name="Test Batch",
            column_mapping={"script": "script_text"},
        )

    mock_storage.upload_file.assert_called_once()
    mock_celery.send_task.assert_called_once()


async def test_recompute_counters_returns_none_when_batch_missing(mock_session):
    """recompute_counters returns None if batch was deleted."""
    mock_crud = AsyncMock(spec=BatchCrud)
    mock_crud.get.return_value = None
    mock_storage = MagicMock(spec=StorageService)

    service = BatchService(crud=mock_crud, storage=mock_storage)
    result = await service.recompute_counters(uuid.uuid4())

    assert result is None
```

---

### A.6 Schema Validation Testing

Use `pytest.mark.parametrize` for validation boundary tests:

```python
class TestVideoCreate:
    """Validation tests for VideoCreate schema."""

    def test_valid_input(self):
        video = VideoCreate(script_text="Buy now!", voice_id="rachel")
        assert video.script_text == "Buy now!"

    @pytest.mark.parametrize("script_text", ["", None])
    def test_rejects_empty_script(self, script_text):
        with pytest.raises(ValidationError):
            VideoCreate(script_text=script_text, voice_id="rachel")

    @pytest.mark.parametrize(
        "field,value",
        [
            ("style", "x" * 256),     # exceeds max_length=255
            ("top_text", "x" * 501),   # exceeds max_length=500
            ("prompt", "x" * 5001),    # exceeds max_length=5000
        ],
    )
    def test_rejects_oversized_fields(self, field, value):
        with pytest.raises(ValidationError):
            VideoCreate(script_text="ok", voice_id="rachel", **{field: value})

    def test_optional_fields_default_to_none(self):
        video = VideoCreate(script_text="ok", voice_id="rachel")
        assert video.style is None
        assert video.top_text is None
        assert video.prompt is None
        assert video.batch_id is None
```

#### Testing PageResponse

```python
def test_page_response_create_calculates_total_pages():
    page = PageResponse.create(items=["a", "b", "c"], total=10, page=1, page_size=3)
    assert page.total_pages == 4  # ceil(10/3)
    assert page.total == 10
    assert len(page.items) == 3

def test_page_response_create_handles_zero_page_size():
    page = PageResponse.create(items=[], total=0, page=1, page_size=0)
    assert page.total_pages == 0
```

#### Testing Enums

```python
def test_video_status_values():
    assert VideoStatus.processing == "processing"
    assert VideoStatus.finished == "finished"
    assert VideoStatus.failed == "failed"

def test_video_stage_order():
    """Stages must maintain their pipeline order."""
    expected_order = ["queued", "tts", "segmentation", "image_generation", "assembly", "upload", "done"]
    actual_order = [stage.value for stage in VideoStage]
    assert actual_order == expected_order
```

---

### A.7 Fixture Design

#### conftest.py Pattern

```python
# apps/api/__tests__/conftest.py
import uuid
from datetime import UTC, datetime
from unittest.mock import AsyncMock, MagicMock

import pytest
from sqlalchemy.ext.asyncio import AsyncSession

from api.events.service import EventService
from api.storage import StorageService


@pytest.fixture
def mock_session():
    """AsyncSession mock with common defaults."""
    session = AsyncMock(spec=AsyncSession)
    session.commit = AsyncMock()
    session.flush = AsyncMock()
    session.add = MagicMock()
    session.delete = AsyncMock()
    return session


@pytest.fixture
def mock_storage():
    """StorageService mock."""
    storage = MagicMock(spec=StorageService)
    storage.upload_file.return_value = None
    storage.download_file.return_value = b"mock file data"
    storage.delete_prefix.return_value = 3
    return storage


@pytest.fixture
def mock_events():
    """EventService mock."""
    return AsyncMock(spec=EventService)


@pytest.fixture
def sample_uuid():
    """A fixed UUID for deterministic tests."""
    return uuid.UUID("12345678-1234-5678-1234-567812345678")


@pytest.fixture
def now():
    """Current UTC datetime without timezone."""
    return datetime.now(UTC).replace(tzinfo=None)
```

#### helpers.py Pattern

```python
# apps/api/__tests__/helpers.py
import uuid
from datetime import UTC, datetime

from api.videos.enums import VideoStage, VideoStatus


def make_video_model(**overrides):
    """Build a Video model-like object for testing (avoids DB dependency)."""
    from unittest.mock import MagicMock

    video = MagicMock()
    video.id = overrides.get("id", uuid.uuid4())
    video.batch_id = overrides.get("batch_id", None)
    video.script_text = overrides.get("script_text", "Test script")
    video.voice_id = overrides.get("voice_id", "rachel")
    video.status = overrides.get("status", VideoStatus.processing)
    video.current_stage = overrides.get("current_stage", VideoStage.queued)
    video.error_message = overrides.get("error_message", None)
    video.tts_cost_usd = overrides.get("tts_cost_usd", 0.0)
    video.tts_token_count = overrides.get("tts_token_count", 0)
    video.segmentation_cost_usd = overrides.get("segmentation_cost_usd", 0.0)
    video.segmentation_token_count = overrides.get("segmentation_token_count", 0)
    video.image_generation_cost_usd = overrides.get("image_generation_cost_usd", 0.0)
    video.image_generation_token_count = overrides.get("image_generation_token_count", 0)
    video.total_cost_usd = overrides.get("total_cost_usd", 0.0)
    video.total_token_count = overrides.get("total_token_count", 0)
    video.duration_ms = overrides.get("duration_ms", 0)
    video.created_at = overrides.get("created_at", datetime.now(UTC).replace(tzinfo=None))
    video.shots = overrides.get("shots", [])
    return video
```

---

### A.8 When to Use parametrize vs Individual Tests

Use `parametrize` when:
- Testing the same behavior with different inputs (validation boundaries, enum mappings)
- The test body is identical except for input/expected values
- Each case is truly independent

Use individual tests when:
- The setup or assertions differ significantly between cases
- The test name needs to describe a specific scenario
- Failure diagnosis requires distinct context

```python
# GOOD use of parametrize: same logic, different inputs
@pytest.mark.parametrize("status,expected", [
    (VideoStatus.processing, "processing"),
    (VideoStatus.finished, "finished"),
    (VideoStatus.failed, "failed"),
])
def test_video_status_string_values(status, expected):
    assert status.value == expected

# BAD use of parametrize: different scenarios crammed together
# Instead, write individual tests with descriptive names
async def test_create_batch_uploads_file_to_s3(service): ...
async def test_create_batch_dispatches_celery_task(service): ...
async def test_create_batch_rolls_back_on_s3_failure(service): ...
```

---

### A.9 What NOT to Test

Do not test:
- **Framework behavior:** SQLAlchemy query building, FastAPI dependency injection, Pydantic serialization internals
- **Third-party library correctness:** Celery task dispatching mechanics, Redis pub/sub protocol
- **Python stdlib:** `uuid.uuid4()` returns a UUID, `datetime.now()` returns current time
- **Simple property access:** Getters/setters that just read/write attributes
- **Type annotations:** These are enforced by mypy/pyright, not tests

Do test:
- **Your business logic:** Pipeline stage transitions, cost calculations, counter recomputation
- **Your validation rules:** Field constraints, required fields, enum values
- **Your error handling:** What happens when S3 upload fails, when batch is not found
- **Your data transformations:** Schema conversions, computed fields, aggregations

---

## Part B: Frontend Unit Testing (Vitest + React Testing Library)

**Tech stack:** React + Vite + Vitest + React Testing Library + TanStack Query + TanStack Router

**Key paths:**
- `apps/react/src/components/**/*.test.tsx` -- component tests
- `apps/react/src/lib/*.test.ts` -- utility function tests
- `apps/react/vitest.config.ts` or `vite.config.ts` -- Vitest configuration

---

### B.1 Test File Organization

Place test files next to the code they test:

```
apps/react/src/
  components/
    dashboard/
      status-badge.tsx
      status-badge.test.tsx      # Component test
      stage-indicator.tsx
      stage-indicator.test.tsx
      file-upload.tsx
      file-upload.test.tsx
    ui/
      stepper.tsx
      stepper.test.tsx
  lib/
    format.ts
    format.test.ts               # Utility function test
  hooks/
    use-batch-progress.ts
    use-batch-progress.test.ts   # Hook test
```

### B.2 Component Testing Patterns

#### Basic Component Test

```typescript
import { describe, it, expect } from "vitest";
import { render, screen } from "@testing-library/react";
import { StatusBadge } from "./status-badge";

describe("StatusBadge", () => {
  it("renders the correct label for each known status", () => {
    const cases = [
      { status: "queued", expected: "Queued" },
      { status: "finished", expected: "Finished" },
      { status: "failed", expected: "Failed" },
    ];

    for (const { status, expected } of cases) {
      const { unmount } = render(<StatusBadge status={status} />);
      expect(screen.getByText(expected)).toBeInTheDocument();
      unmount();
    }
  });
});
```

**Key rules:**
- Call `unmount()` when rendering multiple variants in the same test to avoid DOM pollution
- Use `screen.getByText()` and `screen.getByRole()` -- same selector priorities as Playwright
- Never query by CSS class for content assertions (only for style verification)

#### Testing User Interactions

```typescript
import { describe, it, expect, vi } from "vitest";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import { FileUpload } from "./file-upload";

describe("FileUpload", () => {
  it("shows error for unsupported file type via drop", async () => {
    render(<FileUpload onFileParsed={vi.fn()} />);

    const dropZone = screen.getByRole("button");
    const badFile = new File(["data"], "photo.png", { type: "image/png" });

    fireEvent.drop(dropZone, {
      dataTransfer: { files: [badFile] },
    });

    await waitFor(() => {
      expect(screen.getByText(/Please upload an Excel/)).toBeInTheDocument();
    });
  });

  it("calls onFileParsed when valid file is dropped", async () => {
    const onFileParsed = vi.fn();
    render(<FileUpload onFileParsed={onFileParsed} />);
    // ... drop a valid file, assert onFileParsed was called
  });
});
```

#### Testing CSS/Visual State

When you need to verify visual state (animation classes, color changes):

```typescript
it("applies animate-pulse class only when processing", () => {
  const { container, unmount } = render(<StatusBadge status="processing" />);
  const dot = container.querySelector(".animate-pulse");
  expect(dot).toBeInTheDocument();
  unmount();

  const { container: c2 } = render(<StatusBadge status="finished" />);
  expect(c2.querySelector(".animate-pulse")).not.toBeInTheDocument();
});
```

This is one of the few cases where CSS selectors are acceptable -- you are testing the visual behavior, not the content.

---

### B.3 Utility Function Testing

Pure function tests are the simplest and most valuable. No rendering, no mocking.

```typescript
import { describe, it, expect } from "vitest";
import { formatDuration, formatCurrency, formatFileSize } from "./format";

describe("formatDuration", () => {
  it("returns 0s for zero milliseconds", () => {
    expect(formatDuration(0)).toBe("0s");
  });

  it("returns minutes and seconds", () => {
    expect(formatDuration(150_000)).toBe("2m 30s");
  });

  it("floors fractional milliseconds", () => {
    expect(formatDuration(1_999)).toBe("1s");
  });
});
```

**Pattern:** Test edge cases (zero, negative, boundary values), typical cases, and large values. Each test should verify one specific behavior.

---

### B.4 Hook Testing Patterns

Use `renderHook` from `@testing-library/react` for custom hooks:

```typescript
import { describe, it, expect } from "vitest";
import { renderHook, act, waitFor } from "@testing-library/react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { useBatchProgress } from "./use-batch-progress";

function createWrapper() {
  const queryClient = new QueryClient({
    defaultOptions: { queries: { retry: false } },
  });
  return ({ children }: { children: React.ReactNode }) => (
    <QueryClientProvider client={queryClient}>{children}</QueryClientProvider>
  );
}

describe("useBatchProgress", () => {
  it("returns initial state before data loads", () => {
    const { result } = renderHook(() => useBatchProgress("batch-id"), {
      wrapper: createWrapper(),
    });

    expect(result.current.isLoading).toBe(true);
    expect(result.current.data).toBeUndefined();
  });
});
```

---

### B.5 Mocking API Calls

#### Option 1: Mock the Orval-Generated Client Modules

```typescript
import { vi } from "vitest";

// Mock the generated API client
vi.mock("@/api/client", () => ({
  useGetBatches: vi.fn().mockReturnValue({
    data: { items: [], total: 0 },
    isLoading: false,
    error: null,
  }),
}));
```

#### Option 2: Mock at the Fetch Level with MSW

For tests that need more realistic API interactions:

```typescript
import { setupServer } from "msw/node";
import { http, HttpResponse } from "msw";

const server = setupServer(
  http.get("/api/v1/batches", () => {
    return HttpResponse.json({
      items: [{ id: "abc", name: "Test Batch", status: "completed" }],
      page: 1,
      page_size: 50,
      total: 1,
      total_pages: 1,
    });
  }),
);

beforeAll(() => server.listen());
afterEach(() => server.resetHandlers());
afterAll(() => server.close());
```

**Recommendation:** For unit tests, prefer mocking the Orval client modules directly. Use MSW only when you need to test the actual HTTP integration (which is more of an integration test).

---

### B.6 Testing with React Query (TanStack Query)

Components using `useQuery` need a `QueryClientProvider` wrapper:

```typescript
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";

function renderWithQueryClient(ui: React.ReactElement) {
  const queryClient = new QueryClient({
    defaultOptions: {
      queries: { retry: false, gcTime: 0 },
    },
  });

  return render(
    <QueryClientProvider client={queryClient}>{ui}</QueryClientProvider>,
  );
}

it("shows loading state", () => {
  // Mock the hook to return loading state
  vi.mocked(useGetBatches).mockReturnValue({
    data: undefined,
    isLoading: true,
    error: null,
  } as ReturnType<typeof useGetBatches>);

  renderWithQueryClient(<BatchList />);
  expect(screen.getByText("Loading...")).toBeInTheDocument();
});
```

**Key rules:**
- Always set `retry: false` in test QueryClient to avoid hanging tests
- Set `gcTime: 0` to prevent cache leaking between tests
- Create a fresh `QueryClient` per test (never share)

---

### B.7 Testing Form Interactions

```typescript
import { describe, it, expect, vi } from "vitest";
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";

describe("SettingsForm", () => {
  it("submits form with updated values", async () => {
    const user = userEvent.setup();
    const onSave = vi.fn();

    render(<SettingsForm onSave={onSave} initialValues={defaultSettings} />);

    const promptField = screen.getByLabelText(/master prompt/i);
    await user.clear(promptField);
    await user.type(promptField, "New prompt text");

    await user.click(screen.getByRole("button", { name: /save/i }));

    expect(onSave).toHaveBeenCalledWith(
      expect.objectContaining({ master_prompt: "New prompt text" }),
    );
  });
});
```

**Prefer `userEvent` over `fireEvent`** for form interactions. `userEvent` simulates real user behavior (focus, typing one character at a time, blur) while `fireEvent` dispatches raw DOM events.

Exception: Use `fireEvent` for drag-and-drop, which `userEvent` does not support well.

---

### B.8 Snapshot Testing

**When to use snapshots:**
- Small, stable UI components with well-defined output (badges, tags, icons)
- Never for large components or components that change frequently

**When NOT to use snapshots:**
- Components with dynamic data (dates, UUIDs, random values)
- Large component trees (snapshots become unreadable)
- Components under active development (constant snapshot updates obscure real changes)

```typescript
// ACCEPTABLE: small, stable component
it("matches snapshot for completed status", () => {
  const { container } = render(<StatusBadge status="completed" />);
  expect(container.firstChild).toMatchSnapshot();
});

// BAD: large component with dynamic data
it("matches snapshot", () => {
  render(<BatchDetailPage batchId="abc-123" />);
  expect(document.body).toMatchSnapshot(); // Never do this
});
```

**Prefer explicit assertions over snapshots.** Writing `expect(screen.getByText("Completed")).toBeInTheDocument()` is clearer about intent and fails with better error messages than a snapshot diff.

---

### B.9 Anti-Patterns to Avoid

| Anti-Pattern | Why it is wrong | Correct approach |
|---|---|---|
| `screen.getByTestId("save-btn")` as default | Hides accessibility issues | `screen.getByRole("button", { name: /save/i })` |
| Testing component internals (state, hooks) | Brittle, implementation-coupled | Test rendered output and user interactions |
| `await waitFor(() => {})` with no assertion | Does nothing, just delays | Put the assertion inside `waitFor` |
| Shared mutable test data between `it` blocks | Test order dependency | Create fresh data in each test or use `beforeEach` |
| Mocking everything | Tests pass but verify nothing | Mock only external boundaries (API, storage) |
| `expect(component).toBeDefined()` | Always passes, tests nothing | Assert on specific content or behavior |
| No `unmount()` when rendering multiple times | DOM pollution, false positives | Call `unmount()` or use separate test cases |
| Testing Orval-generated code | Not your code | Trust the generator, test your components |

---

### B.10 Checklist: Before Submitting Unit Tests

#### Backend (pytest)

- [ ] All async tests are `async def test_*` (auto mode handles the marker)
- [ ] Mocks use `spec=` parameter to prevent false positives
- [ ] Fixtures are defined in `conftest.py`, not duplicated across test files
- [ ] `parametrize` is used for validation boundary tests, not for unrelated scenarios
- [ ] Tests do not hit real databases, Redis, S3, or external APIs
- [ ] Each test has exactly one responsibility (one behavior per test)
- [ ] Test names read as sentences: `test_create_batch_uploads_file_to_s3`
- [ ] No `Any` type annotations in test code

#### Frontend (Vitest)

- [ ] Tests import from `vitest` (`describe`, `it`, `expect`, `vi`), not `jest`
- [ ] Component tests use `@testing-library/react`, not Enzyme
- [ ] Selector priority: `getByRole` > `getByLabelText` > `getByPlaceholderText` > `getByText`
- [ ] `unmount()` called when rendering multiple variants in the same test
- [ ] Query client has `retry: false` and `gcTime: 0` in test wrappers
- [ ] Callbacks are mocked with `vi.fn()`, not hand-written stubs
- [ ] No snapshot tests for large or dynamic components
- [ ] Tests pass in isolation: `vitest run path/to/file.test.ts`
