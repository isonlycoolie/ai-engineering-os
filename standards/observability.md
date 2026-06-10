# Observability Standards

Every production service emits logs, metrics, and traces.

## Logs - Structured JSON

```json
{
  "timestamp": "2025-01-01T12:00:00.000Z",
  "level": "error",
  "service": "payments-api",
  "requestId": "req_abc123",
  "userId": "usr_xyz789",
  "message": "Stripe webhook verification failed",
  "error": {
    "code": "WEBHOOK_SIGNATURE_INVALID",
    "detail": "Expected signature does not match computed signature"
  },
  "duration_ms": 12
}
```

### Log Levels

| Level | Use |
|-------|-----|
| `error` | Operation failed; attention may be required |
| `warn` | Succeeded but something unexpected occurred |
| `info` | Normal operational event |
| `debug` | Diagnostic detail; disabled in production |

## Metrics

- Request rate, error rate, latency per endpoint
- Database query duration; alert at p95
- Queue depth and processing lag for background jobs

## Traces

- Correlation ID on every inbound request, propagated downstream
- 100% sampling for errored requests; representative sample for success

## Agent Invocation

| Task | Agent / Resource |
|------|------------------|
| Configure logging | [sre-engineer](../agents/sre-engineer/) |
| Pre-production checklist | [sre-engineer/checklists/pre-production.md](../agents/sre-engineer/checklists/pre-production.md) |
| Incident debugging | [debugging-prompt.md](../prompts/debugging-prompt.md) |
| Alert templates | [monitoring/](../monitoring/) |
