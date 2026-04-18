# Refactor

Audit and refactor code in the Lead Alliances Video Pipeline, using systematic code smell detection and proven refactoring techniques.

## Variables

target: $ARGUMENTS (file path, module name, or `full audit` for broad analysis, e.g. `apps/api/api/videos/pipeline/tasks.py` or `apps/react/src/features/batches`)

---

## Instructions

**You are REFACTORING, not adding features.** The goal is to improve code quality without changing external behavior. Every refactoring must preserve existing functionality.

---

## Phase 1: Load Context

1. **Read the refactoring and design SOPs:**
   - `.claude/docs/sops/refactoring-sop.md` — code smells, techniques, decision tree
   - `.claude/docs/sops/design-patterns-sop.md` — pattern selection cheat sheet
2. **Read the relevant architecture doc:**
   - Backend code → `.claude/docs/backend-patterns.md`
   - Frontend code → `.claude/docs/frontend-patterns.md`
   - Pipeline code → `.claude/docs/pipeline-architecture.md`
3. **Read the target code** completely
4. **Read existing tests** for the target — these are your safety net

---

## Phase 2: Audit

Systematically scan for code smells in these categories:

### Bloaters
- [ ] Long methods (>30 lines)
- [ ] Large classes (>200 lines or >5 responsibilities)
- [ ] Long parameter lists (>3 params)
- [ ] Primitive obsession (raw strings/ints instead of domain types)
- [ ] Data clumps (same group of fields repeated)

### Object-Orientation Abusers
- [ ] Switch/if-else chains on type fields
- [ ] Parallel inheritance hierarchies
- [ ] Refused bequest (subclass ignoring parent methods)

### Change Preventers
- [ ] Divergent change (one class changed for multiple reasons)
- [ ] Shotgun surgery (one change requires edits in many places)
- [ ] Copy-paste code (duplicated logic)

### Dispensables
- [ ] Dead code (unreachable or unused)
- [ ] Speculative generality (abstractions with one implementation)
- [ ] Unnecessary comments (comments explaining obvious code)
- [ ] Redundant variables or intermediate assignments

### Coupling Issues
- [ ] Feature envy (method uses another object's data more than its own)
- [ ] Inappropriate intimacy (classes knowing too much about each other)
- [ ] Missing abstraction layer

### Project-Specific
- [ ] `Any` type annotations (use Protocols or proper types)
- [ ] Hardcoded URLs or API paths (use Orval-generated client)
- [ ] Custom SVGs (use lucide-react)
- [ ] Sync operations in async context (check backend-patterns.md)
- [ ] Missing error handling

---

## Phase 3: Categorize and Prioritize

For each smell found, assign a severity:

| Severity | Criteria | Action |
|----------|----------|--------|
| **Critical** | Causes bugs, data loss, or security issues | Fix immediately |
| **High** | Blocks maintainability, makes changes risky | Fix in this session |
| **Medium** | Reduces readability, slows development | Fix if time allows |
| **Low** | Style or preference issues | Note for later |

Present the audit results to the user. If `target` is `full audit`, stop here and present findings. Otherwise, proceed to Phase 4.

---

## Phase 4: Refactor

Apply refactoring techniques from the refactoring SOP. For each change:

1. **Verify tests exist** — if not, write them first
2. **Apply one refactoring at a time** — keep changes atomic
3. **Run tests after each refactoring** — ensure nothing broke
4. **Common techniques:**
   - Extract Method/Function — break long methods into named steps
   - Extract Class/Module — split large files by responsibility
   - Replace Conditional with Polymorphism — for type-switching code
   - Introduce Parameter Object — for long parameter lists
   - Replace Magic Values with Constants — for hardcoded strings/numbers
   - Move Method — relocate to the class that owns the data
   - Inline Unnecessary Abstraction — remove wrappers that add no value

### Backend-Specific Refactoring
- Extract service layer from route handlers
- Replace raw SQL with SQLAlchemy query builders
- Move business logic out of Celery tasks into service functions
- Use Pydantic validators instead of manual validation

### Frontend-Specific Refactoring
- Extract custom hooks from components
- Split large components into composition (container + presentational)
- Replace prop drilling with context or composition
- Consolidate duplicate API call patterns into shared hooks
- Move route-specific components to `_components/`

---

## Phase 5: Verify

1. **Run all tests:**
   - Backend: `cd apps/api && poetry run pytest -v`
   - Frontend: `cd apps/react && pnpm test --run`
   - E2E: `cd apps/react && npx playwright test` (if UI was touched)
2. **Run linting:** `pnpm lint`
3. **Confirm no behavior changes** — the refactored code should do exactly what it did before
4. **Check for regressions** in related modules

---

## Phase 6: Report

```
## Refactoring Complete

### Target
- `path/to/refactored/code`

### Smells Found
| Smell | Severity | Status |
|-------|----------|--------|
| [Description] | Critical/High/Medium/Low | Fixed / Deferred |

### Changes Made
1. [Refactoring technique applied] — [what changed and why]
2. [Refactoring technique applied] — [what changed and why]

### Files Modified
- `path/to/file.ts` — [what changed]

### Tests
- All [N] tests passing
- [New tests added, if any]

### Deferred Items
- [Smells found but not fixed, with reasoning]

### Before/After Metrics
- Lines of code: [before] → [after]
- Functions/methods: [before] → [after]
- Max function length: [before] → [after]
```
