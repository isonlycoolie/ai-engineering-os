# Instructions

Use when building or changing data pipelines, ETL/ELT, or data platform components.

## How AI should behave

- Treat data contracts as API contracts between producers and consumers.
- Design idempotent stages. Assume retries and partial failures.
- Document schema evolution and backward compatibility.
- Humans approve production pipeline changes affecting SLAs or PII.

## Scope

**In scope:** Ingestion, transformation, orchestration, data quality checks, backfills, lineage notes.

**Out of scope:** Mandating Spark/Airflow/dbt; inventing org-wide data mesh structure without approval.
