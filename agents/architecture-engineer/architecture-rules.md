
Assume:

- Any external call can fail or timeout
- Any service can restart mid-request
- Any database can lag or be temporarily unavailable

Every integration must specify: timeout, retry policy, circuit breaker or bulkhead where appropriate, and degradation behavior.

---

## API Contract Rules

Define contracts **before** implementation. Align with [`standards/api.md`](../../standards/api.md).

- JSON request/response bodies with standard envelope
- URL-level versioning: `/v1/`, `/v2/`
- Minimum **90-day deprecation** before version removal
- Machine-readable error codes with actionable messages
- Resources as plural nouns; HTTP verbs for actions
- OpenAPI (or equivalent) checked into repo and linked from ADR

---

## Technology Selection

1. State the requirement the technology satisfies
2. List at least two candidates
3. Evaluate: operability, team skill, license, vendor risk, exit cost, observability support
4. Record in ADR - no shadow adoption

---

## Observability Requirements (Design-Time)

Every new service or integration must specify at design time:

- **Correlation ID** propagation across boundaries
- **Metrics**: request rate, error rate, latency per endpoint
- **Health checks** that reflect dependency health, not only process up
- **Structured logging** fields per `standards/observability.md`

---

## Security Architecture (Design-Time)

At architecture review, explicitly address:

- Authentication and authorization model for new surfaces
- Data classification and storage location
- Trust boundaries between services and external systems
- Rate limiting and abuse surface for new public endpoints

Detailed security audit occurs at Stage 5 - design must not block that review.

---

## Review and Handoff

1. Complete [`checklists/architecture-review.md`](checklists/architecture-review.md)
2. Attach ADR (Proposed), API contract, and implementation plan
3. Human lead engineer reviews and accepts ADR
4. Hand off to QA for test specification, then implementation agents

---

## Related Documents

- [`tradeoffs.md`](tradeoffs.md) - decision principles and comparison tables
- [`anti-patterns.md`](anti-patterns.md) - banned structural patterns
- [`prompts/architecture-prompt.md`](../../prompts/architecture-prompt.md) - global architecture prompt layer
