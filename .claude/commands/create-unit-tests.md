# Create Unit Tests

Create unit tests for backend (pytest) or frontend (Vitest) code in the Lead Alliances Video Pipeline.

## Variables

target: $ARGUMENTS (file path or module name to test, e.g. `apps/api/api/videos/crud.py` or `apps/react/src/features/batches/hooks`)

---

## Instructions

**You are creating TESTS, not application code.** Read the source, identify testable behaviors, write thorough tests, and verify they pass.

---

## Phase 1: Load Context

1. **Read the testing SOP:** `.claude/docs/sops/testing-unit-sop.md`
2. **Determine the layer:**
   - Python file in `apps/api/` → backend (pytest)
   - TypeScript/React file in `apps/react/` → frontend (Vitest + React Testing Library)
3. **Read the source file(s)** specified in `target` completely
4. **Read existing test helpers:**
   - Backend: `apps/api/__tests__/helpers.py` and any `conftest.py` files
   - Frontend: `apps/react/src/test/` setup files and any shared test utilities
5. **Read existing tests** in the same domain for pattern reference:
   - Backend: scan `apps/api/__tests__/` for related test files
   - Frontend: scan for `*.test.ts` or `*.test.tsx` files near the target

---

## Phase 2: Identify Testable Behaviors

1. **List all public functions/methods/components** in the target
2. **For each, identify:**
   - Happy path scenarios
   - Edge cases (empty input, None/undefined, boundary values)
   - Error cases (invalid input, missing data, exceptions)
   - Side effects (database writes, API calls, state changes)
3. **Group related behaviors** into logical test classes or describe blocks
4. **Identify dependencies** that need mocking (DB sessions, external APIs, Celery tasks)

---

## Phase 3: Write Tests

### Backend (pytest)

- **File location:** `apps/api/__tests__/test_{module_name}.py`
- **Use `@pytest.mark.parametrize`** for repetitive cases with varying inputs
- **Use shared helpers** from `apps/api/__tests__/helpers.py` (factory functions, fixtures)
- **Use `conftest.py` fixtures** for DB sessions, test clients, auth
- **Mock external services** with `unittest.mock.patch` or `pytest-mock`
- **Assert specific values**, not just truthiness
- **Test structure:** Arrange → Act → Assert, one assertion concept per test

### Frontend (Vitest + React Testing Library)

- **File location:** colocated `*.test.ts` or `*.test.tsx` next to the source file
- **Use `describe`/`it` blocks** with clear behavior descriptions
- **Use `renderWithProviders`** or equivalent wrapper for components needing context
- **Mock API calls** with MSW or vi.mock for Orval-generated hooks
- **Query by role/label** (accessibility-first), avoid test IDs unless necessary
- **Test user interactions** with `userEvent`, not `fireEvent`

### Rules for Both

- No `Any` types — use proper type annotations
- No hardcoded magic values — use constants or factory functions
- Each test should be independent and idempotent
- Test names should describe the behavior, not the implementation

---

## Phase 4: Run and Verify

1. **Run the tests:**
   - Backend: `cd apps/api && poetry run pytest __tests__/test_{module_name}.py -v`
   - Frontend: `cd apps/react && pnpm test {test_file} --run`
2. **Fix any failures** — adjust tests or report source code bugs
3. **Check coverage** of the target file — ensure all identified behaviors are covered
4. **Verify no flaky tests** — run twice if uncertain

---

## Phase 5: Report

```
## Tests Created

### Target
- `path/to/source/file`

### Test File
- `path/to/test/file`

### Coverage
- [X] functions/methods tested out of [Y] total
- Key behaviors covered: [list]
- Known gaps: [any intentionally skipped areas and why]

### Results
- All [N] tests passing
- [Any warnings or notes]
```
