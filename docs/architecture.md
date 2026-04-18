# Architecture

## Overview

Application is a betting signals platform built as a monorepo:

- **Frontend**: Next.js 15 dashboard (apps/nextjs)
- **Backend**: FastAPI API server (apps/api)
- **Workers**: Celery + Redis for background tasks
- **Database**: PostgreSQL (separate DBs for app and API)

## System Diagram

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│   Next.js   │────▶│   FastAPI     │────▶│  PostgreSQL  │
│  Dashboard  │     │   API Server  │     │  (API DB)    │
└─────────────┘     └──────┬───────┘     └─────────────┘
                           │
                    ┌──────▼───────┐     ┌─────────────┐
                    │    Celery     │────▶│    Redis     │
                    │   Workers     │     │   (Broker)   │
                    └──────────────┘     └─────────────┘
```

## Stack

| Layer | Technology |
|-------|-----------|
| Frontend | Next.js 15, React 19, TailwindCSS, shadcn/ui |
| Backend | FastAPI, SQLAlchemy, Alembic, Pydantic |
| Background Jobs | Celery, Redis |
| Database | PostgreSQL 17 |
| Auth | Better Auth (Next.js) + OAuth JWT (FastAPI) |
| API Client | Orval (generated from OpenAPI) |
| Reverse Proxy | Traefik (auto HTTPS via Let's Encrypt) |
| CI/CD | GitHub Actions (semantic-release + Docker SSH deploy) |

## Project Structure

```
├── apps/
│   ├── api/              # FastAPI backend
│   │   ├── api/          # Application code
│   │   │   ├── core/     # Health, root routes
│   │   │   ├── deps/     # Dependencies (db, auth, celery, sentry)
│   │   │   ├── settings.py
│   │   │   └── app.py    # App factory
│   │   ├── __tests__/    # pytest tests
│   │   ├── migrations/   # Alembic DB migrations
│   │   └── Dockerfile
│   └── nextjs/           # Next.js frontend
│       ├── src/
│       │   ├── app/      # App Router pages
│       │   ├── components/
│       │   ├── server/   # tRPC, auth, db
│       │   └── actions/  # Server actions
│       └── Dockerfile
├── packages/
│   ├── api-client/       # Generated API client (Orval)
│   ├── sentry/           # Shared Sentry config
│   └── ui/               # shadcn/ui components
├── docs/                 # Project documentation
├── docker-compose.local.yml   # Local dev (Traefik, Postgres, Redis)
├── docker-compose.prod.yml    # Production (Traefik + HTTPS, API, App)
└── .github/workflows/
    ├── ci.yml            # PR tests
    ├── gitleaks.yml      # Secret scanning
    └── deploy.yml        # Release + Docker SSH deploy
```

## Deployment

Push to `main` triggers:
1. CI (tests, lint, gitleaks)
2. Semantic Release (creates GitHub release + changelog)
3. Docker build → tarball → rsync to server
4. SSH: docker compose up with env vars from GitHub secrets
5. Health check verification
