# Infrastructure SOP — Monorepo + Docker + CI/CD

> Production-grade patterns for pnpm monorepos with Docker deployment. Copy-paste ready.

---

## 1. Monorepo Structure (Turborepo + pnpm)

```
project-root/
├── apps/
│   ├── react/           # Vite SPA (React + TanStack Router)
│   ├── api/             # FastAPI backend (Poetry)
│   └── mkdocs/          # Developer documentation
├── packages/
│   ├── ui/              # shadcn/ui shared component library
│   ├── api-client/      # Orval-generated TypeScript API client
│   ├── analytics/       # PostHog wrapper
│   └── sentry/          # Shared Sentry config
├── tooling/
│   ├── typescript-config/
│   ├── eslint-config/
│   └── prettier-config/
├── pnpm-workspace.yaml
├── turbo.json
├── package.json
├── docker-compose.local.yml
└── docker-compose.prod.yml
```

---

## 2. pnpm Workspace Config

```yaml
# pnpm-workspace.yaml
packages:
  - "apps/*"
  - "packages/*"
  - "tooling/*"

catalogs:
  default:
    typescript: ^5.8.3
    eslint: ^9.0.0
    prettier: ^3.5.3
    react: ^19.1.0
    react-dom: ^19.1.0
    tailwindcss: ^4.1.4

  # Dependency catalogs for version pinning across packages
  react-v19:
    react: ^19.1.0
    react-dom: ^19.1.0
    "@types/react": ^19.0.0
    "@types/react-dom": ^19.0.0
```

---

## 3. Turborepo Config

```jsonc
// turbo.json
{
  "$schema": "https://turbo.build/schema.json",
  "ui": "tui",
  "globalEnv": [
    "DATABASE_URL",
    "API_*",
    "PUBLIC_*"
  ],
  "tasks": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": ["dist/**", ".next/**"]
    },
    "dev": {
      "dependsOn": ["dev:types"],
      "persistent": true,
      "cache": false
    },
    "dev:types": {
      "persistent": true,
      "cache": false
    },
    "test": {
      "dependsOn": ["^build"],
      "cache": false
    },
    "lint": {
      "dependsOn": ["^build"]
    },
    "format": {
      "cache": false
    }
  }
}
```

---

## 4. Root Package.json

```jsonc
{
  "name": "project",
  "private": true,
  "packageManager": "pnpm@10.11.0",
  "engines": { "node": ">=20.0.0" },
  "scripts": {
    "dev": "turbo dev",
    "build": "turbo build",
    "lint": "turbo lint",
    "test": "turbo test",
    "format": "turbo format",
    "format:check": "turbo format:check",
    "db:migrate": "turbo db:migrate --filter=api",
    "generate-api": "turbo generate-api --filter=api-client"
  },
  "devDependencies": {
    "turbo": "^2.5.4",
    "typescript": "catalog:",
    "prettier": "catalog:",
    "husky": "^9.2.0",
    "@semantic-release/changelog": "^6.0.3",
    "@semantic-release/git": "^10.0.1",
    "semantic-release": "^24.2.5"
  }
}
```

---

## 5. Docker — Local Development

```yaml
# docker-compose.local.yml
services:
  # Reverse proxy — routes traffic to host-running apps
  traefik:
    image: traefik:3.6
    command:
      - --api.insecure=true
      - --providers.file.filename=/etc/traefik/dynamic.yml
      - --entrypoints.web.address=:80
    ports:
      - "80:80"
      - "8090:8080"    # Traefik dashboard
    volumes:
      - ./traefik/local-dynamic.yml:/etc/traefik/dynamic.yml:ro
    extra_hosts:
      - "host.docker.internal:host-gateway"

  # Database
  postgres:
    image: postgres:15
    environment:
      POSTGRES_DB: api
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  # Message broker / cache
  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data

  # Celery monitoring
  flower:
    image: mher/flower:2.0
    command: celery --broker=redis://redis:6379/0 flower --port=5555
    ports:
      - "5555:5555"
    depends_on:
      - redis

  # Dev email catcher
  mailcatcher:
    image: schickling/mailcatcher
    ports:
      - "1025:1025"    # SMTP
      - "1080:1080"    # Web UI

volumes:
  postgres_data:
  redis_data:
```

---

## 6. Docker — Production

