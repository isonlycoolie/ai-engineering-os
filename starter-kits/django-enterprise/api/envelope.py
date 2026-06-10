"""Standard JSON response envelope per API standards."""

from typing import Any


def success(data: Any, meta: dict | None = None) -> dict:
    return {
        "success": True,
        "data": data,
        "meta": meta or {},
        "error": None,
    }


def failure(
    code: str,
    message: str,
    details: list | None = None,
    meta: dict | None = None,
) -> dict:
    error: dict[str, Any] = {"code": code, "message": message}
    if details is not None:
        error["details"] = details
    return {
        "success": False,
        "data": None,
        "meta": meta or {},
        "error": error,
    }
