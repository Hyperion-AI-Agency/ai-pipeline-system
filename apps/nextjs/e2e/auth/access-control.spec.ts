import { expect, test } from "@playwright/test";

test.describe("Access control", () => {
  test("redirects unauthenticated users from protected routes to sign-in", async ({ page }) => {
    await page.goto("/dashboard");

    await expect(page).toHaveURL(/sign-in/);
  });

  test("allows access to public pages without authentication", async ({ page }) => {
    const response = await page.goto("/");

    expect(response?.status()).toBe(200);
  });
});
