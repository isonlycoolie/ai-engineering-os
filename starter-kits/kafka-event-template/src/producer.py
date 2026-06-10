"""Kafka event producer."""

from __future__ import annotations

import json
import logging
from dataclasses import dataclass
from pathlib import Path
from typing import Protocol

from src.config import Settings, get_settings
from src.schemas.events import EventEnvelope, build_order_created

logger = logging.getLogger(__name__)


class MessageBroker(Protocol):
    def publish(self, topic: str, key: bytes, value: bytes) -> None:
        ...


@dataclass
class InMemoryBroker:
    """Stub broker for tests and local dev without Kafka."""

    messages: list[tuple[str, bytes, bytes]]

    def publish(self, topic: str, key: bytes, value: bytes) -> None:
        self.messages.append((topic, key, value))
        logger.info("Published to %s (key=%s, bytes=%d)", topic, key.decode(), len(value))


@dataclass
class FileBroker:
    """Append-only file broker for smoke tests."""

    path: Path

    def publish(self, topic: str, key: bytes, value: bytes) -> None:
        self.path.parent.mkdir(parents=True, exist_ok=True)
        record = {"topic": topic, "key": key.decode(), "value": value.decode()}
        with self.path.open("a", encoding="utf-8") as fh:
            fh.write(json.dumps(record) + "\n")
        logger.info("Appended event to %s", self.path)


class EventProducer:
    def __init__(self, broker: MessageBroker, settings: Settings | None = None) -> None:
        self.broker = broker
        self.settings = settings or get_settings()

    def publish(self, envelope: EventEnvelope) -> None:
        key = envelope.correlation_id.encode("utf-8")
        value = envelope.to_kafka_value()
        self.broker.publish(self.settings.kafka_topic, key, value)
        logger.info(
            "Published event_id=%s type=%s correlation_id=%s",
            envelope.event_id,
            envelope.event_type.value,
            envelope.correlation_id,
        )


def create_broker(settings: Settings | None = None) -> MessageBroker:
    """Factory — swap for confluent-kafka Producer in production."""
    cfg = settings or get_settings()
    out_path = Path(cfg.idempotency_store_path).parent / "outbox.jsonl"
    return FileBroker(path=out_path)


def main() -> None:
    logging.basicConfig(level=logging.INFO)
    settings = get_settings()
    producer = EventProducer(create_broker(settings), settings)

    event = build_order_created(
        order_id="ord-001",
        customer_id="cust-42",
        amount_cents=9900,
    )
    producer.publish(event)
    print(f"Published {event.event_type.value} → {settings.kafka_topic}")


if __name__ == "__main__":
    main()
