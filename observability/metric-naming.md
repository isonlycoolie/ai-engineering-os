# Metric Naming Conventions

Consistent metric names enable cross-service dashboards, SLOs, and alerts.

## Format

```
{service}.{domain}.{metric_name}_{unit}
```

| Segment | Rules | Example |
|---------|-------|---------|
| `service` | kebab-case service name | `payments-api` |
| `domain` | Functional area | `http`, `db`, `queue`, `cache` |
| `metric_name` | snake_case, descriptive | `request_duration` |
| `unit` | Base unit suffix | `_seconds`, `_total`, `_bytes` |

## Standard HTTP metrics (RED)

Every HTTP service exposes:

| Metric | Type | Labels | Description |
|--------|------|--------|-------------|
| `{service}.http.requests_total` | Counter | `method`, `route`, `status` | Total HTTP requests |
| `{service}.http.request_duration_seconds` | Histogram | `method`, `route` | Request latency |
| `{service}.http.requests_in_flight` | Gauge | `method` | Concurrent requests |

Prometheus example:

```
payments_api_http_requests_total{method="POST",route="/v1/payments",status="201"}
payments_api_http_request_duration_seconds_bucket{method="POST",route="/v1/payments",le="0.5"}
```

Note: Prometheus replaces hyphens with underscores in exported names; document the mapping in service README.

## Database metrics

| Metric | Type | Labels |
|--------|------|--------|
| `{service}.db.query_duration_seconds` | Histogram | `operation`, `table` |
| `{service}.db.connections_active` | Gauge | `pool` |
| `{service}.db.errors_total` | Counter | `operation` |

## Queue / worker metrics

| Metric | Type | Labels |
|--------|------|--------|
| `{service}.queue.depth` | Gauge | `queue` |
| `{service}.queue.processing_lag_seconds` | Gauge | `queue` |
| `{service}.queue.messages_processed_total` | Counter | `queue`, `status` |

## Label cardinality rules

- **Do** use bounded label values: `method`, `route` (templated paths), `status` class
- **Do not** use unbounded labels: user IDs, raw URLs, free-text error messages
- **Route normalization**: `/users/123` → `/users/:id`

## Histogram buckets

Default HTTP latency buckets (seconds):

```
0.005, 0.01, 0.025, 0.05, 0.1, 0.25, 0.5, 1, 2.5, 5, 10
```

Align with [latency-p95 alerts](../monitoring/alerts/latency-p95.yml).

## Business metrics (optional)

Use a `business` domain for product KPIs:

```
orders.business.checkout_completed_total
orders.business.revenue_cents_total
```

Keep business metrics separate from infrastructure metrics for clearer ownership.

## Related

- [Observability standards](../standards/observability.md)
- [Alert templates](../monitoring/alerts/)
- [Sample dashboard](dashboards/sample-dashboard.json)
