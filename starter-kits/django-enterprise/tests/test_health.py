import pytest
from django.urls import reverse
from rest_framework.test import APIClient


@pytest.fixture
def client() -> APIClient:
    return APIClient()


def test_health_returns_envelope(client: APIClient) -> None:
    response = client.get(reverse("health"))

    assert response.status_code == 200
    body = response.json()
    assert body["success"] is True
    assert body["error"] is None
    assert body["data"]["status"] == "ok"
    assert body["data"]["checks"]["database"] == "ok"


def test_health_includes_service_name(client: APIClient) -> None:
    response = client.get(reverse("health"))

    assert response.json()["data"]["service"] == "django-enterprise"
