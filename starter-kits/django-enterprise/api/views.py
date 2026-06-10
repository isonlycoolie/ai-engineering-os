from django.db import connection
from django.utils import timezone
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.views import APIView

from api.envelope import success


class HealthView(APIView):
    """Liveness and readiness probe with standard JSON envelope."""

    authentication_classes: list = []
    permission_classes: list = []

    def get(self, request: Request) -> Response:
        db_ok = self._check_database()
        payload = success(
            {
                "status": "ok" if db_ok else "degraded",
                "service": "django-enterprise",
                "timestamp": timezone.now().isoformat(),
                "checks": {
                    "database": "ok" if db_ok else "fail",
                },
            }
        )
        status_code = 200 if db_ok else 503
        return Response(payload, status=status_code)

    @staticmethod
    def _check_database() -> bool:
        try:
            with connection.cursor() as cursor:
                cursor.execute("SELECT 1")
                cursor.fetchone()
            return True
        except Exception:
            return False
