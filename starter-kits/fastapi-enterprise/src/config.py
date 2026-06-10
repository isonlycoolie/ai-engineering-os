from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        extra="ignore",
    )

    app_name: str = "fastapi-enterprise"
    environment: str = "development"
    debug: bool = False
    host: str = "0.0.0.0"
    port: int = 8000
    log_level: str = "INFO"

    database_url: str = "postgresql://postgres:postgres@localhost:5432/app"
    redis_url: str = "redis://localhost:6379/0"


settings = Settings()
