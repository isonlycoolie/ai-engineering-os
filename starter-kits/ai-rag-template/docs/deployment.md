# Deployment - AI RAG Template

## Production Checklist

- [ ] Replace stub embedder and LLM with production providers
- [ ] Use managed vector store with backup and access controls
- [ ] Enable structured logging and distributed tracing
- [ ] Configure eval sampling and alerting on metric regressions
- [ ] Set rate limits and cost caps on LLM calls
- [ ] Run security review (Stage 5) before production traffic

## Container Deployment

Build from `docker/Dockerfile`:

```bash
docker build -f docker/Dockerfile -t your-org/rag-service:latest .
```

Deploy to your orchestrator (Kubernetes, ECS, etc.) with:

- Secrets for `OPENAI_API_KEY` (or equivalent)
- Persistent volume or external vector DB connection
- Health endpoint once you add an API layer

## Observability

Align with [observability standards](../../../observability/README.md):

- Log pipeline latency, retrieval count, and model ID per request
- Trace ingest → retrieve → generate spans
- Dashboard: p95 latency, eval faithfulness trend, error rate

## Scaling

- **Ingest:** batch jobs or queue-driven workers for large corpora
- **Retrieve:** horizontal read replicas on vector store
- **Generate:** async API with streaming responses for UX
