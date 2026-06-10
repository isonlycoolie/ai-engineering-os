# Local Setup - Kafka Event Template

Part of the [AI Engineering OS](../../../docs/START-HERE.md).

## Prerequisites

- Python 3.12+
- Docker and Docker Compose (for local Kafka)

## Steps

1. Copy environment variables:

   ```bash
   cp .env.example .env
   ```

2. Install dependencies:

   ```bash
   python -m venv .venv
   source .venv/bin/activate   # Windows: .venv\Scripts\activate
   pip install -r requirements.txt
   ```

3. Run unit tests (no Kafka required):

   ```bash
   pytest -v
   ```

4. Start Kafka locally:

   ```bash
   docker compose -f docker/docker-compose.yml up -d kafka
   ```

   Wait until healthy (`docker compose -f docker/docker-compose.yml ps`).

5. Smoke test with file-based stub broker:

   ```bash
   python -m src.producer
   python -m src.consumer
   ```

## Wiring Real Kafka

Uncomment `confluent-kafka` in `requirements.txt` and replace `FileBroker` in `producer.py` / `consumer.py` with a `confluent_kafka.Producer` / `Consumer` implementation.

Set `KAFKA_BOOTSTRAP_SERVERS=localhost:9092` (or `kafka:9092` inside Compose network).

## Next Steps

- Register schemas with Schema Registry (Avro/Protobuf) if required by your org
- Implement DLQ publishing on handler failure (see [architecture.md](architecture.md))
- Back idempotency store with Redis or PostgreSQL
