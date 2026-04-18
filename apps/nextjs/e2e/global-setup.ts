/**
 * Global setup for Playwright E2E tests.
 *
 * Runs once before all test projects. Use this to:
 * - Wait for backend services to be ready
 * - Seed test data
 * - Set up any global test state
 */
async function globalSetup() {
  const apiBaseUrl = process.env.API_BASE_URL || "http://localhost:8000";

  // Wait for FastAPI backend to be ready (up to 60s)
  const maxRetries = 30;
  const retryInterval = 2000;

  for (let i = 0; i < maxRetries; i++) {
    try {
      const response = await fetch(`${apiBaseUrl}/health`);
      if (response.ok) {
        console.log("Backend is ready");
        return;
      }
    } catch {
      // Server not ready yet
    }

    if (i < maxRetries - 1) {
      console.log(`Waiting for backend... (${i + 1}/${maxRetries})`);
      await new Promise(resolve => setTimeout(resolve, retryInterval));
    }
  }

  console.warn("Backend did not become ready in time. Tests that depend on the API may fail.");
}

export default globalSetup;
