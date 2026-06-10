"""Event schema definitions with versioning pattern."""

from __future__ import annotations

import uuid
from datetime import datetime, timezone
from enum import Enum
from typing import Any

from pydantic import BaseModel, Field


class EventType(str, Enum):
    ORDER_CREATED = "order.created"
    ORDER_CANCELLED = "order.cancelled"
    USER_REGISTERED = "user.registered"


class EventEnvelope(BaseModel):
    """Canonical event envelope — all published events use this wrapper."""

    schema_version: int = Field(default=1, description="Increment on breaking payload changes")
    event_id: str = Field(default_factory=lambda: str(uuid.uuid4()))
    event_type: EventType
    correlation_id: str = Field(default_factory=lambda: str(uuid.uuid4()))
    occurred_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    payload: dict[str, Any]

    def to_kafka_value(self) -> bytes:
        return self.model_dump_json().encode("utf-8")

    @classmethod
    def from_kafka_value(cls, raw: bytes) -> "EventEnvelope":
        return cls.model_validate_json(raw)


class OrderCreatedPayload(BaseModel):
    order_id: str
    customer_id: str
    amount_cents: int


def build_order_created(order_id: str, customer_id: str, amount_cents: int, *, correlation_id: str | None = None) -> EventEnvelope:
    """Factory for a versioned OrderCreated event."""
    payload = OrderCreatedPayload(
        order_id=order_id,
        customer_id=customer_id,
        amount_cents=amount_cents,
    )
    return EventEnvelope(
        schema_version=1,
        event_type=EventType.ORDER_CREATED,
        correlation_id=correlation_id or str(uuid.uuid4()),
        payload=payload.model_dump(),
    )


def validate_payload(envelope: EventEnvelope) -> BaseModel:
    """Route envelope to typed payload validator by event_type."""
    if envelope.event_type == EventType.ORDER_CREATED:
        return OrderCreatedPayload.model_validate(envelope.payload)
    raise ValueError(f"Unsupported event_type: {envelope.event_type}")
