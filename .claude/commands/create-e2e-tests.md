# Create E2E Tests

Create Playwright end-to-end tests for features or pages in the Lead Alliances Video Pipeline.

## Variables

target: $ARGUMENTS (feature name or page path to test, e.g. `batches list page` or `video pipeline status`)

---

## Instructions

**You are creating E2E TESTS, not application code.** Identify user flows, set up mock data, write spec files, and verify they pass.

---

## Phase 1: Load Context

1. **Read the E2E testing SOP:** `.claude/docs/sops/testing-e2e-sop.md`
2. **Read existing E2E infrastructure:**
   - `apps/react/e2e/fixtures.ts` — shared fixtures and page objects
   - `apps/react/e2e/mock-data.ts` — mock data factories (if exists)
   - `apps/react/playwright.config.ts` — configuration and base URL
3. **Read existing E2E tests** in `apps/react/e2e/` for pattern reference
4. **Read the target page/feature source code:**
   - Route definition in `apps/react/src/routes/`
   - Components rendered on the page
   - API calls made by the page (Orval-generated hooks)
5. **Read the backend routes** that the page calls to understand response shapes

---

## Phase 2: Identify User Flows

1. **List all user-visible flows** for the target feature:
   - Page load and initial data display
   - User interactions (clicks, form fills, navigation)
   - Success states (data created, updated, deleted)
   - Error states (API failures, validation errors, empty states)
   - Loading states and transitions
2. **Prioritize flows** by user impact — test the critical path first
3. **Identify API endpoints** that need mocking with `route.fulfill()`

---

## Phase 3: Create/Update Mock Data

1. **Check `apps/react/e2e/mock-data.ts`** for existing factories
2. **Add new factories** if the feature uses data shapes not yet covered
3. **Mock data rules:**
   - Use realistic but deterministic values
   - Include edge cases (empty lists, long strings, special characters)
   - Match the exact schema from backend response types
   - Each test should have isolated data — no shared mutable state

---

## Phase 4: Write Spec File

- **File location:** `apps/react/e2e/{feature-name}.spec.ts`
- **Use fixtures** from `apps/react/e2e/fixtures.ts` for common setup
- **Mock all API calls** with `page.route()` and `route.fulfill()` — never hit real backend
- **Selector rules (accessibility-first):**
   - Prefer `getByRole()`, `getByLabel()`, `getByText()`
   - Use `getByTestId()` only as last resort
   - Never select by CSS class or element tag alone
- **Test structure:**
   - `test.describe` block per feature area
   - `test.beforeEach` for common setup (navigation, API mocking)
   - One assertion focus per test
   - Clear test names: `should display batch list when data loads`
- **Assertions:**
   - Use `expect(locator).toBeVisible()` over `toHaveCount(1)`
   - Check text content for user-facing strings
   - Verify navigation with `expect(page).toHaveURL()`
   - Use `toHaveScreenshot()` sparingly — only for visual regression tests
- **Data isolation:**
   - Each test sets up its own mock data
   - No dependency between tests
   - Tests can run in any order

---

## Phase 5: Run and Verify

1. **Run the tests:**
   ```bash
   cd apps/react && npx playwright test e2e/{feature-name}.spec.ts
   ```
2. **Run in headed mode** if debugging:
   ```bash
   cd apps/react && npx playwright test e2e/{feature-name}.spec.ts --headed
   ```
3. **Fix any failures** — adjust selectors, mock data, or timing
4. **Verify no flaky tests** — run three times to check for timing issues
5. **Check that tests are independent** — run a single test in isolation

---

## Phase 6: Report

```
## E2E Tests Created

### Target Feature
- [Feature/page description]

### Spec File
- `apps/react/e2e/{feature-name}.spec.ts`

### User Flows Covered
- [x] [Flow 1 description]
- [x] [Flow 2 description]
- [ ] [Flow not covered — reason]

### Mock Data
- [New factories added or existing ones reused]

### Results
- All [N] tests passing
- Run time: ~[X]s
- [Any notes about timing sensitivity or known limitations]
```
