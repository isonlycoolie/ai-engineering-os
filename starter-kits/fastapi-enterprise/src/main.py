from contextlib import asynccontextmanager

import structlog
from fastapi import FastAPI

from src.config import settings
from src.logging_config import configure_logging
from src.routers.health import router as health_router

logger = structlog.get_logger(__name__)


@asynccontextmanager
async def lifespan(app: FastAPI):
    configure_logging(settings.log_level)
    logger.info("application_starting", environment=settings.environment)
    yield
    logger.info("application_stopping")


app = FastAPI(title=settings.app_name, lifespan=lifespan)
app.include_router(health_router)


@app.get("/")
async def root():
    return {"service": settings.app_name, "docs": "/docs"}
