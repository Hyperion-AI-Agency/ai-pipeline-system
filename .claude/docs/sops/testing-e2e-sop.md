# SOP: Playwright E2E Testing

Standard operating procedure for writing Playwright end-to-end tests in the Lead Alliances Video Pipeline.

**Tech stack:** React + Vite + TanStack Router + Orval API client + Playwright

**Key files:**
- `apps/react/e2e/fixtures.ts` -- custom fixtures (`authedPage`, `authedPageWithData`, `mocks`)
- `apps/react/e2e/mock-data.ts` -- data factories (`mockFactories`)
- `apps/react/playwright.config.ts` -- Playwright configuration
- `apps/react/e2e/*.spec.ts` -- test specs

---

## 1. Test Pyramid: When to Write E2E Tests

E2E tests are expensive. Use them only when cheaper tests cannot verify the behavior.

| Use E2E for | Use unit/integration instead |
|---|---|
| Full user flows (login, upload batch, navigate) | Pure functions, formatting, validation logic |
| Auth state transitions (login, session expiry, redirect) | Component rendering with static props |
| Multi-page navigation and routing guards | Individual component behavior |
| Form submissions that trigger API calls | Schema validation, enum mapping |
| SSE-driven UI updates (batch progress) | Hook logic in isolation |
| Dialog multi-step workflows | Utility functions |

**Rule of thumb:** If the behavior involves a URL change, an API call, or cross-component coordination, it belongs in E2E. Everything else should be a unit or integration test.

---

## 2. Test Structure

### File Organization

```
apps/react/e2e/
  fixtures.ts          # Custom test fixtures (authedPage, etc.)
  mock-data.ts         # Data factories (mockFactories)
  auth.spec.ts         # Auth flows: login, logout, session expiry
  smoke.spec.ts        # Basic page load checks
  dashboard.spec.ts    # Dashboard-specific tests
  batches.spec.ts      # Batch list, create dialog, delete
  videos.spec.ts       # Video list, detail, retry, export
  settings.spec.ts     # Settings form, save
```

### Spec File Template

```typescript
import { test, expect } from "./fixtures";

test.describe("feature — scenario group", () => {
  test("specific behavior under test", async ({ authedPage: page }) => {
    // Arrange: navigate to the page
    await page.goto("/app/target-page");

    // Act: interact with the UI
    await page.getByRole("button", { name: /action/i }).click();

    // Assert: verify the outcome
    await expect(page.getByText("Expected result")).toBeVisible();
  });
});
```

### Naming Conventions

- **Describe blocks:** `"feature -- scenario group"` (e.g., `"batches -- create dialog"`)
- **Test names:** Describe the specific behavior, not the implementation (e.g., `"shows empty state when no batches exist"`, not `"renders EmptyState component"`)
- **File names:** Match the route/feature they test: `batches.spec.ts`, `auth.spec.ts`

---

## 3. Fixtures

### Available Fixtures

The project defines three custom fixtures in `apps/react/e2e/fixtures.ts`:

| Fixture | Provides | Use when |
|---|---|---|
| `authedPage` | `Page` with auth + empty API mocks | Testing UI with no data (empty states, create flows) |
| `authedPageWithData` | `{ page: Page, data: MockData }` with auth + populated mocks | Testing UI that needs batches, videos, dashboard stats |
| `mocks` | `typeof mockFactories` | Building custom mock data within a test |

### Usage Patterns

**Empty state test:**
```typescript
test("shows empty state", async ({ authedPage: page }) => {
  await page.goto("/app/batches");
  await expect(page.getByText("No batches yet")).toBeVisible();
});
```

**Data-driven test:**
```typescript
test("shows batch names", async ({ authedPageWithData: { page, data } }) => {
  await page.goto("/app/batches");
  for (const batch of data.batches) {
    await expect(page.getByText(batch.name)).toBeVisible();
  }
});
```

**Custom data test (when you need specific states):**
```typescript
test("shows failed batch error", async ({ page, mocks }) => {
  await mockAuthenticated(page);
  const failedBatch = mocks.batch({ status: "failed", error_message: "Parse error" });
  await mockAllApis(page, {
    batches: [failedBatch],
    videos: [],
    dashboardResponse: mocks.dashboardResponse(),
  });

  await page.goto("/app/batches");
  await expect(page.getByText("Failed")).toBeVisible();
});
```

