# Architecture

This document describes the architecture of the async Python pipelines reference.

Two views:

- **Structural** - layered architecture in [architecture.svg](architecture.svg)
- **Dynamic** - job lifecycle sequence in [flow.svg](flow.svg)

---

## Structural View

![Architecture](architecture.svg)

Source: [`architecture.d2`](architecture.d2)

### Layers

| Layer | Role | Tech |
|-------|------|------|
| Triggers | How jobs enter the system | Scheduler, webhooks, manual CLI |
| API Gateway | Request routing, auth, audit | FastAPI + Pydantic |
| Task Queue | Job broker + DLQ | Celery + Redis |
| Worker Pool | The 19+ pipeline tools running async | Celery workers per domain |
| Observability | Logs + errors + queue inspection | Structlog, Sentry, Flower |
| Data | State, artifacts, cache | Postgres, S3, Redis |
| External APIs | Third-party services | Claude, OpenAI, YouTube Data API, outbound webhooks |

### Component Responsibilities

**API Gateway**
- Public FastAPI endpoints for job submission and status
- Key-based auth for client apps, JWT for internal UIs
- Every mutating request logged for audit

**Task Queue**
- Redis as broker for Celery
- Celery Beat for scheduled jobs
- Dedicated DLQ for jobs that exhaust retry budget (not silently lost)

**Worker Pool**
- One worker class per pipeline tool (YouTube, transcription, LLM, video render, upload, thumbnails, analytics, etc.)
- Workers are isolated - a broken video render worker cannot starve the LLM worker
- Each worker declares its concurrency, retry policy, and timeout explicitly

**Observability**
- Structlog emits JSON with request IDs so you can trace a job across workers
- Sentry captures exceptions with local variable context
- Flower gives operational visibility into queue depth, task duration, worker health

**Data**
- Postgres holds job state, metadata, results summary (not artifacts)
- S3 holds video files, transcripts, large artifacts
- Redis cache for dedup keys, short-lived data

---

## Dynamic View

![Flow](flow.svg)

Source: [`flow.d2`](flow.d2)

### Happy path (steps 1-12a)

Client submits a job, API persists it and enqueues, worker dequeues, logs start, calls Claude, stores artifacts to S3, updates DB, fires outbound webhook. Client app sees `done` status and can download results.

### Retryable failure (steps 10b-12b)

Worker catches a retryable error (network timeout, rate limit, 5xx from Claude), logs it to Sentry, requeues with exponential backoff. Typically resolves on retry 2 or 3.

### Exhausted retries (steps 13c-16c)

After the retry budget is exhausted, the job moves to the DLQ. The DB row is updated to `failed` with the error context, Sentry fires a critical alert, and the client receives a failure webhook. Nothing silently disappears.

---

## Key Design Decisions

### Why Celery + Redis over serverless (Lambda, Cloud Run Jobs)?

At 19+ pipeline tools with sustained throughput, serverless pricing stops being an advantage. Celery workers autoscale on queue depth cheaper, and Redis gives fine-grained control over retry + DLQ that Lambda makes awkward. Also: locally reproducible with `docker-compose up`, which Lambda is not.

### Why a dedicated Dead Letter Queue?

The first mistake most async pipelines make is treating retries as "it will eventually succeed". When a job exhausts retries, it vanishes from the live queue and the bug becomes invisible. A separate DLQ with alerting means every failure is seen, triaged, and either fixed or replayed.

### Why isolate workers per tool?

A malformed input in the video render worker should not block the LLM worker from processing today's Claude extraction jobs. Worker isolation means a bug in one tool does not become a platform-wide incident.

### Why structured logging with request IDs?

When a job crosses 4 workers (trigger → API → queue → worker → external API → webhook callback), the only way to debug "why is this job stuck" is to grep by request ID across all worker logs. Structlog + a single request ID attached at ingress makes this trivial.

### Why include Flower?

Flower is the first thing you want at 2am when the queue backs up. Seeing "worker X has 400 tasks queued, worker Y has 0" tells you in 30 seconds what grep across 19 log streams would take 30 minutes to diagnose.
