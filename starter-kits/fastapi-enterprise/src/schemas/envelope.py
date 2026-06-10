from typing import Any, Generic, TypeVar

from pydantic import BaseModel, ConfigDict, Field

T = TypeVar("T")


class ApiError(BaseModel):
    code: str
    message: str


class ApiEnvelope(BaseModel, Generic[T]):
    """Standard API response envelope per standards/api.md."""

    model_config = ConfigDict(populate_by_name=True)

    success: bool
    data: T | None = None
    meta: dict[str, Any] = Field(default_factory=dict)
    error: ApiError | None = None


def success_response(data: T, meta: dict[str, Any] | None = None) -> ApiEnvelope[T]:
    return ApiEnvelope(success=True, data=data, meta=meta or {}, error=None)


def error_response(
    code: str,
    message: str,
    meta: dict[str, Any] | None = None,
) -> ApiEnvelope[None]:
    return ApiEnvelope(
        success=False,
        data=None,
        meta=meta or {},
        error=ApiError(code=code, message=message),
    )