```yaml
# docker-compose.prod.yml

# Reusable env block via YAML anchor
x-api-env: &api-env
  API_ENVIRONMENT: ${API_ENVIRONMENT:-production}
  API_SECRET_KEY: ${API_SECRET_KEY}
  API_SERVER_HOST: "0.0.0.0"
  API_SERVER_PORT: "8000"
  API_SWAGGER_HIDE: ${API_SWAGGER_HIDE:-true}
  API_DATABASE_URL: ${API_DATABASE_URL}
  API_CELERY_BROKER_URL: ${API_CELERY_BROKER_URL}
  API_CELERY_RESULT_BACKEND: ${API_CELERY_RESULT_BACKEND}
  API_SENTRY_DSN: ${API_SENTRY_DSN:-}

services:
  # Reverse proxy with Let's Encrypt SSL
  traefik:
    image: traefik:3.6
    command:
      - --providers.docker=true
      - --providers.docker.exposedbydefault=false
      - --entrypoints.web.address=:80
      - --entrypoints.web.http.redirections.entryPoint.to=websecure
      - --entrypoints.websecure.address=:443
      - --certificatesresolvers.letsencrypt.acme.tlschallenge=true
      - --certificatesresolvers.letsencrypt.acme.email=${ACME_EMAIL}
      - --certificatesresolvers.letsencrypt.acme.storage=/letsencrypt/acme.json
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - traefik_letsencrypt:/letsencrypt

  # FastAPI backend
  api:
    build:
      context: ./apps/api
      dockerfile: Dockerfile
    environment:
      <<: *api-env
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.api.rule=Host(`api.${DOMAIN}`)"
      - "traefik.http.routers.api.entrypoints=websecure"
      - "traefik.http.routers.api.tls.certresolver=letsencrypt"
      - "traefik.http.services.api.loadbalancer.server.port=8000"
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s

  # Celery worker (same image, different entrypoint)
  celery-worker:
    build:
      context: ./apps/api
      dockerfile: Dockerfile
    environment:
      <<: *api-env
    command: ["celery-worker"]

  # React frontend (nginx serving static build)
  app:
    build:
      context: .
      dockerfile: apps/react/Dockerfile
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.app.rule=Host(`${DOMAIN}`)"
      - "traefik.http.routers.app.entrypoints=websecure"
      - "traefik.http.routers.app.tls.certresolver=letsencrypt"
      - "traefik.http.services.app.loadbalancer.server.port=80"

volumes:
  traefik_letsencrypt:
```

**Key patterns:**
- YAML anchors (`&api-env` / `<<: *api-env`) for DRY env config
- Traefik labels for automatic HTTPS routing
- Same Docker image for API + Celery worker (different `command`)
- Health checks on API service

---

## 7. CI/CD — GitHub Actions

```yaml
# .github/workflows/ci.yml
name: CI

on:
  pull_request:
    branches: [main, dev]

jobs:
  gitleaks:
    uses: ./.github/workflows/gitleaks.yml

  backend-tests:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:15
        env:
          POSTGRES_DB: api_test
          POSTGRES_USER: postgres
          POSTGRES_PASSWORD: postgres
        ports:
          - 5432:5432
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5

    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: "3.12"
      - name: Install Poetry
        run: pip install poetry==2.2.1
      - name: Install deps
        working-directory: apps/api
        run: poetry install
      - name: Run tests
        working-directory: apps/api
        env:
          API_DATABASE_URL: postgresql+asyncpg://postgres:postgres@localhost:5432/api_test
        run: poetry run pytest --cov --cov-report=xml
      - uses: codecov/codecov-action@v4

  frontend-lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 22
      - uses: pnpm/action-setup@v4
        with:
          version: 10.11.0
      - run: pnpm install --frozen-lockfile
      - run: pnpm lint
      - run: pnpm build
```

### Deployment Pipelines

```yaml
# .github/workflows/pipe-dev.yml — deploy to staging on push to dev
name: Deploy Dev
on:
  push:
    branches: [dev]
jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: staging
    steps:
      - uses: actions/checkout@v4
      - name: Create Sentry Release
        if: env.SENTRY_ORG != ''
        uses: getsentry/action-release@v3
        env:
          SENTRY_ORG: ${{ secrets.SENTRY_ORG }}
          SENTRY_PROJECT: ${{ secrets.SENTRY_PROJECT }}
          SENTRY_AUTH_TOKEN: ${{ secrets.SENTRY_AUTH_TOKEN }}
        with:
          environment: staging
```

```yaml
# .github/workflows/pipe-prod.yml — deploy on version tags
name: Deploy Production
on:
  push:
    tags: ["v*"]
jobs:
  ci:
    uses: ./.github/workflows/ci.yml
  deploy:
    needs: ci
    runs-on: ubuntu-latest
    environment: production
    steps:
      - uses: actions/checkout@v4
      # Deploy steps...
```

---

## 8. Python Project Config (pyproject.toml)