### Creating New Fixtures

When a new page or feature needs a specialized setup, extend the base fixtures:

```typescript
// In fixtures.ts
export const test = base.extend<Fixtures>({
  // ... existing fixtures ...

  authedPageWithFailedVideo: async ({ page }, use) => {
    await mockAuthenticated(page);
    const video = mockFactories.video({
      status: "failed",
      current_stage: "image_generation",
      error_message: "Gemini API rate limit",
    });
    const data: MockData = {
      batches: [],
      videos: [video],
      dashboardResponse: mockFactories.dashboardResponse({ failed_videos: 1 }),
    };
    await mockAllApis(page, data);
    await use({ page, video });
  },
});
```

---

## 4. Mock Data Factories

### Design Principles

1. **Unique IDs per call:** Every factory call generates a new `randomUUID()`. Tests never share IDs.
2. **Sensible defaults:** Factories return valid, complete objects. Override only what matters for the test.
3. **Linked data:** Use `fullDataset()` when you need batches with associated videos.
4. **Mirror API schemas:** Factory types must match the API response shapes exactly.

### Using Factories

```typescript
// Single object with defaults
const batch = mockFactories.batch();

// Override specific fields
const failedBatch = mockFactories.batch({
  status: "failed",
  error_message: "File parsing failed",
});

// Linked dataset
const { batches, videos, dashboardResponse } = mockFactories.fullDataset();

// Custom video linked to a batch
const batch = mockFactories.batch();
const video = mockFactories.video({ batch_id: batch.id, status: "processing" });
```

### Adding a New Factory

When a new API entity is introduced:

1. Define the interface in `mock-data.ts` mirroring the API schema
2. Create a factory function with `randomUUID()` and sensible defaults
3. Accept `Partial<T>` overrides via spread
4. Add to `MockData` interface if it needs API route mocking
5. Add the corresponding `route.fulfill()` handler in `fixtures.ts`

```typescript
// In mock-data.ts
interface ShotRead {
  id: string;
  video_id: string;
  order: number;
  text: string;
  image_prompt: string;
  image_url: string | null;
  start_time: number;
  end_time: number;
  created_at: string;
}

export const mockFactories = {
  // ... existing factories ...

  shot(overrides: Partial<ShotRead> = {}): ShotRead {
    return {
      id: randomUUID(),
      video_id: randomUUID(),
      order: 0,
      text: "Amazing product showcase",
      image_prompt: "A vibrant product on white background",
      image_url: "shots/image.png",
      start_time: 0,
      end_time: 2.5,
      created_at: isoNow(),
      ...overrides,
    };
  },
};
```

---

## 5. API Mocking with route.fulfill()

### Core Pattern

All E2E tests run without a backend. Every API call is intercepted via `page.route()` and fulfilled with mock data.

```typescript
// Glob pattern for simple endpoints
await page.route("**/api/v1/settings", (route) =>
  route.fulfill({ status: 200, json: settingsData }),
);

// Regex pattern for endpoints with dynamic IDs
await page.route(/\/api\/v1\/batches/, (route) => {
  const url = route.request().url();
  const detailMatch = url.match(/batches\/([0-9a-f-]{36})/);
  if (detailMatch) {
    const batch = batches.find((b) => b.id === detailMatch[1]);
    return route.fulfill({
      status: batch ? 200 : 404,
      json: batch ?? { message: "Not found" },
    });
  }
  return route.fulfill({ status: 200, json: pageResponse(batches) });
});
```

### Paginated Responses

Always wrap list responses in the `PageResponse` format:

```typescript
function pageResponse<T>(items: T[]) {
  return {
    items,
    page: 1,
    page_size: 50,
    total: items.length,
    total_pages: items.length > 0 ? 1 : 0,
  };
}
```

### Mocking Mutations (POST, PATCH, DELETE)

```typescript
// Mock a form submission and capture the payload
let savedPayload: Record<string, unknown> | null = null;
await page.route("**/api/v1/settings*", async (route) => {
  if (route.request().method() === "PATCH") {
    savedPayload = route.request().postDataJSON();
    await route.fulfill({ status: 200, json: { ...settingsData, ...savedPayload } });
  } else {
    await route.fulfill({ status: 200, json: settingsData });
  }
});
```

