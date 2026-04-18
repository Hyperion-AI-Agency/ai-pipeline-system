import { expect, test } from "../fixtures";

test.describe("API health check", () => {
  test("GET /health returns 200", async ({ apiClient }) => {
    const response = await apiClient.get("/health");

    expect(response.ok()).toBeTruthy();
  });
});
