# Refactoring SOP — Techniques for FastAPI + React Stack

> When and how to apply each refactoring technique. Organized by code smell.
>
> Reference: [refactoring.guru/refactoring](https://refactoring.guru/refactoring)

---

## How to Use This Guide

1. Spot the code smell (left column)
2. Apply the technique (right column)
3. Run tests before AND after

**Golden rule:** Refactor in tiny steps. Each step should leave the codebase working. Never refactor and add features in the same commit.

---

## 1. Long Methods → Composing Methods

### Extract Method

**Smell:** A method does multiple things. You can describe a chunk with a phrase.

```python
# BEFORE — route handler doing everything
@router.post("/batches/upload")
async def upload_batch(file: ValidatedFileDep, crud: BatchCrudDep):
    # Parse file
    wb = openpyxl.load_workbook(io.BytesIO(file.contents))
    sheet = wb.active
    headers = [cell.value for cell in sheet[1]]
    rows = [[cell.value for cell in row] for row in sheet.iter_rows(min_row=2)]

    # Validate rows
    valid_rows = []
    for row in rows:
        if row[0] and len(row[0]) > 10:
            valid_rows.append(row)

    # Create batch
    batch = await crud.create(BatchCreate(name=file.filename, total_videos=len(valid_rows)))
    return batch

# AFTER — each chunk is a named method
@router.post("/batches/upload")
async def upload_batch(file: ValidatedFileDep, crud: BatchCrudDep):
    parsed = parse_excel(file.contents)
    valid_rows = validate_script_rows(parsed.rows)
    batch = await crud.create(BatchCreate(name=file.filename, total_videos=len(valid_rows)))
    return batch
```

### Extract Variable

**Smell:** Complex expression that's hard to read.

```python
# BEFORE
if video.status == VideoStatus.finished and video.output_url and (datetime.now(UTC) - video.created_at).days < 7:
    return generate_presigned_url(video.output_url)

# AFTER
is_downloadable = video.status == VideoStatus.finished and video.output_url is not None
is_not_expired = (datetime.now(UTC) - video.created_at).days < 7

if is_downloadable and is_not_expired:
    return generate_presigned_url(video.output_url)
```

### Replace Temp with Query

**Smell:** A temp variable used once, and the expression is clear enough as a method.

```python
# BEFORE
base_price = self._quantity * self._item_price
discount = max(0, self._quantity - 500) * self._item_price * 0.05
return base_price - discount

# AFTER
@property
def base_price(self) -> float:
    return self._quantity * self._item_price

@property
def discount(self) -> float:
    return max(0, self._quantity - 500) * self._item_price * 0.05

def total(self) -> float:
    return self.base_price - self.discount
```

---

## 2. Feature Envy → Moving Features Between Objects

### Move Method

**Smell:** A method uses more data from another class than its own.

```python
# BEFORE — route handler reaches into video fields repeatedly
@router.get("/{video_id}/download")
async def download_video(video: VideoDep, storage: StorageDep):
    if video.status != VideoStatus.finished:
        raise HTTPException(400, "Not ready")
    key = f"videos/{video.id}/output.mp4"
    url = storage.generate_presigned_url(key)
    return {"url": url}

# AFTER — Video model owns its S3 key derivation
class Video(BaseModel):
    @property
    def output_key(self) -> str:
        return f"videos/{self.id}/output.mp4"

    @property
    def is_downloadable(self) -> bool:
        return self.status == VideoStatus.finished and self.output_url is not None

# Route is thin:
@router.get("/{video_id}/download")
async def download_video(video: VideoDep, storage: StorageDep):
    if not video.is_downloadable:
        raise HTTPException(400, "Not ready")
    return {"url": storage.generate_presigned_url(video.output_key)}
```

### Extract Class

**Smell:** One class does two jobs.

```python
# BEFORE — VideoCrud handles both data access AND business logic
class VideoCrud:
    async def create(self, obj_in):
        # CRUD
    async def calculate_costs(self, video_id):
        # Business logic — doesn't belong here
    async def send_progress_event(self, video):
        # Event publishing — doesn't belong here

# AFTER — split into CRUD (data) and Service (logic)
class VideoCrud(BaseCrud[Video, VideoCreate, VideoUpdate]):
    # Only data access

class VideoService:
    def __init__(self, crud: VideoCrud, events: EventService):
        self._crud = crud
        self._events = events

    async def calculate_costs(self, video_id): ...
    async def send_progress_event(self, video): ...
```

### Hide Delegate

**Smell:** Client navigates object chains: `video.batch.name`

```python
# BEFORE — template reaches through relationships
batch_name = video.batch.name if video.batch else "No batch"

# AFTER — Video exposes what callers need
class Video(BaseModel):
    @property
    def batch_name(self) -> str:
        return self.batch.name if self.batch else "No batch"
```

```typescript
// React equivalent — component reaches into nested data
// BEFORE
<span>{video.batch?.name ?? "No batch"}</span>

// AFTER — derive in the data layer or a helper
function getVideoDisplayName(video: VideoRead): string {
  return video.batch_name ?? `Video ${video.id.slice(0, 8)}`;
}
```

---

## 3. Primitive Obsession → Organizing Data

### Replace Magic Number with Symbolic Constant

```python
# BEFORE
if len(contents) > 10485760:  # What is this?
    raise HTTPException(400, "File too large")

# AFTER
UPLOAD_MAX_FILE_SIZE = 10 * 1024 * 1024  # 10 MB — or use settings

if len(contents) > settings.UPLOAD_MAX_FILE_SIZE:
    raise HTTPException(400, f"File too large. Max {settings.UPLOAD_MAX_FILE_SIZE // 1024 // 1024}MB")
```

### Replace Type Code with Enum

```python
# BEFORE — string literals scattered everywhere
video.status = "processing"
if video.status == "failed":
    ...

# AFTER — str,Enum for type safety
class VideoStatus(str, enum.Enum):
    processing = "processing"
    finished = "finished"
    failed = "failed"
    expired = "expired"

video.status = VideoStatus.processing
if video.status == VideoStatus.failed:
    ...
```

### Replace Data Value with Object

```python
# BEFORE — cost is just two loose fields
class VideoRead(BaseModel):
    tts_cost_usd: float = 0.0
    tts_token_count: int = 0
    segmentation_cost_usd: float = 0.0
    segmentation_token_count: int = 0

# AFTER — bundle related data into a value object
class AICost(BaseModel):
    token_count: int = 0
    cost_usd: float = 0.0

class VideoRead(BaseModel):
    tts: AICost = AICost()
    segmentation: AICost = AICost()
```

### Encapsulate Collection

```python
# BEFORE — exposing list directly
class Batch(BaseModel):
    videos: list[Video] = []

# Caller can do anything: batch.videos.clear(), batch.videos.append(garbage)

# AFTER — controlled access
class Batch(BaseModel):
    _videos: list[Video] = []

    @property
    def videos(self) -> tuple[Video, ...]:
        return tuple(self._videos)  # Read-only view

    def add_video(self, video: Video) -> None:
        # Validation, side effects, etc.
        self._videos.append(video)
```

---

## 4. Complex Conditionals → Simplifying Conditionals

### Decompose Conditional

```python
# BEFORE
if video.status == VideoStatus.finished and video.output_url and not video.is_expired and video.file_size_bytes > 0:
    return StreamingResponse(storage.stream_file(video.output_key))
elif video.status == VideoStatus.failed:
    raise HTTPException(400, f"Video failed: {video.error_message}")
else:
    raise HTTPException(400, "Video not ready for download")

# AFTER — named conditions
def is_ready_for_download(video: Video) -> bool:
    return (
        video.status == VideoStatus.finished
        and video.output_url is not None
        and not video.is_expired
        and video.file_size_bytes > 0
    )

if is_ready_for_download(video):
    return StreamingResponse(storage.stream_file(video.output_key))
elif video.status == VideoStatus.failed:
    raise HTTPException(400, f"Video failed: {video.error_message}")
else:
    raise HTTPException(400, "Video not ready for download")
```

### Replace Nested Conditional with Guard Clauses

```python
# BEFORE — deeply nested
async def download_video(video: VideoDep, storage: StorageDep):
    if video:
        if video.status == VideoStatus.finished:
            if video.output_url:
                if not video.is_expired:
                    return storage.generate_presigned_url(video.output_key)
                else:
                    raise HTTPException(410, "Expired")
            else:
                raise HTTPException(400, "No output")
        else:
            raise HTTPException(400, "Not finished")
    else:
        raise HTTPException(404, "Not found")

# AFTER — guard clauses (early returns)
async def download_video(video: VideoDep, storage: StorageDep):
    # Guards — handle edge cases first, flat structure
    if video.status != VideoStatus.finished:
        raise HTTPException(400, "Not finished")
    if not video.output_url:
        raise HTTPException(400, "No output")
    if video.is_expired:
        raise HTTPException(410, "Expired")

    # Happy path — no nesting
    return storage.generate_presigned_url(video.output_key)
```

### Replace Conditional with Polymorphism (Strategy)

```python
# BEFORE — switch on provider type
async def generate_tts(text: str, provider: str) -> TTSResult:
    if provider == "elevenlabs":
        client = ElevenLabs(api_key=settings.ELEVENLABS_API_KEY)
        response = client.text_to_speech.convert(text=text)
        return TTSResult(audio=response.audio)
    elif provider == "openai":
        client = openai.Client()
        response = client.audio.speech.create(input=text)
        return TTSResult(audio=response.content)
    elif provider == "google":
        # ... more branches
    else:
        raise ValueError(f"Unknown provider: {provider}")

# AFTER — Strategy pattern (see design-patterns-sop.md §2)
class TTSService(Protocol):
    async def synthesize(self, text: str, voice_id: str) -> TTSResult: ...

class ElevenLabsTTSService:
    async def synthesize(self, text: str, voice_id: str) -> TTSResult: ...

class OpenAITTSService:
    async def synthesize(self, text: str, voice_id: str) -> TTSResult: ...

# No conditional. Inject the right one.
service = create_tts_service(settings.TTS_PROVIDER)
result = await service.synthesize(text, voice_id)
```

### Introduce Null Object

```typescript
// BEFORE — null checks everywhere
function VideoStats({ video }: { video: VideoRead | null }) {
  if (!video) return null;
  if (!video.tts) return <span>-</span>;
  if (!video.tts.cost_usd) return <span>$0.00</span>;
  return <span>${video.tts.cost_usd.toFixed(2)}</span>;
}

// AFTER — default/null object in the schema
class AICost(BaseModel):
    token_count: int = 0     # Null object — defaults are the "null" behavior
    cost_usd: float = 0.0

class VideoRead(BaseModel):
    tts: AICost = AICost()   # Never None, always has a valid default

// Frontend — no null checks needed:
function VideoStats({ video }: { video: VideoRead }) {
  return <span>{formatCurrency(video.tts.cost_usd)}</span>;
}
```

---

## 5. Parameter Overload → Simplifying Method Calls

### Introduce Parameter Object

```python
# BEFORE — 7 params for pagination + filtering
async def list_videos(
    page: int, page_size: int, status: str | None,
    stage: str | None, batch_id: str | None,
    sort_by: str, sort_order: str,
) -> PageResponse[Video]:
    ...

# AFTER — bundle into a schema
class VideoListParams(BaseModel):
    page: int = 1
    page_size: int = Field(default=50, ge=1, le=100)
    status: VideoStatus | None = None
    stage: VideoStage | None = None
    batch_id: uuid.UUID | None = None
    sort_by: str = "created_at"
    sort_order: Literal["asc", "desc"] = "desc"

async def list_videos(params: VideoListParams) -> PageResponse[Video]:
    ...
```

### Replace Constructor with Factory Method

```python
# BEFORE — complex conditional construction
video = Video(
    batch_id=batch_id,
    script_text=row.data["script_text"],
    voice_id=row.data.get("voice_id", default_voice),
    style=row.data.get("style", default_style),
    status=VideoStatus.processing if row.is_valid else VideoStatus.failed,
    error_message=None if row.is_valid else "; ".join(row.errors),
)

# AFTER — factory classmethod
class Video(BaseModel):
    @classmethod
    def from_parsed_row(cls, row: ParsedRow, batch_id: uuid.UUID, defaults: dict) -> "Video":
        return cls(
            batch_id=batch_id,
            script_text=row.data["script_text"],
            voice_id=row.data.get("voice_id", defaults["voice_id"]),
            style=row.data.get("style", defaults["style"]),
            status=VideoStatus.processing if row.is_valid else VideoStatus.failed,
            error_message=None if row.is_valid else "; ".join(row.errors),
        )

# Usage:
video = Video.from_parsed_row(row, batch.id, column_defaults)
```

---

## 6. Bloated Class → Dealing with Generalization

### Extract Superclass (BaseCrud Pattern)

```python
# BEFORE — every CRUD class duplicates the same methods
class VideoCrud:
    async def create(self, obj_in): ...
    async def get(self, id): ...
    async def get_multi(self, page, page_size): ...
    async def update(self, id, obj_in): ...
    async def delete(self, id): ...

class BatchCrud:
    async def create(self, obj_in): ...    # Same logic
    async def get(self, id): ...           # Same logic
    # ... duplicated

# AFTER — pull common logic into BaseCrud
class BaseCrud(Generic[ModelType, CreateSchemaType, UpdateSchemaType]):
    # All shared CRUD logic here

class VideoCrud(BaseCrud[Video, VideoCreate, VideoUpdate]):
    def __init__(self, session: SessionDep):
        super().__init__(session=session, model=Video)
    # Only domain-specific queries

class BatchCrud(BaseCrud[Batch, BatchCreate, BatchUpdate]):
    def __init__(self, session: SessionDep):
        super().__init__(session=session, model=Batch)
```

### Replace Inheritance with Delegation

```python
# BEFORE — inheriting for code reuse (wrong reason)
class VideoService(StorageService):
    def process(self, video):
        self.upload_file(...)  # Inherited from StorageService

# AFTER — composition (has-a, not is-a)
class VideoService:
    def __init__(self, storage: StorageService):
        self._storage = storage  # Delegation

    def process(self, video):
        self._storage.upload_file(...)  # Delegates
```

---

## 7. React-Specific Refactoring

### Extract Component (= Extract Method for React)

```typescript
// BEFORE — one massive component
function VideoDetailPage() {
  return (
    <div>
      {/* 30 lines of header JSX */}
      {/* 50 lines of stats JSX */}
      {/* 40 lines of shots table JSX */}
    </div>
  );
}

// AFTER — extracted into _components/
function VideoDetailPage() {
  return (
    <div>
      <VideoHeader video={video} />
      <VideoStats video={video} />
      <ShotsTable shots={video.shots} />
    </div>
  );
}
```

### Extract Custom Hook (= Extract Method for state logic)

```typescript
// BEFORE — polling logic mixed into component
function VideoDetail({ videoId }: Props) {
  const queryClient = useQueryClient();
  const { data: video } = useGetVideoApiV1VideosVideoIdGet(videoId);

  useEffect(() => {
    if (video?.status !== "processing") return;
    const es = new EventSource(`/api/v1/events/videos/${videoId}`);
    es.onmessage = () => queryClient.invalidateQueries({ queryKey: [...] });
    return () => es.close();
  }, [video?.status, videoId, queryClient]);

  // ... rest of component
}

// AFTER — extracted hook
function VideoDetail({ videoId }: Props) {
  const { data: video } = useGetVideoApiV1VideosVideoIdGet(videoId);
  useEventSource(videoEventsUrl(videoId), video?.status === "processing", [queryKey]);
  // ... clean component
}
```

### Lift State Up / Push State Down

```typescript
// Push state DOWN when only one child uses it:
// BEFORE — parent manages dialog state for no reason
function BatchList() {
  const [dialogOpen, setDialogOpen] = useState(false);
  return <CreateBatchDialog open={dialogOpen} onOpenChange={setDialogOpen} />;
}

// AFTER — dialog manages its own state
function BatchList() {
  return <CreateBatchDialog />;  // Dialog owns open/close internally
}
```

---

## Refactoring Decision Tree

```
Is the method > 20 lines?
├── Yes → Extract Method / Extract Component
└── No
    Is there a complex conditional?
    ├── Yes → Guard clauses? Decompose? Strategy pattern?
    └── No
        Is a class doing two jobs?
        ├── Yes → Extract Class / Extract Service
        └── No
            Are there magic numbers/strings?
            ├── Yes → Constants / Enums
            └── No
                Is there duplicated code?
                ├── Yes → Extract Superclass / Extract Hook
                └── No
                    Are params > 5?
                    ├── Yes → Introduce Parameter Object
                    └── No → Leave it alone
```

---

## When NOT to Refactor

- Code is working and you're not touching it for a feature/bug
- You're in the middle of implementing a feature (finish first, refactor after)
- The "improvement" adds complexity without removing it elsewhere
- The code will be deleted soon
- You don't have tests covering the area (write tests first, then refactor)
