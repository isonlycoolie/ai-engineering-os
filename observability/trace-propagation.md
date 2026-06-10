# Trace Propagation

Distributed tracing standards for services in the AI Engineering OS.

## Goals

- Every inbound request receives or generates a correlation identifier
- Trace context propagates across synchronous HTTP/RPC and asynchronous message boundaries
- Errored requests are always sampled; successful requests use representative sampling

## W3C Trace Context (preferred)

Use the [W3C Trace Context](https://www.w3.org/TR/trace-context/) headers:

| Header | Purpose |
|--------|---------|
| `traceparent` | Version, trace ID, parent span ID, trace flags |
| `tracestate` | Vendor-specific trace state (optional) |

### Inbound HTTP

1. If `traceparent` is present and valid, continue the trace
2. If absent, start a new root span and generate IDs
3. Always echo or forward trace context on outbound calls

Example `traceparent` value:

```
00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01
```

### Outbound HTTP

Attach headers to every downstream request:

```http
traceparent: 00-{trace-id}-{span-id}-01
tracestate: vendor=value
```

### Async / message queues

Include trace context in message metadata:

```json
{
  "headers": {
    "traceparent": "00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01"
  },
  "body": { "...": "..." }
}
```

## Correlation ID fallback

When full tracing is unavailable, propagate `X-Request-Id` (or `X-Correlation-Id`):

- Generate a UUID v4 if not provided on inbound requests
- Include in all structured logs (`requestId` field in [log-schema.json](log-schema.json))
- Return in response headers for client-side support tickets

## Logging integration

Log `traceId` and `spanId` alongside `requestId` so logs, metrics, and traces join in your observability backend.

## Sampling

| Condition | Sample rate |
|-----------|-------------|
| HTTP 5xx or unhandled exception | 100% |
| HTTP 4xx (client errors) | 10% (tunable) |
| Success | 1–5% (tunable by traffic volume) |

Adjust rates per environment; dev/staging may use 100% for debugging.

## OpenTelemetry (recommended instrumentation)

Use OpenTelemetry SDKs with OTLP export. Auto-instrument HTTP clients and servers where supported.

Minimum span attributes:

- `service.name`
- `http.method`, `http.route`, `http.status_code`
- `db.system`, `db.statement` (sanitized) for database calls

## Related

- [Observability standards](../standards/observability.md)
- [Metric naming](metric-naming.md)
- [Debugging prompt](../prompts/debugging-prompt.md)
