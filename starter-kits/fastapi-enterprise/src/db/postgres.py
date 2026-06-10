"""PostgreSQL connection factory — wire into lifespan and health checks as the app grows."""

from src.config import settings


def get_database_url() -> str:
    return settings.database_url
