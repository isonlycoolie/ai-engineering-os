"""Kafka event template tests."""

from pathlib import Path

import pytest

from src.config import Settings
from src.consumer import EventConsumer, IdempotencyStore
from src.producer import EventProducer, InMemoryBroker
from src.schemas.events import EventType, build_order_created, validate_payload


@pytest.fixture
def settings(tmp_path: Path) -> Settings:
    return Settings(
        IDEMPOTENCY_STORE_PATH=str(tmp_path / "idempotency"),
        KAFKA_TOPIC="test.events.v1",
    )


def test_event_envelope_roundtrip() -> None:
    event = build_order_created("o1", "c1", 1000)
    raw = event.to_kafka_value()
    restored = type(event).from_kafka_value(raw)
    assert restored.event_type == EventType.ORDER_CREATED
    assert restored.payload["order_id"] == "o1"


def test_validate_payload() -> None:
    event = build_order_created("o1", "c1", 500)
    payload = validate_payload(event)
    assert payload.order_id == "o1"
    assert payload.amount_cents == 500


def test_producer_publishes_to_broker(settings: Settings) -> None:
    broker = InMemoryBroker(messages=[])
    producer = EventProducer(broker, settings)
    event = build_order_created("o2", "c2", 2000)

    producer.publish(event)

    assert len(broker.messages) == 1
    topic, key, value = broker.messages[0]
    assert topic == settings.kafka_topic
    assert key == event.correlation_id.encode()


def test_consumer_idempotent(settings: Settings) -> None:
    handled: list[str] = []

    def handler(envelope):
        handled.append(envelope.event_id)

    broker = InMemoryBroker(messages=[])
    producer = EventProducer(broker, settings)
    event = build_order_created("o3", "c3", 3000)
    producer.publish(event)

    topic, key, value = broker.messages[0]
    store_path = Path(settings.idempotency_store_path) / "processed.jsonl"
    idempotency = IdempotencyStore(path=store_path)

    class SingleMessageBroker:
        def consume(self, topic: str, limit: int = 100):
            return [(key, value)]

    consumer = EventConsumer(
        SingleMessageBroker(),
        handler,
        settings=settings,
        idempotency=idempotency,
    )

    assert consumer.process_message(key, value) is True
    assert consumer.process_message(key, value) is False
    assert len(handled) == 1


def test_idempotency_store_persists(tmp_path: Path) -> None:
    path = tmp_path / "processed.jsonl"
    store = IdempotencyStore(path=path)
    store.mark_processed("evt-1")

    reloaded = IdempotencyStore(path=path)
    assert reloaded.already_processed("evt-1")
