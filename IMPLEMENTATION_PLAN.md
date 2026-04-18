# Implementation Plan

Phased build plan for async Python pipelines running 19+ interlocked tools in parallel.

---

## Problem Statement

Teams running many Python tools async hit a wall when scale goes past a handful: retries mask silent failures, one bad worker starves the rest, 3am debugging means reading 19 log streams. This plan ships in three two-week phases, with a working skeleton by the end of week 2 and full pipeline coverage by week 6.

---

## Phase 1: Foundation (week 1-2)

**Shipping:** Working skeleton handling one pipeline tool end-to-end with full retry + DLQ behavior.

### Milestones

- [ ] FastAPI gateway with `/jobs` POST + GET status endpoint
- [ ] Celery + Redis + Beat wired up via docker-compose for local dev
- [ ] One worker class (YouTube Data API) working end-to-end
- [ ] Structlog config shared across all services (request IDs propagated)
- [ ] Sentry SDK integrated for Python async + Celery
- [ ] Flower dashboard behind basic auth
- [ ] Dedicated DLQ with monitoring service + alerts
- [ ] Integration tests for happy path, retryable error, DLQ path
- [ ] CI on every PR (ruff + pytest)

### Definition of done

An operator can submit a job via the API, watch it run in Flower, see structured logs in real time, verify retry behavior by forcing an error, and confirm the DLQ fires an alert when retries exhaust.

---

## Phase 2: Pipeline Coverage (week 3-4)

**Shipping:** All 19 pipeline tools migrated or wrapped into Celery workers with isolated queues.

### Milestones

- [ ] One Celery worker class per tool, isolated queues
- [ ] Per-tool concurrency + retry + timeout policies declared in code
- [ ] Shared test harness for worker integration tests
- [ ] Load testing at 3x expected peak throughput
- [ ] Rate limiter in front of LLM worker (Claude specifically)
- [ ] Per-worker runbook stubs: "what to do if worker X queue backs up"

### Definition of done

Every pipeline tool runs as an isolated Celery worker. Killing any one worker does not affect the others. Load test at 3x peak completes within SLA.

---

## Phase 3: Production Polish (week 5-6)

**Shipping:** Observability refined, DLQ replay workflow, production deploy with autoscaling.

### Milestones

- [ ] Request ID propagation through every worker + external API call
- [ ] DLQ replay CLI (`python manage.py replay-dlq <job-id>`)
- [ ] Full runbook covering: queue backup, worker crash, Claude rate limit, S3 outage
- [ ] Claude Code slash commands: `/test`, `/lint`, `/dev`, `/replay-dlq`, `/worker-logs`
- [ ] Production deploy via GitHub Actions
- [ ] Queue-depth alerts (warn at 100, critical at 500)
- [ ] Knowledge transfer session + recorded walkthrough

### Definition of done

On-call can triage any pipeline incident from the runbook in under 10 minutes. Autoscaling holds SLA under 3x peak load without manual intervention.

---

## Risks & Mitigations

| Risk | Mitigation |
|------|------------|
| Malformed input in one worker blocks the whole queue | Worker isolation per tool. Each worker has its own queue + pool. Hard timeouts on every task. |
| Retries mask silent failures | Dedicated DLQ. Every exhausted-retry job moves here, fires Sentry critical, updates DB to `failed`, sends failure webhook. |
| 3am debugging requires reading 19 log streams | Structlog + request ID at ingress, propagated everywhere. One grep locates a job across all workers. |
| Claude API rate limits during peak | Per-worker concurrency caps + exponential backoff on 429 + Claude-specific rate limiter. Fallback to Haiku under extreme load. |
| Production worker pool autoscaling misconfigured | Queue-depth alerts (warn 100, critical 500). Autoscaling tied to queue depth not CPU. Flower accessible from phone. |

---

## What I Need From You

To move into Phase 1:

- **Read access to the existing codebase** or a representative sample
- **A list of the 19+ tools** with one-liners per tool
- **Current deployment target** (Hetzner VM / Container Apps / k8s / bare metal)
- **Ranked pain points** - is 3am debugging the worst, or rate limits, or onboarding new pipelines?
- **30-minute kickoff call** to walk through this plan against your actual setup
