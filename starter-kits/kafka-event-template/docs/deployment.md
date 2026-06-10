# Deployment - Kafka Event Template

## Production Checklist

- [ ] Replace stub brokers with `confluent-kafka` clients
- [ ] Configure SASL/SSL and topic ACLs
- [ ] Deploy idempotency store (Redis or PostgreSQL)
- [ ] Implement DLQ publishing and monitoring
- [ ] Document replay procedures in a runbook
- [ ] Set consumer lag alerts
- [ ] Complete security review (Stage 5) before production traffic

## Kafka Cluster

Deploy against your managed Kafka (Confluent Cloud, MSK, Aiven, etc.) or self-hosted cluster.

Required topics:

| Topic | Purpose |
|-------|---------|
| `domain.events.v1` | Primary event stream |
| `domain.events.v1.dlq` | Failed messages for inspection and replay |

Create topics with appropriate partition count and retention before deploying consumers.

## Container Deployment

```bash
docker build -f docker/Dockerfile -t your-org/event-service:latest .
```

Run producer and consumer as separate deployments (or combined worker) with:

- `KAFKA_BOOTSTRAP_SERVERS` pointing to the cluster
- Secrets for Kafka credentials
- Persistent volume only if using file-based idempotency (not recommended in prod)

## Observability

Align with [observability standards](../../../observability/README.md):

- Metrics: publish rate, consume rate, consumer lag, DLQ depth, idempotent skip count
- Logs: `event_id`, `correlation_id`, `event_type` on every handle
- Traces: link HTTP request → published event → consumer span

## Scaling

- Scale consumers up to partition count
- Use keyed messages (`correlation_id`) for ordering within a partition
- Consider compacted topics for changelog-style events
