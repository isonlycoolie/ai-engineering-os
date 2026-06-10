# Standards

## Pipelines

- Idempotent tasks with clear deduplication keys.
- Partitioning strategy documented for time-series data.
- SLAs and freshness targets stated per dataset.

## Data quality

- Validate row counts, null rates, and key uniqueness at boundaries.
- Quarantine bad records; do not silently drop without metrics.

## Schema

- Backward-compatible changes preferred. Breaking changes versioned and announced.
- PII classified and minimized in downstream datasets.

## Operations

- Backfill runbook with cost and time estimates.
- Observability: task duration, failure rate, data volume anomalies.