### Mocking Error Responses

```typescript
await page.route("**/api/v1/auth/login", (route) =>
  route.fulfill({ status: 401, json: { detail: "Invalid password" } }),
);
```

### Mocking Delayed Responses (Loading States)

```typescript
await page.route("**/api/v1/auth/login", async (route) => {
  await new Promise((r) => setTimeout(r, 500));
  await route.fulfill({ status: 200, json: { authenticated: true } });
});
```

### Mocking State Transitions

Use closure variables to simulate state changes (e.g., login flipping auth state):

```typescript
let authenticated = false;

await page.route("**/api/v1/auth/me", (route) =>
  route.fulfill({
    status: authenticated ? 200 : 401,
    json: authenticated ? { authenticated: true } : { detail: "Not authenticated" },
  }),
);

await page.route("**/api/v1/auth/login", async (route) => {
  authenticated = true;
  await route.fulfill({ status: 200, json: { authenticated: true } });
});
```

---

## 6. Selector Priorities

Use this priority order. Never use CSS selectors unless no semantic alternative exists.

| Priority | Method | When to use | Example |
|---|---|---|---|
| 1 | `getByRole` | Buttons, headings, links, textboxes, menus | `page.getByRole("button", { name: /save/i })` |
| 2 | `getByLabel` | Form inputs with visible labels | `page.getByLabel(/master prompt/i)` |
| 3 | `getByPlaceholder` | Inputs with placeholder text | `page.getByPlaceholder("Enter team password")` |
| 4 | `getByText` | Visible text content | `page.getByText("No batches yet")` |
| 5 | `data-testid` | Last resort for elements with no semantic meaning | `page.getByTestId("stage-bar-3")` |
| Never | CSS selectors | Only for verifying visual classes in assertions | `container.querySelector(".animate-pulse")` |

### Selector Tips

- Use `{ exact: true }` when text matches are ambiguous: `getByRole("heading", { name: "Videos", exact: true })`
- Use regex for case-insensitive or partial matches: `getByRole("button", { name: /add new/i })`
- Use `.first()` when multiple elements match and you want the first: `page.getByText("Completed").first()`
- Chain and filter for precise targeting: `page.getByRole("row").filter({ hasText: "Q1 Campaign" }).getByRole("button")`

---

## 7. Auth State Transitions

### Pattern: Testing Protected Routes

```typescript
const protectedRoutes = ["/", "/app", "/app/settings", "/app/videos", "/app/batches"];

for (const route of protectedRoutes) {
  test(`${route} redirects to /login`, async ({ page }) => {
    await mockUnauthenticated(page);
    await page.goto(route);
    await expect(page).toHaveURL(/\/login/);
  });
}
```

### Pattern: Login Flow with State Flip

```typescript
test("successful login redirects to /app", async ({ page }) => {
  let authenticated = false;

  await page.route("**/api/v1/auth/me", (route) =>
    route.fulfill({
      status: authenticated ? 200 : 401,
      json: authenticated ? { authenticated: true } : { detail: "Not authenticated" },
    }),
  );

  await page.goto("/login");
  await page.route("**/api/v1/auth/login", async (route) => {
    authenticated = true;
    await route.fulfill({ status: 200, json: { authenticated: true } });
  });
  await mockEmptyDashboard(page);

  await page.getByPlaceholder("Enter team password").fill("correct-password");
  await page.getByRole("button", { name: "Sign in" }).click();
  await expect(page).toHaveURL("/app");
});
```

### Pattern: Session Expiry

```typescript
test("expired session redirects to login on navigation", async ({ page }) => {
  let authenticated = true;

  await page.route("**/api/v1/auth/me", (route) =>
    route.fulfill({
      status: authenticated ? 200 : 401,
      json: authenticated ? { authenticated: true } : { detail: "Not authenticated" },
    }),
  );
  await mockEmptyDashboard(page);

  await page.goto("/app");
  await expect(page.getByRole("heading", { name: "Dashboard" })).toBeVisible();

  authenticated = false;  // Session expires

  await page.getByRole("link", { name: "Settings" }).click();
  await expect(page).toHaveURL(/\/login/);
});
```

