import path from "node:path";
import { expect, test as setup } from "@playwright/test";

const authFile = path.join(__dirname, "../playwright/.auth/user.json");

/**
 * Authentication setup — runs before the "authenticated" project.
 * Logs in a test user and saves the session to storageState.
 *
 * Customize the login flow below to match your sign-in page.
 */
setup("authenticate", async ({ page }) => {
  const email = process.env.TEST_USER_EMAIL || "test@example.com";
  const password = process.env.TEST_USER_PASSWORD || "testpassword123";

  await page.goto("/sign-in");

  await page.getByLabel("Email").fill(email);
  await page.getByLabel("Password").fill(password);
  await page.getByRole("button", { name: /sign in/i }).click();

  // Wait for redirect after login — adjust the URL pattern as needed
  await page.waitForURL("**/dashboard**", { timeout: 15_000 });

  await page.context().storageState({ path: authFile });
});
