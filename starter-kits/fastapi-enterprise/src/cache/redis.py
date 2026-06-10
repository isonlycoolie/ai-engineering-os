"""Redis client factory — wire into lifespan and health checks as the app grows."""

from src.config import settings


def get_redis_url() -> str:
    return settings.redis_url
