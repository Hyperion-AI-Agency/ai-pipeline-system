# CLAUDE.md

This file is the operational foundation for Claude Code. Read it at session start. Follow it exactly.

---

## What This Project Is

Reference architecture for teams running 19+ interlocked Python pipelines. Demonstrates FastAPI gateway, Celery + Redis with DLQ, isolated workers per tool, structured logging.

## Stack

| Layer | Technology |
|-------|-----------|
| API Gateway | FastAPI + Pydantic |
| Task Queue | Celery + Redis |
| Scheduler | Celery Beat |
| Workers | Celery (isolated per pipeline tool) |
| Database | Postgres + SQLAlchemy |
| Object Storage | S3 |
| Observability | Structlog + Sentry + Flower |
| LLM | Anthropic Claude 3.5 Sonnet |

---

## Commands

| Command | Purpose |
|---------|---------|
| `/test` | Run tests |
| `/lint` | Run linter |
| `/dev` | Start local dev environment |
| `/replay-dlq` | Replay a job from the DLQ |

---

## Conventions

- One worker class per pipeline tool - never a shared monolithic worker

- Every task declares explicit retry + timeout + concurrency

- Exhausted-retry jobs go to DLQ, never silently disappear

- Structlog + request ID propagated across every service and external API call

- No secrets in code - use .env and GitHub secrets

---

## Operational Rules

1. **Never hardcode secrets.** API keys, passwords, connection strings go in environment variables or secret managers.
2. **Follow existing patterns.** Read existing code before modifying. Match the style.
3. **Test before committing.** Run the test suite and linters before pushing.
4. **One concern per change.** Keep PRs focused on a single feature or fix.
