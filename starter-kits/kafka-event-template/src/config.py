"""Environment configuration with startup validation."""

from pydantic import Field
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", extra="ignore")

    app_env: str = Field(default="development", alias="APP_ENV")
    log_level: str = Field(default="INFO", alias="LOG_LEVEL")

    kafka_bootstrap_servers: str = Field(default="localhost:9092", alias="KAFKA_BOOTSTRAP_SERVERS")
    kafka_topic: str = Field(default="domain.events.v1", alias="KAFKA_TOPIC")
    kafka_consumer_group: str = Field(default="domain-service", alias="KAFKA_CONSUMER_GROUP")
    kafka_client_id: str = Field(default="domain-service-1", alias="KAFKA_CLIENT_ID")
    kafka_dlq_topic: str = Field(default="domain.events.v1.dlq", alias="KAFKA_DLQ_TOPIC")

    idempotency_store_path: str = Field(default="./data/idempotency", alias="IDEMPOTENCY_STORE_PATH")
    event_schema_version: int = Field(default=1, alias="EVENT_SCHEMA_VERSION")


def get_settings() -> Settings:
    return Settings()