```toml
[tool.poetry]
name = "api"
version = "0.1.0"
packages = [{include = "api"}]

[tool.poetry.scripts]
start = "api.main:main"
celery-worker = "api.deps.celery:main"
dev = "api.main:main"

[tool.poetry.dependencies]
python = ">=3.11,<3.13"
fastapi = "^0.135.0"
uvicorn = {extras = ["standard"], version = "^0.34.3"}
sqlalchemy = {extras = ["asyncio"], version = "^2.0.43"}
asyncpg = "^0.31.0"
pydantic = "^2.11.9"
pydantic-settings = "^2.9.1"
alembic = "^1.16.5"
celery = {extras = ["redis"], version = "^5.4.0"}
redis = "^5.2.1"
boto3 = "^1.38.16"
asgiref = "^3.8.1"
sentry-sdk = {extras = ["fastapi"], version = "^2.27.0"}

[tool.pytest.ini_options]
testpaths = ["__tests__"]
asyncio_mode = "auto"
addopts = "-v --tb=short -m 'not eval and not benchmark'"

[tool.ruff]
target-version = "py311"
line-length = 88

[tool.ruff.lint]
select = ["E", "W", "F", "I", "B", "C4", "UP", "ARG", "T", "SIM", "RET", "PIE", "A", "COM", "DTZ", "Q", "RUF"]
ignore = ["E501", "B008", "B904", "COM812", "RUF001"]

[tool.ruff.lint.isort]
known-first-party = ["api", "__tests__"]

[tool.mypy]
python_version = "3.11"
strict = true
plugins = ["pydantic.mypy"]
```

---

## 9. Alembic Migration Config

```ini
# alembic.ini
[alembic]
script_location = migrations
prepend_sys_path = .
version_path_separator = os
```

```python
# migrations/env.py — key pattern
from api.core.models import BaseModel
from api.settings import settings

target_metadata = BaseModel.metadata

def run_migrations_online():
    connectable = create_async_engine(str(settings.DATABASE_URL))
    # ... standard async alembic setup
```

**Commands:**
```bash
# Generate from model changes (NEVER hand-write)
alembic revision --autogenerate -m "add column"

# Apply
alembic upgrade head

# Rollback one
alembic downgrade -1
```

---

## 10. Environment Variables Pattern

```bash
# .env.example — API_ prefix for all backend vars

# ─── Database ──────────────────────────────────────────────────────
API_DATABASE_URL=postgresql+asyncpg://postgres:postgres@localhost:5432/api

# ─── Application ───────────────────────────────────────────────────
API_PROJECT_NAME="My API"
API_ENVIRONMENT=local          # local | staging | production
API_SECRET_KEY=change-me
API_APP_PASSWORD=change-me

# ─── Server ────────────────────────────────────────────────────────
API_SERVER_HOST=0.0.0.0
API_SERVER_PORT=8000
API_SERVER_LOG_LEVEL=info
API_SWAGGER_HIDE=false         # true in production

# ─── CORS ──────────────────────────────────────────────────────────
API_CORS_ORIGINS=["http://localhost:5173"]

# ─── Object Storage (S3-compatible, e.g. Cloudflare R2) ───────────
API_S3_ENDPOINT=https://xxx.r2.cloudflarestorage.com
API_S3_ACCESS_KEY_ID=
API_S3_SECRET_ACCESS_KEY=
API_S3_BUCKET_NAME=my-bucket

# ─── Celery ────────────────────────────────────────────────────────
API_CELERY_BROKER_URL=redis://localhost:6379/0
API_CELERY_RESULT_BACKEND=redis://localhost:6379/0

# ─── External APIs ────────────────────────────────────────────────
API_ELEVENLABS_API_KEY=
API_ANTHROPIC_API_KEY=
API_GEMINI_API_KEY=

# ─── Observability (optional) ─────────────────────────────────────
API_SENTRY_DSN=
API_SENTRY_TRACES_SAMPLE_RATE=0.1
```

**Rules:**
- `API_` prefix on all backend vars — prevents Docker env collision
- Sensitive values never in `.env.example` — only placeholder text
- Production values in CI secrets / Docker secrets, never committed

---

## 11. Git Workflow

```
main          ← production releases (tagged)
  └── dev     ← integration branch
       └── hyp-123-short-description  ← feature branches
```

**Branch naming:** `hyp-{linear-issue}-{short-description}`

**Commit style:** Conventional Commits

```
feat: add batch download endpoint
fix: handle empty script rows in parser
chore: update dependencies
refactor: extract storage service from route handlers
```

**PR flow:** feature branch → `dev` (review) → `main` (release)

**Semantic release** generates changelogs and version tags automatically from commit messages.
