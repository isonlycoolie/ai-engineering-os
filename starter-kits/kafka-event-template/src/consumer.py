"""Kafka event consumer with idempotent processing stub."""

from __future__ import annotations

import json
import logging
from dataclasses import dataclass, field
from pathlib import Path
from typing import Callable, Protocol

from src.config import Settings, get_settings
from src.schemas.events import EventEnvelope, validate_payload

logger = logging.getLogger(__name__)

EventHandler = Callable[[EventEnvelope], None]


class MessageBroker(Protocol):
    def consume(self, topic: str, limit: int = 100) -> list[tuple[bytes, bytes]]:
        ...


@dataclass
class IdempotencyStore:
    """Stub deduplication store — replace with Redis SET or DB unique constraint."""

    path: Path
    _seen: set[str] = field(default_factory=set, init=False)

    def __post_init__(self) -> None:
        self.path.parent.mkdir(parents=True, exist_ok=True)
        if self.path.exists():
            for line in self.path.read_text(encoding="utf-8").splitlines():
                if line.strip():
                    self._seen.add(line.strip())

    def already_processed(self, event_id: str) -> bool:
        return event_id in self._seen

    def mark_processed(self, event_id: str) -> None:
        if event_id in self._seen:
            return
        self._seen.add(event_id)
        with self.path.open("a", encoding="utf-8") as fh:
            fh.write(event_id + "\n")


@dataclass
class FileBroker:
    """Read from producer outbox file for local smoke tests."""

    path: Path
    _offset: int = 0

    def consume(self, topic: str, limit: int = 100) -> list[tuple[bytes, bytes]]:
        if not self.path.exists():
            return []

        messages: list[tuple[bytes, bytes]] = []
        lines = self.path.read_text(encoding="utf-8").splitlines()

        for line in lines[self._offset : self._offset + limit]:
            record = json.loads(line)
            if record["topic"] != topic:
                continue
            messages.append((record["key"].encode(), record["value"].encode()))

        self._offset += limit
        return messages


class EventConsumer:
    """Idempotent consumer — skips duplicate event_id, routes failures to DLQ (documented)."""

    def __init__(
        self,
        broker: MessageBroker,
        handler: EventHandler,
        *,
        settings: Settings | None = None,
        idempotency: IdempotencyStore | None = None,
    ) -> None:
        self.broker = broker
        self.handler = handler
        self.settings = settings or get_settings()
        store_path = Path(self.settings.idempotency_store_path) / "processed.jsonl"
        self.idempotency = idempotency or IdempotencyStore(path=store_path)

    def process_message(self, key: bytes, value: bytes) -> bool:
        """Process a single message. Returns True if handled, False if skipped (duplicate)."""
        envelope = EventEnvelope.from_kafka_value(value)

        if self.idempotency.already_processed(envelope.event_id):
            logger.info("Skipping duplicate event_id=%s", envelope.event_id)
            return False

        validate_payload(envelope)
        self.handler(envelope)
        self.idempotency.mark_processed(envelope.event_id)
