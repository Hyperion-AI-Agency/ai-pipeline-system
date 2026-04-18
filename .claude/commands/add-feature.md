# Add Feature

Add a new domain or feature end-to-end to the Lead Alliances Video Pipeline, following the full stack sequence from model to UI.

## Variables

feature: $ARGUMENTS (feature description or Linear task identifier, e.g. `add voice provider selection to pipeline` or `HYP-123`)

---

## Instructions

**You are building a COMPLETE FEATURE across the full stack.** Follow the exact sequence: model, schema, CRUD, route, migration, API client, frontend page, tests.

---

## Phase 1: Load Context

1. **Read the mandatory SOPs:**
   - `.claude/docs/sops/claude-agent-sop.md` — workflow and checklists
   - `.claude/docs/sops/backend-sop.md` — API layer patterns
   - `.claude/docs/sops/frontend-sop.md` — UI layer patterns
2. **Read architecture docs:**
   - `.claude/docs/backend-patterns.md` — async/sync rules, DB engines, module structure
   - `.claude/docs/frontend-patterns.md` — file org, API calls, styling
   - `.claude/docs/pipeline-architecture.md` — if the feature touches the pipeline
3. **If the input is a Linear task:** fetch the task details using Linear MCP to get requirements, acceptance criteria, and context
4. **Scan the codebase** for the closest existing feature to use as a pattern reference:
   - Find a similar domain in `apps/api/api/` (e.g., `batches/`, `videos/`, `templates/`)
   - Note its model, schema, CRUD, route, and corresponding frontend page

---

## Phase 2: Plan the Feature

Before writing any code, outline:

1. **Database model** — table name, columns, relationships, constraints
2. **Pydantic schemas** — Create, Update, Read, List response
3. **CRUD operations** — which operations are needed (create, read, update, delete, list)
4. **API routes** — endpoints, HTTP methods, request/response types
5. **Frontend pages** — which pages/dialogs/components are needed
6. **Tests** — what needs unit tests, what needs E2E tests

Present this outline to the user for approval before proceeding.

---

## Phase 3: Backend Implementation

Follow this exact order (from claude-agent-sop.md section 3):

### Step 1: Model
- Create `apps/api/api/{feature}/models.py`
- Define SQLAlchemy model with proper types, no `Any`
- Add relationships and back_populates
- Use UUIDs for primary keys (project convention)

### Step 2: Schemas
- Create `apps/api/api/{feature}/schemas.py`
- Define Pydantic v2 schemas: `{Feature}Create`, `{Feature}Update`, `{Feature}Read`
- Use `model_config = ConfigDict(from_attributes=True)`

### Step 3: CRUD
- Create `apps/api/api/{feature}/crud.py`
- Implement async CRUD functions using SQLAlchemy async session
- Follow patterns from existing CRUD modules

### Step 4: Routes
- Create `apps/api/api/{feature}/routes.py`
- Define FastAPI router with proper tags and prefix
- Use dependency injection for DB sessions and auth
- Register router in `apps/api/api/main.py`

### Step 5: Migration
- Generate: `cd apps/api && poetry run alembic revision --autogenerate -m "add {feature} table"`
- Review the generated migration file
- Apply: `cd apps/api && poetry run alembic upgrade head`

### Step 6: Regenerate API Client
- Run: `pnpm run generate-api`
- Verify the generated types in `packages/api-client/`

---

## Phase 4: Frontend Implementation

### Step 7: Route and Page
- Add route in `apps/react/src/routes/`
- Create page component following TanStack Router conventions
- Add to navigation if needed

### Step 8: Components
- Create route-specific components in `_components/` next to the route
- Use shadcn/ui components, never custom SVGs
- Follow the project's color scheme (dark sage sidebar, warm cream content)

### Step 9: API Integration
- Use Orval-generated hooks from `packages/api-client/`
- No hardcoded URLs, no custom axios instances
- Handle loading, error, and empty states

---

## Phase 5: Testing

### Step 10: Unit Tests
- Backend: `apps/api/__tests__/test_{feature}.py`
- Use pytest parametrize for CRUD operations
- Test validation, edge cases, and error handling

### Step 11: E2E Tests (if UI was added)
- Frontend: `apps/react/e2e/{feature}.spec.ts`
- Test the critical user flow end-to-end
- Mock API responses with route.fulfill()

---

## Phase 6: Verify and Report

1. **Run linting:** `pnpm lint`
2. **Run backend tests:** `cd apps/api && poetry run pytest`
3. **Run frontend tests:** `cd apps/react && pnpm test --run`
4. **Run E2E tests:** `cd apps/react && npx playwright test e2e/{feature}.spec.ts`
5. **Manual verification:** list all files created/modified

```
## Feature Added

### Summary
- [What was built and why]

### Files Created
**Backend:**
- `apps/api/api/{feature}/models.py`
- `apps/api/api/{feature}/schemas.py`
- `apps/api/api/{feature}/crud.py`
- `apps/api/api/{feature}/routes.py`
- `apps/api/alembic/versions/{migration}.py`

**Frontend:**
- `apps/react/src/routes/{feature}/...`

**Tests:**
- `apps/api/__tests__/test_{feature}.py`
- `apps/react/e2e/{feature}.spec.ts`

### API Client
- Regenerated with new endpoints

### Validation
- [x] All tests passing
- [x] Linting clean
- [x] Migration applied
- [x] API client regenerated
- [ ] [Any remaining items]

### Deviations
- [None, or list what changed from the plan and why]
```
