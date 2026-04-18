<div align="center">

# AI Pipeline System

### Async Python data pipelines at scale. FastAPI gateway, Celery orchestration, isolated workers, dedicated DLQ, structured logging with request IDs.

![License](https://img.shields.io/badge/license-MIT-3b82f6)
![Built by Hyperion AI](https://img.shields.io/badge/built_by-Hyperion_AI-0f172a)
![Stack](https://img.shields.io/badge/stack-FastAPI_·_Celery_·_Claude-64748b)
![GitHub Repo stars](https://img.shields.io/github/stars/Hyperion-AI-Agency/ai-pipeline-system?style=flat&color=fbbf24)
![Last Commit](https://img.shields.io/github/last-commit/Hyperion-AI-Agency/ai-pipeline-system?color=3b82f6)

---

<img src="docs/architecture.svg" width="100%" alt="Architecture" />

[Design Doc](DESIGN_DOC.pdf) · [Architecture](docs/architecture.md) · [Quickstart](#quick-start) · [Book a call](https://cal.com/vitalijus-alsauskas/project-request?overlayCalendar=true)

</div>

> [!NOTE]
> This is a reference architecture shared as a starting point, not a production service. Fork it, adapt the workers to your tools, ship faster.

## What this is

A full-stack async Python system for teams running many data pipelines in parallel. FastAPI gateway in front, Celery + Redis orchestration, one isolated worker class per pipeline tool, and a dedicated DLQ so exhausted-retry jobs are never silently lost.

Most async Python pipelines work fine at 2-3 tools and fall over at 10+. Silent retry failures, scattered logs, one bad worker starving the rest, 3am debugging sessions that take hours. This system is built around the shape that holds at 19+ interlocked tools.

## Why this exists

- **FastAPI gateway** - one place where jobs enter, one auth layer, one audit log
- **Celery + Redis with explicit DLQ** - retries bounded, exhausted jobs never silently lost
- **Isolated workers per pipeline tool** - a broken video renderer cannot starve the LLM worker
- **Structured logging with request IDs** - grep one ID, see the full job history across all workers
- **Observability by default** - Sentry for errors, Flower for queue health, Structlog for traces

## Documentation

**[Design Doc (PDF)](DESIGN_DOC.pdf)** — Branded system design with diagrams, tool choices, phases, and risks.

**[Architecture](docs/architecture.md)** — Layered view with component responsibilities and design decisions.

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
make dev
```

Runs install + docker + migrations + dev server in one command. See `make help` for the full list.

> [!TIP]
> Prefer not to run this yourself? [Book a 30-minute scoping call](https://cal.com/vitalijus-alsauskas/project-request?overlayCalendar=true) and I'll map this to your pipeline fleet.

## Who this is for

**Technical founders** running a growing stable of async Python tools and starting to feel the pain of retries, silent failures, and scattered logs.

**Developers hired to add the 20th pipeline** - fork this repo, see the isolation + DLQ + observability pattern before designing your next worker.

**Ops engineers inheriting a Python pipeline mess** - the runbook pattern here will save you a quarter of firefighting.

---

<table>
<tr>
<td width="240" valign="top">
<img src="https://hyperionai.dev/founder.png" width="220" alt="Vitalijus Alsauskas" />
</td>
<td valign="top">

### Vitalijus Alsauskas

Software and AI Engineer

Software dev from Lithuania, worked at IBM, living in Vietnam. Building enterprise-level tools for startups and companies.

[LinkedIn](https://www.linkedin.com/in/vitalijus-hyperion/) · [GitHub](https://github.com/Vitals9367) · [hyperionai.dev](https://hyperionai.dev)

</td>
</tr>
</table>

---

### Request a project

Send me your project brief. I reply within 24 hours.

**[cal.com/vitalijus-alsauskas/project-request →](https://cal.com/vitalijus-alsauskas/project-request?overlayCalendar=true)**

Or reach out via [LinkedIn](https://www.linkedin.com/in/vitalijus-hyperion/).

---

## License

MIT. Fork, adapt, ship.
