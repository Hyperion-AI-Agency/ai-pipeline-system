"""Integration tests for core routes (/, /health).

Verifies the root endpoint and health check respond correctly
using the core-only test client (no database required).
"""

from fastapi.testclient import TestClient


class TestCoreRoutes:
    """Verify root and health check endpoints return expected responses."""

    def test_root_returns_message_and_version(self, client: TestClient):
        """Root endpoint should return a welcome message and version string."""
        response = client.get("/")
        assert response.status_code == 200
        data = response.json()
        assert "message" in data
        assert data["version"] == "0.1.0"

    def test_health_returns_healthy(self, client: TestClient):
        """Health check should return status healthy with 200 OK."""
        response = client.get("/health")
        assert response.status_code == 200
        assert response.json() == {"status": "healthy"}
