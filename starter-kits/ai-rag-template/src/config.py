"""Environment configuration with startup validation."""

from pydantic import Field
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", extra="ignore")

    app_env: str = Field(default="development", alias="APP_ENV")
    log_level: str = Field(default="INFO", alias="LOG_LEVEL")

    vector_store_path: str = Field(default="./data/vector_store", alias="VECTOR_STORE_PATH")
    embedding_model: str = Field(default="text-embedding-3-small", alias="EMBEDDING_MODEL")
    embedding_dimension: int = Field(default=1536, alias="EMBEDDING_DIMENSION")

    llm_provider: str = Field(default="openai", alias="LLM_PROVIDER")
    llm_model: str = Field(default="gpt-4o-mini", alias="LLM_MODEL")
    openai_api_key: str = Field(default="", alias="OPENAI_API_KEY")

    retrieval_top_k: int = Field(default=5, alias="RETRIEVAL_TOP_K")
    chunk_size: int = Field(default=512, alias="CHUNK_SIZE")
    chunk_overlap: int = Field(default=64, alias="CHUNK_OVERLAP")

    eval_enabled: bool = Field(default=True, alias="EVAL_ENABLED")
    eval_output_dir: str = Field(default="./data/eval", alias="EVAL_OUTPUT_DIR")


def get_settings() -> Settings:
    return Settings()
