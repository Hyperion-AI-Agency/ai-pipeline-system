# Development Setup

## Prerequisites

- Node.js 22+ (see `.nvmrc`)
- pnpm 10.11+
- Python 3.12+
- Poetry 2.2+
- Docker + Docker Compose

## Getting Started

```bash
# 1. Install JS dependencies
pnpm install

# 2. Start infrastructure (Postgres, Redis, Traefik)
docker compose -f docker-compose.local.yml up -d

# 3. Install Python dependencies
cd apps/api && poetry install && cd ../..

# 4. Run DB migrations
cd apps/api && poetry run alembic upgrade head && cd ../..

# 5. Start all apps
pnpm dev
```

## Services (local)

| Service | URL |
|---------|-----|
| Next.js app | http://localhost:3000 |
| FastAPI docs | http://localhost:8000/docs |
| Traefik dashboard | http://localhost:8090 |
| PostgreSQL (app) | localhost:5432 |
| PostgreSQL (api) | localhost:5433 |
| Redis | localhost:6379 |

## Common Commands

```bash
# Dev
pnpm dev                    # Start all apps
pnpm build                  # Build everything
pnpm lint                   # Lint all packages

# Backend
cd apps/api
poetry run start            # Start FastAPI only
poetry run pytest           # Run backend tests
poetry run alembic revision --autogenerate -m "description"  # New migration
poetry run alembic upgrade head   # Apply migrations
poetry run celery-worker    # Start Celery worker

# Frontend
cd apps/nextjs
pnpm dev                    # Start Next.js
pnpm build                  # Production build
pnpm test                   # Run tests
pnpm test:e2e               # Run Playwright E2E tests

# API Client
pnpm run generate-api       # Regenerate from OpenAPI spec
```

## Environment Variables

### API (`apps/api/.env`)
```
API_DATABASE_URL=postgresql+asyncpg://postgres:postgres@localhost:5433/api
API_CELERY_BROKER_URL=redis://localhost:6379/0
API_CELERY_RESULT_BACKEND=redis://localhost:6379/0
```

### Next.js (`apps/nextjs/.env`)
```
APP_DATABASE_URL=postgresql://postgres:postgres@localhost:5432/postgres
APP_BETTER_AUTH_SECRET=your-secret
NEXT_PUBLIC_APP_URL=http://localhost:3000
NEXT_PUBLIC_POSTHOG_KEY=phc_xxx
NEXT_PUBLIC_POSTHOG_HOST=https://eu.i.posthog.com
```
