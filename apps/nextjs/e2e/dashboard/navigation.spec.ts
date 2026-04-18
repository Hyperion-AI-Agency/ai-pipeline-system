import { expect, test } from "@playwright/test";

test.describe("Dashboard navigation", () => {
  test("authenticated user can access the dashboard", async ({ page }) => {
    await page.goto("/dashboard");

    await expect(page).toHaveURL(/dashboard/);
  });
});
