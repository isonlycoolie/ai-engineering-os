from pydantic import BaseModel, ConfigDict, Field
from pydantic.alias_generators import to_camel


class HealthData(BaseModel):
    model_config = ConfigDict(alias_generator=to_camel, populate_by_name=True)

    status: str = "ok"
    service: str
    environment: str
    checks: dict[str, str] = Field(default_factory=dict)
