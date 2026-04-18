# Design Patterns SOP — FastAPI + React Stack

> Patterns mapped to real use cases in this tech stack. When to reach for each, when not to, with production code examples.
>
> Reference: [refactoring.guru/design-patterns](https://refactoring.guru/design-patterns)

---

## 1. Facade — Simplify Complex Subsystems

**What it does:** Wraps a complex subsystem behind a single, clean interface.

**When to reach for it:**
- Integrating external APIs (ElevenLabs, Claude, Gemini, S3)
- Orchestrating multi-step operations (pipeline stages)
- Hiding database + cache + storage coordination from routes

**When NOT to use it:**
- The subsystem is already simple (one class, one method)
- You need fine-grained control over every subsystem call from multiple places
- It's turning into a god object — split into multiple facades instead

### Example: StorageService as Facade

The `StorageService` is a textbook Facade — routes never touch `boto3`, `S3Client`, bucket names, or retry logic directly:

```python
class StorageService:
    """Facade over S3 client, bucket config, retry logic, and ZIP streaming."""

    def __init__(self, client: S3ClientDep) -> None:
        self._client = client
        self._bucket = settings.S3_BUCKET_NAME

    def upload_file(self, key: str, data: bytes, content_type: str) -> None:
        """One call. Caller doesn't know about boto3, retries, or bucket names."""
        self._client.put_object(Bucket=self._bucket, Key=key, Body=data, ContentType=content_type)

    def generate_presigned_url(self, key: str, expires_in: int = 3600) -> str:
        return self._client.generate_presigned_url(
            "get_object", Params={"Bucket": self._bucket, "Key": key}, ExpiresIn=expires_in,
        )

    def stream_zip(self, files: list[tuple[str, str]]) -> Generator[bytes, None, None]:
        """Complex operation: download N files from S3, build ZIP in memory, yield bytes.
        Caller sees: one method, one generator."""
        buffer = io.BytesIO()
        with zipfile.ZipFile(buffer, "w", zipfile.ZIP_DEFLATED) as zf:
            for s3_key, archive_name in files:
                zf.writestr(archive_name, self.download_file(s3_key))
        buffer.seek(0)
        yield buffer.read()
```

### Example: VideoService as Orchestration Facade

```python
class VideoService:
    """Facade over TTS + segmentation + image gen + assembly + storage.
    Routes call one method. Service coordinates 5 subsystems."""

    def __init__(self, session, storage, events, tts, segmentation, image_gen, editor):
        # All dependencies injected — facade doesn't create subsystems
        self._tts = tts
        self._segmentation = segmentation
        self._image_gen = image_gen
        self._editor = editor
        self._storage = storage

    async def generate_video(self, video_input: VideoCreate) -> VideoGenerationResult:
        """Single entry point. Caller doesn't know about pipeline stages."""
        video = await self._create_record(video_input)
        tts_result = await self._tts.synthesize(video.script_text)
        segments = await self._segmentation.segment(video.script_text, tts_result)
        images = await self._image_gen.generate_batch(segments)
        output = await self._editor.compose(tts_result, images, segments)
        await self._storage.upload_file(video.output_key, output)
        return self._finalize(video)
```

### Example: React — API Client as Facade

The Orval-generated client + custom Axios instance is a facade over HTTP details:

```typescript
// What the route component sees:
const { data } = useListVideosApiV1VideosGet({ page_size: 50 });

// What's hidden behind the facade:
// - Base URL resolution
// - Cookie credentials
// - 401 → redirect interceptor
// - Array param serialization (indexes: null)
// - 30s timeout
// - React Query cache integration
```

### Recognizing the Need

| Code Smell | Facade Fix |
|-----------|-----------|
| Route handler has 15+ lines of boto3 calls | Extract `StorageService` |
| Multiple routes duplicate the same 3-API sequence | Extract orchestration service |
| Component does `fetch()` with manual headers/error handling | Use generated API client |
| Test setup requires initializing 5 dependencies | Facade wraps them into one |

---

## 2. Strategy — Swap Algorithms at Runtime

**What it does:** Defines a family of interchangeable algorithms behind a common interface.

**When to reach for it:**
- Multiple providers for the same capability (TTS, image gen, LLM)
- Different processing modes (export formats, validation rules)
- Replacing `if provider == "elevenlabs": ... elif provider == "openai": ...` conditionals
- Feature flags that swap behavior

**When NOT to use it:**
- Only one algorithm exists and you're not planning alternatives
- The variation is tiny (a single config value, not a whole algorithm)
- Python: a simple function/lambda is enough — don't over-engineer with classes

### Example: Pipeline Provider Strategy

```python
# ── Strategy interface (Protocol) ──────────────────────────────────

from typing import Protocol

class TTSService(Protocol):
    """Strategy interface for text-to-speech providers."""
    async def synthesize(self, text: str, voice_id: str) -> TTSResult: ...

class SegmentationService(Protocol):
    """Strategy interface for script segmentation providers."""
    async def segment(self, script: str, timestamps: list[WordTiming]) -> list[Segment]: ...

class ImageGenService(Protocol):
    """Strategy interface for image generation providers."""
    async def generate(self, prompt: str, width: int, height: int) -> bytes: ...


# ── Concrete strategies ────────────────────────────────────────────

class ElevenLabsTTSService:
    """ElevenLabs implementation of TTS strategy."""

    async def synthesize(self, text: str, voice_id: str) -> TTSResult:
        client = ElevenLabs(api_key=settings.ELEVENLABS_API_KEY)
        response = client.text_to_speech.convert(text=text, voice_id=voice_id)
        return TTSResult(audio=response.audio, timestamps=response.alignment)


class OpenAITTSService:
    """OpenAI implementation — swap in without changing any caller."""

    async def synthesize(self, text: str, voice_id: str) -> TTSResult:
        client = openai.AsyncClient()
        response = await client.audio.speech.create(model="tts-1", input=text, voice=voice_id)
        return TTSResult(audio=response.content, timestamps=[])


class ClaudeSegmentationService:
    async def segment(self, script: str, timestamps: list[WordTiming]) -> list[Segment]:
        response = await anthropic_client.messages.create(
            model="claude-sonnet-4-6", messages=[...], ...
        )
        return parse_segments(response)


class GeminiImageGenService:
    async def generate(self, prompt: str, width: int, height: int) -> bytes:
        response = await genai_client.generate_image(prompt=prompt, size=f"{width}x{height}")
        return response.image_bytes


# ── Context (VideoService receives strategies via constructor) ─────

class VideoService:
    def __init__(
        self,
        tts: TTSService,              # Strategy injected
        segmentation: SegmentationService,  # Strategy injected
        image_gen: ImageGenService,    # Strategy injected
        ...
    ):
        self._tts = tts
        self._segmentation = segmentation
        self._image_gen = image_gen

    async def _run_tts(self, video: Video) -> TTSResult:
        # Doesn't know or care which provider. Just calls the interface.
        return await self._tts.synthesize(video.script_text, video.voice_id)
```

### Example: React — Conditional Rendering Strategy

```typescript
// Strategy map for status badge rendering
const STATUS_CONFIG: Record<string, { label: string; bg: string; dot: string }> = {
  queued:     { label: "Queued",     bg: "bg-status-info-light",    dot: "bg-status-info" },
  processing: { label: "Processing", bg: "bg-status-warning-light", dot: "bg-brand" },
  finished:   { label: "Finished",   bg: "bg-status-success-light", dot: "bg-status-success" },
  failed:     { label: "Failed",     bg: "bg-status-error-light",   dot: "bg-status-error" },
};

// No if/else chain. Lookup by key.
export function StatusBadge({ status }: { status: string }) {
  const config = STATUS_CONFIG[status] ?? STATUS_CONFIG.processing;
  return <span className={cn(config.bg)}>{config.label}</span>;
}
```

### Example: React — Export Format Strategy

```typescript
type ExportStrategy = (videos: Video[]) => void;

const exportStrategies: Record<string, ExportStrategy> = {
  csv: (videos) => downloadCSV(videos),
  json: (videos) => downloadJSON(videos),
  zip: (videos) => downloadZIP(videos),
};

function ExportButton({ format, videos }: { format: string; videos: Video[] }) {
  const strategy = exportStrategies[format];
  return <Button onClick={() => strategy(videos)}>Export {format.toUpperCase()}</Button>;
}
```

### Recognizing the Need

| Code Smell | Strategy Fix |
|-----------|-------------|
| `if provider == "x": ... elif provider == "y": ...` | Protocol + concrete classes |
| Massive switch on a type/mode field | Strategy map or class hierarchy |
| Copy-pasting a function with minor variations | Extract common interface |
| "We might switch to a different API later" | Protocol now, swap later |

---

## 3. Builder — Construct Complex Objects Step by Step

**What it does:** Builds complex objects incrementally instead of via a massive constructor.

**When to reach for it:**
- Object has many optional fields (Pydantic models with 10+ fields)
- Construction involves sequential steps that can vary
- Building query objects, request payloads, or config objects
- Test fixtures with many variations

**When NOT to use it:**
- Object has < 5 fields — just use a constructor/schema
- Pydantic `model_validate()` already handles the complexity
- Python: keyword arguments + defaults often make Builder unnecessary

### Example: SQLAlchemy Query Builder (Natural Fit)

SQLAlchemy's `select()` is already a builder pattern:

```python
class VideoCrud(BaseCrud[Video, VideoCreate, VideoUpdate]):

    async def get_filtered(
        self,
        batch_id: uuid.UUID | None = None,
        status: VideoStatus | None = None,
        stage: VideoStage | None = None,
        page: int = 1,
        page_size: int = 50,
    ) -> PageResponse[Video]:
        # Builder pattern — chain optional filters
        stmt = select(Video)

        if batch_id:
            stmt = stmt.where(Video.batch_id == batch_id)
        if status:
            stmt = stmt.where(Video.status == status)
        if stage:
            stmt = stmt.where(Video.current_stage == stage)

        stmt = stmt.order_by(Video.created_at.desc())
        stmt = stmt.offset((page - 1) * page_size).limit(page_size)

        result = await self.db_session.execute(stmt)
        return PageResponse.create(items=list(result.scalars().all()), ...)
```

### Example: Pydantic Schema as Builder Alternative

Python's keyword arguments + Pydantic often replace the Builder pattern entirely:

```python
# No builder needed — Pydantic handles defaults, validation, and optional fields
class VideoCreate(BaseModel):
    script_text: str = Field(min_length=1)
    voice_id: str = "default-voice"
    style: str | None = None
    batch_id: uuid.UUID | None = None
    prompt: str | None = None

# Construction is clean without a builder:
video = VideoCreate(script_text="Buy now!", voice_id="rachel", style="dramatic")
```

### Example: When Builder IS Needed — Complex Test Fixtures

```python
class VideoFixtureBuilder:
    """Builder for test fixtures with many interdependent fields."""

    def __init__(self) -> None:
        self._data: dict = {
            "script_text": "Default script",
            "status": VideoStatus.processing,
            "current_stage": VideoStage.queued,
        }

    def with_status(self, status: VideoStatus) -> "VideoFixtureBuilder":
        self._data["status"] = status
        return self

    def with_stage(self, stage: VideoStage) -> "VideoFixtureBuilder":
        self._data["current_stage"] = stage
        return self

    def finished(self) -> "VideoFixtureBuilder":
        """Convenience — sets related fields consistently."""
        self._data["status"] = VideoStatus.finished
        self._data["current_stage"] = VideoStage.done
        self._data["output_url"] = "https://example.com/video.mp4"
        return self

    def failed_at(self, stage: VideoStage) -> "VideoFixtureBuilder":
        self._data["status"] = VideoStatus.failed
        self._data["current_stage"] = stage
        self._data["error_message"] = f"Failed at {stage.value}"
        return self

    def build(self) -> Video:
        return Video(**self._data)


# Usage in tests:
video = VideoFixtureBuilder().finished().build()
video = VideoFixtureBuilder().failed_at(VideoStage.tts).build()
```

### Example: React — Form State Builder

```typescript
// Multi-step dialog accumulates state like a builder
const [step, setStep] = useState<Step>("upload");
const [parsedFile, setParsedFile] = useState<ParsedFile | null>(null);
const [mapping, setMapping] = useState<ColumnMapping | null>(null);

// Each step "builds" more of the final payload:
// Step 1: parsedFile (headers, rows)
// Step 2: mapping (column assignments)
// Step 3: submit complete object

const handleConfirm = async () => {
  // Final "build" — assemble from accumulated state
  const formData = new FormData();
  formData.append("file", parsedFile!.file);
  formData.append("name", batchName);
  formData.append("column_mapping", JSON.stringify(mapping));
  await uploadBatch.mutateAsync({ data: formData });
};
```

### Recognizing the Need

| Code Smell | Builder Fix |
|-----------|-----------|
| Constructor with 10+ params, most optional | Builder or Pydantic with defaults |
| Test fixtures copy-pasting field assignments | `FixtureBuilder().finished().build()` |
| Multi-step form assembling a complex payload | Accumulate state, build on submit |
| Query with many optional WHERE clauses | SQLAlchemy's fluent builder API |

---

## 4. Factory Method — Defer Object Creation to Subclasses

**What it does:** Defines a creation interface, lets subclasses decide which class to instantiate.

**When to reach for it:**
- Creating objects based on a type/config value from database or request
- Framework extension points where users override which class to create
- When constructor logic depends on runtime conditions

**When NOT to use it in Python:**
- A simple dict mapping or function is cleaner (Python isn't Java)
- You have < 3 variants

### Example: Provider Factory

```python
# Dict-based factory (Pythonic alternative to class hierarchy)
_TTS_PROVIDERS: dict[str, type[TTSService]] = {
    "elevenlabs": ElevenLabsTTSService,
    "openai": OpenAITTSService,
}

def create_tts_service(provider: str = "elevenlabs") -> TTSService:
    """Factory method — returns correct implementation based on config."""
    cls = _TTS_PROVIDERS.get(provider)
    if not cls:
        raise ValueError(f"Unknown TTS provider: {provider}")
    return cls()


# Usage:
tts = create_tts_service(settings.TTS_PROVIDER)
```

### Example: FastAPI Dependency Factory

```python
def ValidateUpload(
    allowed_extensions: set[str] = settings.UPLOAD_ALLOWED_EXTENSIONS,
    max_size_bytes: int = settings.UPLOAD_MAX_FILE_SIZE,
):
    """Factory that creates a validation dependency with custom constraints."""

    async def _validate(file: UploadFile) -> ValidatedFile:
        ext = PurePosixPath(file.filename).suffix.lower()
        if ext not in allowed_extensions:
            raise HTTPException(400, f"Unsupported: {ext}")
        contents = await file.read()
        if len(contents) > max_size_bytes:
            raise HTTPException(400, "File too large")
        return ValidatedFile(filename=file.filename, contents=contents, extension=ext)

    return _validate

# Different validators from the same factory:
ValidatedFileDep = Annotated[ValidatedFile, Depends(ValidateUpload())]
ValidatedImageDep = Annotated[ValidatedFile, Depends(ValidateUpload(
    allowed_extensions={".png", ".jpg", ".webp"},
    max_size_bytes=5 * 1024 * 1024,
))]
```

---

## 5. Observer — Event-Driven Updates

**What it does:** Objects subscribe to events and get notified when they occur.

**When to reach for it:**
- Real-time UI updates (SSE, WebSocket)
- Pipeline progress tracking
- Cache invalidation on state changes
- Decoupling "something happened" from "what to do about it"

### Example: Backend — Redis Pub/Sub EventService

```python
class EventService:
    """Publisher — emits events to Redis channels."""

    async def emit(self, channel: str, event: BaseModel) -> None:
        await self._client.publish(channel, event.model_dump_json())

    async def subscribe(self, channel: str, schema: type[BaseModel]) -> AsyncGenerator[BaseModel, None]:
        pubsub = self._client.pubsub()
        await pubsub.subscribe(channel)
        async for message in pubsub.listen():
            if message["type"] == "message":
                yield schema.model_validate_json(message["data"])
```

### Example: Frontend — useEventSource as Observer

```typescript
// Observer pattern: component subscribes to SSE events,
// invalidates React Query cache on each event.
export function useEventSource(url: string, enabled: boolean, queryKeys: readonly (readonly unknown[])[]) {
  const queryClient = useQueryClient();

  useEffect(() => {
    if (!enabled) return;
    const es = new EventSource(url, { withCredentials: true });

    const invalidate = () => {
      for (const key of queryKeys) {
        queryClient.invalidateQueries({ queryKey: key });
      }
    };

    es.addEventListener("video_progress", invalidate);
    es.addEventListener("batch_progress", invalidate);
    return () => es.close();
  }, [url, enabled, queryClient]);
}
```

### Example: React Query as Observer

```typescript
// React Query IS the observer pattern:
// - Component subscribes to a query key
// - When data changes (mutation + invalidation), all subscribers re-render
const { data } = useListVideosApiV1VideosGet({ page_size: 50 });

// Mutation triggers notification to all observers:
queryClient.invalidateQueries({ queryKey: getListVideosApiV1VideosGetQueryKey() });
```

---

## 6. Adapter — Make Incompatible Interfaces Work Together

**What it does:** Wraps an existing class so it matches the interface your code expects.

**When to reach for it:**
- Third-party SDK returns data in wrong shape
- Legacy API has different response format
- Testing — mock adapters for external services

### Example: S3Client Protocol as Adapter Interface

```python
@runtime_checkable
class S3Client(Protocol):
    """Adapter interface — any S3-compatible client works.
    boto3, minio, mock — all fit this Protocol."""

    def put_object(self, *, Bucket: str, Key: str, Body: bytes, ContentType: str) -> dict: ...
    def get_object(self, *, Bucket: str, Key: str) -> dict: ...
    def generate_presigned_url(self, method: str, Params: dict, ExpiresIn: int) -> str: ...

# boto3 client naturally satisfies this Protocol — no wrapper needed.
# For testing, create a mock that also satisfies it:
class InMemoryS3Client:
    """Test adapter — same interface, in-memory storage."""
    def __init__(self):
        self._store: dict[str, bytes] = {}

    def put_object(self, *, Bucket: str, Key: str, Body: bytes, ContentType: str) -> dict:
        self._store[f"{Bucket}/{Key}"] = Body
        return {}

    def get_object(self, *, Bucket: str, Key: str) -> dict:
        return {"Body": io.BytesIO(self._store[f"{Bucket}/{Key}"])}
```

### Example: React — Axios Custom Instance as Adapter

```typescript
// Orval expects a specific function signature.
// customInstance adapts Axios to match it:
export const customInstance = <T>(
  config: AxiosRequestConfig,
  options?: AxiosRequestConfig,
): Promise<T> => {
  // Adapter: takes Orval's expected signature → delegates to Axios
  return AXIOS_INSTANCE({ ...config, ...options }).then((res) => res.data);
};
```

---

## 7. Template Method — Algorithm Skeleton with Customizable Steps

**What it does:** Defines the algorithm structure in a base class, lets subclasses override specific steps.

**When to reach for it:**
- Multiple pipeline variants share the same flow but differ in specific steps
- CRUD operations with common pre/post hooks
- Processing workflows with identical structure but different implementations

### Example: BaseCrud as Template Method

```python
class BaseCrud(Generic[ModelType, CreateSchemaType, UpdateSchemaType]):
    """Template method pattern — algorithm (CRUD) is fixed,
    subclasses customize by overriding or extending."""

    async def create(self, obj_in: CreateSchemaType) -> ModelType:
        # Template: dump → instantiate → save → return
        obj_data = obj_in.model_dump(exclude_unset=True)
        db_obj = self.model(**obj_data)
        await save(self.db_session, db_obj)
        return db_obj

    async def get_multi(self, page: int = 1, page_size: int = 50) -> PageResponse[ModelType]:
        # Template: count → query → paginate
        total = await self.count()
        offset = (page - 1) * page_size
        stmt = select(self.model).order_by(self.model.created_at.desc()).offset(offset).limit(page_size)
        result = await self.db_session.execute(stmt)
        return PageResponse.create(items=list(result.scalars().all()), total=total, page=page, page_size=page_size)


class VideoCrud(BaseCrud[Video, VideoCreate, VideoUpdate]):
    """Subclass extends the template with domain-specific queries."""

    async def get_by_batch(self, batch_id: uuid.UUID) -> list[Video]:
        # Custom step — not in base template
        stmt = select(Video).where(Video.batch_id == batch_id)
        result = await self.db_session.execute(stmt)
        return list(result.scalars().all())
```

### Example: Pipeline Stage as Template Method

```python
class PipelineStage:
    """Each pipeline stage follows: validate → execute → store → update status."""

    async def run(self, video: Video, ctx: TaskContext) -> StageResult:
        self._validate(video)                    # Hook — override for custom validation
        result = await self._execute(video)      # Abstract — each stage implements
        await self._store_artifacts(video, result, ctx)  # Template — shared storage logic
        await self._update_status(video, ctx)    # Template — shared DB update
        return result

    def _validate(self, video: Video) -> None:
        """Hook — override to add stage-specific validation."""
        pass

    async def _execute(self, video: Video) -> StageResult:
        """Abstract step — subclasses must implement."""
        raise NotImplementedError

    async def _store_artifacts(self, video: Video, result: StageResult, ctx: TaskContext) -> None:
        """Template step — shared across all stages."""
        ctx.storage.upload_file(f"{video.s3_prefix}/{self.stage_name}", result.data, result.content_type)
```

---

## 8. Command — Encapsulate Operations as Objects

**What it does:** Turns a request into a standalone object for queuing, logging, undo, or deferred execution.

**When to reach for it:**
- Task queues (Celery tasks ARE commands)
- Undo/redo functionality
- Macro recording / batch operations
- Audit logging of operations

### Example: Celery Tasks as Command Pattern

```python
# Each Celery task IS a Command object:
# - Encapsulates an operation with all its parameters
# - Can be queued, delayed, retried
# - Executed by a worker (invoker) that doesn't know the details

@async_task(celery_app, bind=True, max_retries=0)
async def process_video(self, video_data: dict, batch_id: str | None = None):
    """Command: all params serialized into the task message.
    Worker (invoker) calls this without knowing what it does."""
    async with task_context() as ctx:
        service = _build_service(ctx)
        result = await service.generate_video(VideoCreate.model_validate(video_data))
        return result.model_dump()

# Dispatch = queue the command for deferred execution:
process_video.delay(video_input.model_dump(), batch_id=str(batch.id))
```

### Example: React — Mutation as Command

```typescript
// React Query mutations are commands:
// - Encapsulate the operation (API call + side effects)
// - Can be triggered, cancelled, retried
// - onSuccess/onError are the "receiver" callbacks

const deleteBatch = useDeleteBatchApiV1BatchesBatchIdDelete({
  mutation: {
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: getListBatchesApiV1BatchesGetQueryKey() });
      toast.success("Batch deleted");
    },
    onError: () => toast.error("Failed to delete batch"),
  },
});

// Execute the command:
deleteBatch.mutate({ batchId: batch.id });
```

---

## Pattern Selection Cheat Sheet

| Situation | Pattern | Stack Example |
|-----------|---------|--------------|
| "This route handler is 50 lines of API calls" | **Facade** | `StorageService`, `VideoService` |
| "We might switch from ElevenLabs to OpenAI" | **Strategy** | `TTSService` Protocol + implementations |
| "Test setup needs 12 field combinations" | **Builder** | `VideoFixtureBuilder` |
| "Create the right validator based on file type" | **Factory** | `ValidateUpload()` factory function |
| "UI needs live updates when video finishes" | **Observer** | SSE + `useEventSource` + React Query invalidation |
| "boto3 interface doesn't match our tests" | **Adapter** | `S3Client` Protocol + `InMemoryS3Client` |
| "All CRUD classes share the same flow" | **Template Method** | `BaseCrud` with overridable steps |
| "Queue this operation for background execution" | **Command** | Celery `process_video.delay()` |

### Combinations That Work Together

| Combo | Use Case |
|-------|----------|
| **Facade + Strategy** | Service facade delegates to interchangeable providers |
| **Factory + Strategy** | Factory selects which strategy implementation to use |
| **Observer + Command** | SSE events trigger React Query invalidation (commands) |
| **Template + Strategy** | Base pipeline flow (template) with swappable stage implementations (strategy) |
| **Builder + Factory** | Factory creates builders, builders produce complex objects |
