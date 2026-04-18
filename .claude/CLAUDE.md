# CLAUDE.md — Next.js + FastAPI Template

This file is automatically loaded at the start of every Claude Code session.

---

## What This Is



## Mandatory Workflow

**Claude must NEVER jump straight to writing code for new tasks or features.** The workflow is always:

1. **`/prime`** → 2. **`/plan`** → 3. **Review** → 4. **`/implement`**

---

## Live Surgery Principle

**Every implementation is live surgery on a running system.** Treat the codebase as a patient — do the minimum necessary, verify before and after, and never cut more than required.

### Before writing ANY code, Claude MUST ask:

1. **WHY** — What problem does this solve? What breaks without it? Is this actually needed?
2. **WHAT** — What is the exact scope? What should change vs. what must NOT change?
3. **HOW** — What is the least invasive approach? Can this be done with fewer file changes?
4. **WHERE** — Which files are affected? What existing code can be reused?

### Implementation rules:

- **Minimal diff** — the best implementation touches the fewest files. If you can solve it by modifying 2 lines instead of creating a new file, modify 2 lines.
- **No collateral changes** — don't refactor, rename, reformat, or "improve" code you weren't asked to change.
- **No speculative code** — don't add features, abstractions, or utilities "for later."
- **Verify the blast radius** — before implementing, list every file that will change and why. If the list is longer than expected, stop and reconsider.

---

## Test-Driven Development (TDD)

**Tests must be written BEFORE implementation code. This is non-negotiable.**

### TDD Cycle

1. **RED** — Write a failing test that defines the expected behavior
2. **GREEN** — Write the minimum code to make the test pass
3. **REFACTOR** — Clean up while keeping tests green

### Test locations

- Backend: `apps/api/__tests__/` (pytest)
- Frontend: `apps/nextjs/src/**/__tests__/*.test.ts` (vitest)
- E2E: `apps/nextjs/e2e/` (Playwright)

### Rules

- No implementation PR without tests
- Test the behavior, not the implementation
- One test file per module/feature
- Run tests before committing: `poetry run pytest` / `pnpm test`

---

## Quick Reference

| What | Where |
|------|-------|
| Frontend app | `apps/nextjs/` (Next.js 15) |
| Backend API | `apps/api/` (FastAPI) |
| API modules | `apps/api/api/` (routes, models, schemas, crud) |
| Celery worker | `apps/api/api/deps/celery.py` |
| Celery tasks | `apps/api/api/deps/tasks.py` |
| UI components | `packages/ui/` (shadcn/ui) |
| Analytics | `packages/analytics/` (PostHog) |
| API client | `packages/api-client/` (Orval-generated) |
| Sentry | `packages/sentry/` |
| Env config (Next.js) | `apps/nextjs/src/env.ts` (t3-env) — uses `.env` |
| Env config (FastAPI) | `apps/api/api/settings.py` (Pydantic) — uses `.env` |
| Backend tests | `apps/api/__tests__/` (pytest) |
| E2E tests | `apps/nextjs/e2e/` (Playwright) |
| Tooling | `tooling/` (typescript-config, prettier-config, eslint-config) |


## Deployment

- **Pipeline**: Push to `main` → CI → Semantic Release → Build Docker → rsync to server → `docker compose up`
- **Server**: Remote VM via SSH (Docker + compose)
- **Secrets**: Injected as env vars at deploy time from GitHub secrets
- **Environment variables**: Always `.env` — never `.env.local`

## Git Workflow

- **Commit messages follow Conventional Commits** for semantic-release
- **`[skip ci]`** is added to release commits automatically
- PR flow: feature branch → `main`

## Key Commands

```bash
pnpm dev                    # Start all apps
pnpm build                  # Build everything
pnpm test                   # Run all tests
pnpm lint                   # Lint all packages
poetry run pytest           # Backend tests only
poetry run start            # Start FastAPI only
poetry run celery-worker    # Start Celery worker
pnpm run generate-api       # Regenerate FastAPI client
```

## Reference Documentation

Read the relevant doc before working on any area:

### Quick References

| Doc | What It Covers |
|-----|---------------|
| **[Next.js Patterns](.claude/docs/code-patterns/nextjs.md)** | App Router structure, routing, data fetching, server/client components, Suspense, server actions |
| **[FastAPI Patterns](.claude/docs/code-patterns/fastapi.md)** | APIRouter, dependencies, Pydantic schemas, Celery tasks, module structure, testing |
| **[TypeScript Patterns](.claude/docs/code-patterns/typescript.md)** | Strictness rules, naming, design patterns (refactoring.guru), refactoring techniques, TDD |
| **[Python Patterns](.claude/docs/code-patterns/python.md)** | Type annotations, service/CRUD pattern, testing, error handling, design patterns |
| **[Conventions](.claude/docs/conventions.md)** | Naming, file org, folder roles (lib/utils/services), error handling, env vars, async patterns |
| **[Backend Patterns](.claude/docs/backend-patterns.md)** | FastAPI module structure, service pattern, settings, error handling |
| **[Frontend Patterns](.claude/docs/frontend-patterns.md)** | Next.js file organization, API calls, code splitting, styling |

### SOPs (Comprehensive Guides)

| SOP | What It Covers |
|-----|---------------|
| `backend-sop.md` | FastAPI + SQLAlchemy + Celery: settings, app factory, models, schemas, CRUD, auth, Redis, Celery tasks |
| `frontend-sop.md` | Next.js: routing, data fetching, forms, SSE, styling, type safety |
| `infrastructure-sop.md` | Monorepo structure, Docker, CI/CD, Turborepo, pnpm workspaces, GitHub Actions |
| `claude-agent-sop.md` | Mandatory workflow, project init checklist, adding features step-by-step |
| `design-patterns-sop.md` | When and how to use common design patterns |
| `refactoring-sop.md` | Code smell detection and refactoring techniques |

### External References

When making architectural decisions or refactoring, consult these resources:

| Resource | When to Use |
|----------|-------------|
| [Refactoring Catalog](https://refactoring.guru/refactoring/catalog) | Before any refactoring — find the right technique for the code smell |
| [Design Patterns](https://refactoring.guru/design-patterns) | When adding new abstractions — pick the right pattern, don't invent one |
| [Code Smells](https://refactoring.guru/refactoring/smells) | To identify what's wrong before deciding how to fix it |
| [SOLID Principles](https://refactoring.guru/design-patterns/solid) | When designing new modules or splitting responsibilities |

**Rules:**
- Before implementing a new feature, read `code-patterns.md` and follow the checklist
- Before refactoring, identify the code smell at refactoring.guru/refactoring/smells, then apply the matching technique from refactoring.guru/refactoring/catalog
- Before adding an abstraction, verify the pattern exists at refactoring.guru/design-patterns — if it doesn't have a name, you probably don't need it
