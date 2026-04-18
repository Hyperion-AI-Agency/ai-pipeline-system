import path from "node:path";
import { defineConfig, devices } from "@playwright/test";

const authFile = path.join(__dirname, "playwright/.auth/user.json");

/**
 * Playwright E2E config for the Next.js frontend app.
 *
 * Directory convention:
 *   e2e/auth/       -> unauthenticated project (sign-in, sign-up, reset-password flows)
 *   e2e/dashboard/  -> authenticated project (requires logged-in session)
 *   e2e/api/        -> api project (direct FastAPI requests, no browser)
 *
 * @see https://playwright.dev/docs/test-configuration
 */
export default defineConfig({
  testDir: "./e2e",
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: "html",
  globalSetup: "./e2e/global-setup.ts",

  use: {
    baseURL: process.env.BASE_URL || "http://localhost:3000",
    trace: "on-first-retry",
  },

  /* In CI, servers are pre-started as background processes in the workflow.
     Locally, Playwright starts the Next.js dev server if not already running. */
  webServer: {
    command: "pnpm run dev",
    url: "http://localhost:3000",
    reuseExistingServer: true,
    timeout: 120_000,
  },

  projects: [
    // Auth setup — runs first, saves storageState for authenticated tests
    {
      name: "setup",
      testMatch: /auth\.setup\.ts/,
    },

    // Tests that run without authentication (sign-in, sign-up, reset-password, etc.)
    {
      name: "unauthenticated",
      use: { ...devices["Desktop Chrome"] },
      testMatch: /\/auth\/.*\.spec\.ts/,
    },

    // Tests that require an authenticated user session
    {
      name: "authenticated",
      use: {
        ...devices["Desktop Chrome"],
        storageState: authFile,
      },
      dependencies: ["setup"],
      testMatch: /\/dashboard\/.*\.spec\.ts/,
    },

    // Direct API tests against FastAPI (:8000)
    {
      name: "api",
      use: {
        baseURL: process.env.API_BASE_URL || "http://localhost:8000",
      },
      testMatch: /\/api\/.*\.spec\.ts/,
    },
  ],
});
