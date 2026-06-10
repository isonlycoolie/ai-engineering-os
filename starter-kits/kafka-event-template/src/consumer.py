
        logger.info(
            "Processed event_id=%s type=%s correlation_id=%s",
            envelope.event_id,
            envelope.event_type.value,
            envelope.correlation_id,
        )
        return True

    def run_once(self, limit: int = 100) -> int:
        """Poll and process up to `limit` messages. Returns count processed."""
        messages = self.broker.consume(self.settings.kafka_topic, limit=limit)
        processed = 0
        for key, value in messages:
            if self.process_message(key, value):
                processed += 1
        return processed


def default_handler(envelope: EventEnvelope) -> None:
    logger.info("Handling %s: %s", envelope.event_type.value, envelope.payload)


def create_broker(settings: Settings | None = None) -> FileBroker:
    cfg = settings or get_settings()
    out_path = Path(cfg.idempotency_store_path).parent / "outbox.jsonl"
    return FileBroker(path=out_path)


def main() -> None:
    logging.basicConfig(level=logging.INFO)
    settings = get_settings()
    consumer = EventConsumer(create_broker(settings), default_handler, settings=settings)
    count = consumer.run_once()
    print(f"Processed {count} message(s) from {settings.kafka_topic}")


if __name__ == "__main__":
    main()
