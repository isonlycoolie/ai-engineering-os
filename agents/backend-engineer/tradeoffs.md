# Backend Engineer Agent - Tradeoff Guidance

Select the appropriate option based on **explicit context** - requirement, scale, team boundaries, and data sensitivity. Do not default to personal preference. Escalate to Architecture Engineer when the decision is irreversible or cross-service.

## Consistency vs. Availability

| Option A | Option B | Guidance |
|----------|----------|----------|
| Strong consistency | Eventual consistency | **Default strong** for financial transactions, inventory, auth state. **Eventual** acceptable for read-heavy analytics, activity feeds, search indexes |

**Signals for strong consistency:** money movement, inventory deduction, permission grants, idempotency-sensitive writes.

**Signals for eventual consistency:** dashboards, recommendations, non-critical notifications, denormalized read models.

## REST vs. Event-Driven

| Option A | Option B | Guidance |
|----------|----------|----------|
| Synchronous REST | Async messaging | **REST** for request-response, CRUD, client-facing APIs. **Messaging** for fire-and-forget, cross-service workflows, audit trails, fan-out |

**Do not** use messaging to hide synchronous coupling the client still waits on. **Do not** use REST for high-volume fan-out where consumers scale independently.

## Caching Granularity

| Option A | Option B | Guidance |
|----------|----------|----------|
| Cache full objects | Cache computed fields | **Full objects** unless object is large (>100KB), invalidation complexity is high, or only a slice is read |

Document invalidation strategy regardless of granularity. Prefer cache-aside pattern with explicit TTL.

## ORM vs. Raw SQL

| Option A | Option B | Guidance |
|----------|----------|----------|
| ORM (Prisma, SQLAlchemy) | Raw SQL | **ORM** for standard CRUD, migrations, and team velocity. **Raw SQL** for complex reporting, aggregations, CTEs, or performance-critical paths with documented benchmarks |

Raw SQL lives in repository layer - never scattered in controllers.

## Monolith vs. Microservices

| Option A | Option B | Guidance |
|----------|----------|----------|
| Modular monolith | Microservices | **Default modular monolith** with clear module boundaries. **Extract services** only when team boundaries, independent scaling, or deployment isolation are clear and documented in ADR |

See [`architecture/patterns/modular-monolith.md`](../../architecture/patterns/modular-monolith.md).

## Sync vs. Async Processing

| Option A | Option B | Guidance |
|----------|----------|----------|
| Inline in request | Background job | **Inline** when user needs immediate result and work completes in <500ms p95. **Background** for email, exports, webhooks, heavy computation |

Return `202 Accepted` with job ID when deferring; provide status endpoint.

## Database Choice

| Option A | Option B | Guidance |
|----------|----------|----------|
| PostgreSQL | MongoDB | **PostgreSQL** as default relational store. **MongoDB** only when schema is genuinely unstructured, document shape varies widely, and relational modeling is actively harmful - requires ADR |

## Queue Technology

| Option A | Option B | Guidance |
|----------|----------|----------|
| BullMQ (Redis) | Kafka / RabbitMQ | **BullMQ** for app-level job queues with moderate volume. **Kafka** for event streaming, audit logs, high-throughput fan-out. **RabbitMQ** for complex routing and traditional message broker patterns |

## Pagination Strategy

| Option A | Option B | Guidance |
|----------|----------|----------|
| Cursor-based | Offset-based | **Cursor** for large, frequently updated datasets. **Offset** only for admin tools with small, stable result sets |

## Error Retry Strategy

| Option A | Option B | Guidance |
|----------|----------|----------|
| Immediate retry | Exponential backoff + circuit breaker | **Never** immediate unbounded retry on external calls. **Exponential backoff** with jitter; **circuit breaker** when downstream is degraded |

Idempotent operations only for retries. Non-idempotent writes require idempotency keys.

## Decision Escalation

Escalate to Architecture Engineer (ADR required) when:

- Introducing a new database, broker, or external service
- Changing consistency model for financial or auth data
- Splitting or merging service boundaries
- Any decision difficult to reverse within one sprint
