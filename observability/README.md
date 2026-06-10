# Observability

Structured logging, distributed tracing, metrics naming, and dashboard templates for production services.

## Layout

```
observability/
├── log-schema.json           # JSON Schema for structured logs
├── trace-propagation.md      # Correlation ID and trace context standards
├── metric-naming.md          # Metric naming conventions
└── dashboards/
    └── sample-dashboard.json # Starter Grafana dashboard stub
```

## Three pillars

| Pillar | Standard | Location |
|--------|----------|----------|
| Logs | Structured JSON with required fields | [log-schema.json](log-schema.json) |
| Traces | W3C Trace Context propagation | [trace-propagation.md](trace-propagation.md) |
| Metrics | `{service}.{domain}.{metric}` naming | [metric-naming.md](metric-naming.md) |

## Production requirements

Every production service must:

1. Emit logs conforming to `log-schema.json` (at minimum: `timestamp`, `level`, `service`, `message`)
2. Propagate `traceparent` / `tracestate` or equivalent correlation headers on outbound calls
3. Expose RED metrics (rate, errors, duration) per endpoint
4. Attach dashboards and alerts before first production deploy

## Agent invocation

| Task | Resource |
|------|----------|
| Configure logging | [sre-engineer](../agents/sre-engineer/) |
| Pre-production checklist | [pre-production.md](../agents/sre-engineer/checklists/pre-production.md) |
| Alert templates | [monitoring/](../monitoring/) |
| Standards overview | [standards/observability.md](../standards/observability.md) |
