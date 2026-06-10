import structlog
from fastapi import APIRouter

from src.config import settings
from src.logging_config import utc_now_iso
from src.schemas.envelope import success_response
from src.schemas.health import HealthData

logger = structlog.get_logger(__name__)

router = APIRouter(prefix="/v1", tags=["health"])


@router.get("/health")
async def health_check():
    logger.info("health_check_requested", service=settings.app_name)

    data = HealthData(
        service=settings.app_name,
        environment=settings.environment,
        checks={
            "api": "ok",
            "postgres": "not_checked",
            "redis": "not_checked",
        },
    )

    return success_response(data.model_dump(by_alias=True), meta={"timestamp": utc_now_iso()})
