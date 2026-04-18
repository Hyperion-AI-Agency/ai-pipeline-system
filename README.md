# Async Python Pipelines at Scale - Reference Architecture

Reference architecture for teams running many async Python pipelines in parallel. Demonstrates the pattern that holds up at 19+ interlocked tools: FastAPI gateway, Celery + Redis orchestration, isolated workers per tool, dedicated DLQ, structured logging with request IDs.

Built by [Vitalijus Alsauskas / HyperionAI](https://www.linkedin.com/in/vitalijus-hyperion/) as a public reference for teams scaling async Python past the point where naive setups break.

---

## Why this exists

Most async Python pipelines work fine at 2-3 tools and fall over at 10+. Silent retry failures, scattered logs, one bad worker starving the rest, 3am debugging sessions that take hours. This reference shows the pattern that survives:

1. **FastAPI gateway** - one place where jobs enter, one auth layer, one audit log
2. **Celery + Redis with explicit DLQ** - retries bounded, exhausted jobs never silently lost
3. **Isolated workers per pipeline tool** - a broken video renderer cannot starve the LLM worker
4. **Structured logging with request IDs** - grep one ID, see the full job history across all workers
5. **Observability by default** - Sentry for errors, Flower for queue health, Structlog for traces

---

## Documentation

| Document | Purpose |
|----------|---------|
| [docs/architecture.md](docs/architecture.md) | Layered architecture + component responsibilities |
| [docs/architecture.svg](docs/architecture.svg) | Architecture diagram (rendered) |
| [docs/flow.svg](docs/flow.svg) | Job lifecycle sequence (happy + retry + DLQ paths) |
| [DESIGN_DOC.pdf](DESIGN_DOC.pdf) | Branded design doc with reasoning, tool choices, risks |
| [IMPLEMENTATION_PLAN.md](IMPLEMENTATION_PLAN.md) | Phase-by-phase build plan with milestones and risks |
| [CLAUDE.md](CLAUDE.md) | Operational rules for Claude Code working in this codebase |

---

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
| Container runtime | Docker + docker-compose |

---

## Quick Start (local dev)

```bash
pnpm install
docker compose -f docker-compose.local.yml up -d
cd apps/api && poetry install && poetry run alembic upgrade head && cd ../..
pnpm dev
```

---

## Who this is for

**Technical founders** running a growing stable of async Python tools and starting to feel the pain of retries, silent failures, and scattered logs.

**Developers hired to add the 20th pipeline** - fork this repo, see the isolation + DLQ + observability pattern before designing your next worker.

**Ops engineers inheriting a Python pipeline mess** - the runbook pattern here will save you a quarter of firefighting.

---

## About

Built by Vitalijus Alsauskas. Ex-IBM (4 years, Fortune 500 clients). Currently running FastAPI + Claude pipelines on Bulk Video Pipeline (Lead Alliances client) and Fit7D (FastAPI + Claude dialogue platform). Claude Code is my daily workflow.

If you are running many async Python pipelines and want a second set of eyes, I offer a free 30-minute scoping call - reach out via LinkedIn or [vitalijus.io](https://vitalijus.io).

- GitHub: https://github.com/Vitals9367
- LinkedIn: https://www.linkedin.com/in/vitalijus-hyperion/

---

## License

MIT. Fork, adapt, ship.
