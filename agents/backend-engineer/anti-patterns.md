# Backend Engineer Agent - Anti-Patterns

The following patterns are explicitly banned. If an implementation requires any of these, flag it and propose an alternative before proceeding.

## Structural

| Anti-pattern | Why it fails | Alternative |
|--------------|--------------|-------------|
| **God objects** | Single class/module knows and does too much; untestable and brittle | Split by responsibility: transport, service, repository |
| **Anemic domain model** | All logic in services, entities are dumb data bags with no invariants | Encapsulate domain rules where they belong; keep services orchestrating |
| **Direct database access from controllers** | Business logic leaks into transport layer; untestable | Route → service → repository pattern always |

## Async and Concurrency

| Anti-pattern | Why it fails | Alternative |
|--------------|--------------|-------------|
| **Callback hell** | Deeply nested async logic without structure | `async/await`, typed promises, or structured concurrency |
| **Fire-and-forget without observability** | Silent failures in background work | Queue with retry, dead-letter, and structured logging |
| **Unbounded parallelism** | Resource exhaustion under load | Rate limits, semaphores, connection pools with caps |

## Data Access

| Anti-pattern | Why it fails | Alternative |
|--------------|--------------|-------------|
| **N+1 queries** | Linear DB round-trips per related record | Joins, eager loading, or batched `IN` queries |
| **Monolithic transaction blocks** | Long locks, partial failure ambiguity | Scope transactions to atomic business operations only |
| **SELECT *** | Over-fetching, schema coupling | Explicit column lists aligned to use case |
| **Missing indexes on filter/sort columns** | Full table scans at scale | Index strategy documented with query patterns |

## Error Handling

| Anti-pattern | Why it fails | Alternative |
|--------------|--------------|-------------|
| **Silent failures** | Exceptions caught and discarded without logging | Log with correlation ID; return standard error envelope |
| **Generic 500 for validation errors** | Clients cannot recover; support cannot diagnose | 4xx with machine-readable `code` and actionable `message` |
| **Leaking stack traces to clients** | Information disclosure | Internal detail in logs only; sanitized client response |

## Configuration and Security

| Anti-pattern | Why it fails | Alternative |
|--------------|--------------|-------------|
| **Magic numbers and strings** | Unmaintainable, error-prone | Named constants, enums, or config with validation |
| **Hardcoded environment values** | Breaks across environments; secret leakage risk | Environment variables validated at startup |
| **Unrestricted CORS** | Cross-origin abuse in production | Explicit allowed origins per environment |

## Caching

| Anti-pattern | Why it fails | Alternative |
|--------------|--------------|-------------|
| **Cache without invalidation strategy** | Stale reads, data integrity bugs | Define TTL, event-driven invalidation, or version keys |
| **Caching auth/session tokens inappropriately** | Security and consistency risk | Cache only idempotent, non-sensitive read models |

## Testing

| Anti-pattern | Why it fails | Alternative |
|--------------|--------------|-------------|
| **Testing implementation details** | Tests break on refactor | Assert behavior and contracts, not internals |
| **No failure-mode tests** | Production surprises | At least two failure modes per public endpoint |
| **Shared mutable test state** | Flaky, order-dependent tests | Isolated fixtures, transactions rolled back per test |
