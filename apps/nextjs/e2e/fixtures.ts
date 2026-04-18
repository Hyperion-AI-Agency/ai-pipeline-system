import { test as base, type APIRequestContext } from "@playwright/test";

/**
 * Custom Playwright fixtures.
 *
 * Extend this file to add reusable test helpers, API clients,
 * or other shared state across tests.
 */

type Fixtures = {
  /** Pre-configured API request context for FastAPI backend */
  apiClient: APIRequestContext;
};

export const test = base.extend<Fixtures>({
  apiClient: async ({ playwright }, use) => {
    const apiBaseUrl = process.env.API_BASE_URL || "http://localhost:8000";
    const context = await playwright.request.newContext({
      baseURL: apiBaseUrl,
    });
    await use(context);
    await context.dispose();
  },
});

export { expect } from "@playwright/test";
