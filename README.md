<div align="center">

# AI Pipeline System

### Async Python data pipelines at scale. FastAPI gateway, Celery orchestration, isolated workers, dedicated DLQ, structured logging with request IDs.

![License](https://img.shields.io/badge/license-MIT-3b82f6)
![Built by HyperionAI](https://img.shields.io/badge/built_by-HyperionAI-0f172a)
![Stack](https://img.shields.io/badge/stack-FastAPI_·_Celery_·_Claude-64748b)

[View Design Doc (PDF)](DESIGN_DOC.pdf) · [Architecture](docs/architecture.md) · [Implementation Plan](IMPLEMENTATION_PLAN.md)

---

![Architecture](docs/architecture.svg)

</div>

## What this is

A production pattern for teams running many async Python pipelines in parallel. Demonstrates the shape that holds up at 19+ interlocked tools: FastAPI gateway, Celery + Redis orchestration, isolated workers per pipeline tool, dedicated DLQ, structured logging with request IDs propagated across every hop.

Most async Python pipelines work fine at 2-3 tools and fall over at 10+. Silent retry failures, scattered logs, one bad worker starving the rest, 3am debugging sessions that take hours. This reference shows the pattern that scales.

## Why this exists

- **FastAPI gateway** - one place where jobs enter, one auth layer, one audit log
- **Celery + Redis with explicit DLQ** - retries bounded, exhausted jobs never silently lost
- **Isolated workers per pipeline tool** - a broken video renderer cannot starve the LLM worker
- **Structured logging with request IDs** - grep one ID, see the full job history across all workers
- **Observability by default** - Sentry for errors, Flower for queue health, Structlog for traces

## Documentation

**[Design Doc (PDF)](DESIGN_DOC.pdf)** — Branded system design with diagrams, tool choices, phases, and risks.

**[Architecture](docs/architecture.md)** — Layered view with component responsibilities and design decisions.

**[Implementation Plan](IMPLEMENTATION_PLAN.md)** — 3-phase build plan with milestones and risks.

**[Flow Diagram](docs/flow.svg)** — Sequence diagram of job lifecycle (happy + retry + DLQ paths).

## Stack

| Layer | Technology |
|-------|-----------|
| API Gateway | FastAPI + Pydantic |
| Task Queue | Celery + Redis |
| Workers | Celery (one class per pipeline tool) |
| Scheduler | Celery Beat |
| Database | Postgres + SQLAlchemy |
| Object Storage | S3 (boto3) |
| Observability | Structlog + Sentry + Flower |
| LLM | Anthropic Claude 3.5 Sonnet |

## Quick Start

```bash
pnpm install
docker compose -f docker-compose.local.yml up -d
cd apps/api && poetry install && poetry run alembic upgrade head && cd ../..
pnpm dev
```

## Who this is for

**Technical founders** running a growing stable of async Python tools and starting to feel the pain of retries, silent failures, and scattered logs.

**Developers hired to add the 20th pipeline** - fork this repo, see the isolation + DLQ + observability pattern before designing your next worker.

**Ops engineers inheriting a Python pipeline mess** - the runbook pattern here will save you a quarter of firefighting.

---

<div align="center">

## About the author

<img src="https://hyperionai.dev/founder.png" width="120" style="border-radius:50%" alt="Vitalijus Alsauskas" />

### Vitalijus Alsauskas

Founder, HyperionAI

[LinkedIn](https://www.linkedin.com/in/vitalijus-hyperion/) · [GitHub](https://github.com/Vitals9367) · [hyperionai.dev](https://hyperionai.dev)

</div>

4 years at IBM on Fortune 500 systems. Now running FastAPI + Claude pipelines on Bulk Video Pipeline (Lead Alliances client, async video ad production at scale) and Fit7D (FastAPI + Claude dialogue platform). Claude Code is my daily workflow.

---

<div align="center">

## Interested in building something like this?

I offer a free 30-minute scoping call for teams running many async Python pipelines.

### [Book a call](https://cal.com/vitalijus-alsauskas/project-request?overlayCalendar=true)

or reach out via [LinkedIn](https://www.linkedin.com/in/vitalijus-hyperion/)

</div>

---

## License

MIT. Fork, adapt, ship.