---

## 8. Flaky Test Prevention

### Use Web-First Assertions (Auto-Retrying)

```typescript
// CORRECT: auto-retries until condition is met or timeout
await expect(page.getByText("Dashboard")).toBeVisible();
await expect(page).toHaveURL("/app");

// WRONG: no retry, fails on timing issues
expect(await page.getByText("Dashboard").isVisible()).toBe(true);
```

### Wait for Network Stability

When a page makes multiple API calls on load, wait for the key content rather than using `networkidle`:

```typescript
// CORRECT: wait for the actual content you need
await page.goto("/app");
await expect(page.getByRole("heading", { name: "Dashboard" })).toBeVisible();

// AVOID: networkidle is unreliable with SSE or polling
await page.goto("/app", { waitUntil: "networkidle" });
```

### Handle Conditional UI

When testing elements that may or may not be present (e.g., action menus):

```typescript
// CORRECT: guard with isVisible before interacting
const actionButtons = page.getByRole("button", { name: /open menu/i });
if (await actionButtons.first().isVisible()) {
  await actionButtons.first().click();
  const deleteOption = page.getByRole("menuitem", { name: /delete/i });
  if (await deleteOption.isVisible()) {
    await deleteOption.click();
    await expect(page.getByText(/cannot be undone/i)).toBeVisible();
  }
}
```

### Avoid Hardcoded Waits

```typescript
// WRONG
await page.waitForTimeout(2000);

// CORRECT: wait for a specific condition
await page.waitForResponse("**/api/v1/batches");
await expect(page.getByText("Q1 Campaign")).toBeVisible();
```

### Test Isolation

- Never share state between tests. Each test gets its own `page` and fresh mocks.
- Use factory functions with `randomUUID()` to avoid ID collisions.
- Never rely on test execution order.

---

## 9. Debugging

### Local Development

```bash
# Run all E2E tests
cd apps/react && npx playwright test

# Run a specific spec file
npx playwright test e2e/batches.spec.ts

# Run in headed mode (see the browser)
npx playwright test --headed

# Run in UI mode (time-travel debugging, watch mode)
npx playwright test --ui

# Debug a specific test (step through)
npx playwright test e2e/auth.spec.ts:24 --debug

# Show the HTML report after a run
npx playwright show-report
```

### Trace Viewer

Traces are configured to record on first retry (`trace: "on-first-retry"` in config). To view:

```bash
npx playwright show-trace test-results/path-to-trace.zip
```

Traces include: DOM snapshots, network requests, console logs, and action timeline.

### Screenshots and Video

The config captures screenshots on failure and retains video on failure:

```typescript
// playwright.config.ts
use: {
  screenshot: "only-on-failure",
  video: "retain-on-failure",
}
```

Artifacts are saved to `apps/react/test-results/`.

---

## 10. CI/CD Considerations

### Config for CI

The `playwright.config.ts` already handles CI via environment detection:

```typescript
{
  forbidOnly: !!process.env.CI,     // Fail if test.only is left in
  retries: process.env.CI ? 2 : 0,  // Retry flaky tests in CI
  workers: process.env.CI ? 1 : undefined,  // Sequential in CI for stability
  reporter: process.env.CI ? "github" : "list",  // GitHub Actions annotations
}
```

### CI Pipeline Steps

1. Install browsers: `npx playwright install chromium --with-deps`
2. Start dev server: handled automatically via `webServer` config
3. Run tests: `npx playwright test`
4. Upload artifacts: `test-results/` directory contains screenshots, videos, traces

### Preventing CI Failures

- Always use `process.env.CI` retries (already configured to 2)
- Never commit `test.only` (`forbidOnly: true` enforces this)
- Use `trace: "on-first-retry"` to debug CI-only failures without running locally

---

## 11. Step-by-Step: Adding a New E2E Test for a New Page

Example: Adding tests for a new `/app/templates` page.

### Step 1: Add Mock Data Factory

In `apps/react/e2e/mock-data.ts`:

