# Next.js + FastAPI Template

Full-stack monorepo template with Next.js 15, FastAPI, Celery + Redis, Docker SSH deploy, and Claude Code setup.

## Stack

- **Frontend**: Next.js 15, React 19, TailwindCSS, shadcn/ui
- **Backend**: FastAPI, SQLAlchemy, Alembic
- **Workers**: Celery + Redis
- **Database**: PostgreSQL 17
- **Auth**: Better Auth + OAuth
- **Analytics**: PostHog
- **Deploy**: Docker + SSH (GitHub Actions)

## Quick Start

```bash
pnpm install
docker compose -f docker-compose.local.yml up -d
cd apps/api && poetry install && poetry run alembic upgrade head && cd ../..
pnpm dev
```

## Structure

```
apps/
├── api/          # FastAPI + Celery workers
└── nextjs/       # Next.js dashboard
packages/
├── analytics/    # PostHog
├── api-client/   # Generated API client (Orval)
├── sentry/       # Error tracking
└── ui/           # shadcn/ui components
```

## Documentation

- [Architecture](docs/architecture.md)
- [Development Setup](docs/development.md)
