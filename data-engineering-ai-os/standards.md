# Standards

## Pipeline design
Idempotent tasks. Explicit dependencies. Retry with backoff. Dead-letter for poison messages. Timeouts on every external call.

## Data contracts
Versioned schemas. Documented null/default semantics. Owner contact for breaking changes. Consumer registration for new fields.

## Quality
SLI: freshness, completeness, accuracy thresholds. Alert on breach. Quarantine with metrics.

## Security
Least-privilege IAM. Encrypt at rest and in transit. Audit access to PII. Minimize fields in downstream marts.

## Git discipline
Small PRs for pipeline logic. Separate config from code where team uses GitOps.