```typescript
interface TemplateRead {
  id: string;
  name: string;
  width: number;
  height: number;
  created_at: string;
}

export const mockFactories = {
  // ... existing factories ...

  template(overrides: Partial<TemplateRead> = {}): TemplateRead {
    return {
      id: randomUUID(),
      name: `Template ${Math.random().toString(36).slice(2, 6)}`,
      width: 1080,
      height: 1920,
      created_at: isoNow(),
      ...overrides,
    };
  },

  fullDataset(): MockData {
    // ... add templates to the full dataset ...
  },
};
```

### Step 2: Add API Route Mock

In `apps/react/e2e/fixtures.ts`, extend `mockAllApis`:

```typescript
async function mockAllApis(page: Page, data?: MockData) {
  // ... existing mocks ...

  const templates = data?.templates ?? [];
  await page.route(/\/api\/v1\/templates/, (route) => {
    const url = route.request().url();
    const detailMatch = url.match(/templates\/([0-9a-f-]{36})/);
    if (detailMatch) {
      const template = templates.find((t) => t.id === detailMatch[1]);
      return route.fulfill({
        status: template ? 200 : 404,
        json: template ?? { message: "Not found" },
      });
    }
    return route.fulfill({ status: 200, json: pageResponse(templates) });
  });
}
```

### Step 3: Write the Spec File

Create `apps/react/e2e/templates.spec.ts`:

```typescript
import { test, expect } from "./fixtures";

test.describe("templates -- list page", () => {
  test("shows empty state when no templates exist", async ({ authedPage: page }) => {
    await page.goto("/app/templates");
    await expect(page.getByText("No templates yet")).toBeVisible();
  });

  test("shows template list with data", async ({ authedPageWithData: { page, data } }) => {
    await page.goto("/app/templates");
    for (const template of data.templates) {
      await expect(page.getByText(template.name)).toBeVisible();
    }
  });
});

test.describe("templates -- create dialog", () => {
  test("create template button opens dialog", async ({ authedPage: page }) => {
    await page.goto("/app/templates");
    await page.getByRole("button", { name: /add new/i }).click();
    await expect(page.getByText("Create Template")).toBeVisible();
  });
});
```

### Step 4: Run and Verify

```bash
cd apps/react
npx playwright test e2e/templates.spec.ts --headed
```

### Step 5: Add Smoke Test

In `apps/react/e2e/smoke.spec.ts`, add:

```typescript
test("templates page loads", async ({ authedPage: page }) => {
  await page.goto("/app/templates");
  await expect(page.getByRole("heading", { name: "Templates" })).toBeVisible();
});
```

---

## 12. Anti-Patterns to Avoid

| Anti-Pattern | Why it is wrong | Correct approach |
|---|---|---|
| `page.locator(".btn-primary")` | Breaks when CSS changes | `page.getByRole("button", { name: /save/i })` |
| `page.waitForTimeout(3000)` | Slow and unreliable | `await expect(locator).toBeVisible()` |
| `expect(await el.isVisible()).toBe(true)` | No auto-retry | `await expect(el).toBeVisible()` |
| Shared mutable state between tests | Cascading failures | Use fixtures and fresh factory data per test |
| Testing implementation details | Brittle, breaks on refactors | Test user-visible behavior |
| `networkidle` wait strategy | Unreliable with SSE/polling | Wait for specific content |
| Hardcoded UUIDs in mock data | Risk of collision, unclear intent | Use `randomUUID()` from factories |
| Testing third-party library behavior | Wastes time, not your code | Trust your dependencies, test your integration |
| `test.only` committed to main | Silently skips other tests | `forbidOnly: true` in CI config |

---

## 13. Checklist: Before Submitting E2E Tests

- [ ] Tests use `authedPage` or `authedPageWithData` fixtures (not raw `page` for authenticated routes)
- [ ] All API calls are mocked via `route.fulfill()` -- no real backend dependency
- [ ] Mock data uses factories with `randomUUID()` -- no hardcoded IDs
- [ ] Selectors follow priority order: `getByRole` > `getByLabel` > `getByPlaceholder` > `getByText`
- [ ] All assertions use web-first assertions (`await expect(locator).toBeVisible()`)
- [ ] No `waitForTimeout` calls
- [ ] No `test.only` left in the code
- [ ] Tests pass in headless mode: `npx playwright test`
- [ ] Test names describe behavior, not implementation
- [ ] New routes have a corresponding smoke test in `smoke.spec.ts`
