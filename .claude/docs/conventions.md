# Conventions

## Naming

- **Components:** PascalCase (`SignalCard`, `DashboardNav`)
- **Hook files:** kebab-case (`use-signals.ts`, `use-auth.ts`)
- **Hook exports:** camelCase (`useSignals`, `useAuth`)
- **API routes:** kebab-case paths (`/api/signals`)
- **Constants:** UPPER_CASE (`SIGNAL_TYPES`)
- **Types:** PascalCase (`Signal`, `BetResult`, `OddsSnapshot`)

## File Organization

- Feature-based directories (`signals/`, `scanner/`, `dashboard/`)
- Shared utilities in `src/lib/utils/`
- Constants in `src/lib/constants/`

## Folder Roles: lib vs utils vs services

### `lib/` — Reusable Building Blocks
Holds well-structured, reusable code. Auth, integrations, SDK clients.

### `utils/` — Small, Generic Helpers
Stateless functions: formatting, date helpers, parsing. If it's simple and generic, it goes here.

### `services/` — Business Logic & External Integrations
Anything that interacts with APIs, databases, or manages complex business rules. One folder per domain.

| Question | Folder |
|----------|--------|
| Is this a mini-package? | `lib/` |
| Is this a generic helper? | `utils/` |
| Is this handling business logic or integrations? | `services/` |

## Error Handling

- try/catch in API routes → `NextResponse.json({ error }, { status })`
- FastAPI routes raise `HTTPException` with proper status codes
- **Sentry** captures unhandled exceptions automatically
- Error boundaries: `error.tsx` (nested routes), `global-error.tsx` (root)

## Environment Variables

- **Always use `.env`** — never `.env.local`
- Validated at build time via `@t3-oss/env-nextjs` in `src/env.ts`
- FastAPI validated via `pydantic-settings` in `api/settings.py`
- Add new vars to the respective env config file

## Async Side-effects

- Background tasks go through Celery, not inline in request handlers
- Don't block HTTP response for side-effects
- Cron jobs / workers continue on individual errors (no full failure)

## Commands

```bash
pnpm dev              # Start all apps (from root)
pnpm build            # Production build
pnpm lint             # Lint all packages
poetry run start      # FastAPI only
poetry run pytest     # Backend tests only
poetry run celery-worker  # Celery worker
```
