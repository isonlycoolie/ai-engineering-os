# Architecture Engineer - Anti-Patterns

The following patterns are explicitly banned at the architecture layer. If a proposed design exhibits any of these, the agent must flag it and propose an alternative before handoff.

---

## Structural Anti-Patterns

| Anti-pattern | Why it fails | Correct approach |
|--------------|--------------|------------------|
| **Distributed monolith** | Microservices with shared database and tight coupling - worst of both models | Clear boundaries, independent deployability, explicit integration |
| **God service** | Single service owns unrelated domains; scaling and team ownership blur | Split by bounded context when boundaries are clear |
| **Chatty synchronous chains** | Latency compounds; failure cascades | Async messaging, aggregation, or batch where appropriate |
| **Shared mutable state across services** | Race conditions, inconsistent reads | Isolate state; use events or APIs with defined consistency |
| **Database as integration layer** | Hidden coupling; schema changes break multiple services | Explicit APIs or event contracts |

---

## Decision Process Anti-Patterns

| Anti-pattern | Why it fails | Correct approach |
|--------------|--------------|------------------|
| **Undocumented decisions** | Tribal knowledge; cannot audit or reverse | ADR for every structural change |
| **Single-option analysis** | False certainty; alternatives not considered | Minimum two alternatives in every ADR |
| **Accepted-by-agent ADRs** | No human ownership | Status `Proposed` until human accepts |
| **Implementation-led architecture** | Code defines structure retroactively | Contract and ADR before implementation |
| **Resume-driven development** | Technology chosen for familiarity | Requirement-driven selection with ADR |

---

## Complexity Anti-Patterns

| Anti-pattern | Why it fails | Correct approach |
|--------------|--------------|------------------|
| **Premature microservices** | Operational cost without scaling or team benefit | Modular monolith first; extract with justification |
| **Premature optimization** | Complexity without measured bottleneck | Profile; optimize with evidence |
| **Gold-plated resilience** | Cost exceeds risk | Match failure handling to SLO and blast radius |
| **Over-abstraction** | Hard to reason about and debug | Simplest design that meets requirements |
| **Event soup** | Untraceable causality | Clear event ownership and correlation |

---

## API and Contract Anti-Patterns

| Anti-pattern | Why it fails | Correct approach |
|--------------|--------------|------------------|
| **Implementation-first APIs** | Consumers coupled to internal models | Contract-first design; stable public surface |
| **Breaking changes without versioning** | Silent client failures | URL versioning; deprecation period |
| **Leaky internal IDs** | Coupling and enumeration risk | Stable public identifiers; internal mapping |
| **Inconsistent error envelopes** | Clients cannot handle failures uniformly | Standard envelope per `standards/api.md` |
| **Undocumented idempotency** | Duplicate operations corrupt state | Idempotency keys for mutating operations |

---

## Dependency Anti-Patterns

| Anti-pattern | Why it fails | Correct approach |
|--------------|--------------|------------------|
| **Dependency accumulation** | Supply chain and operational debt | Each dependency justified in ADR |
| **Vendor lock-in without exit plan** | Migration cost becomes prohibitive | Abstraction layer or documented exit |
| **Synchronous dependency chains** | Availability = product of all dependencies | Cache, async, circuit breakers, fallbacks |
| **Hidden third-party in critical path** | Unowned failure modes | Dependency map; SLO alignment |

---

## Requirements Anti-Patterns

| Anti-pattern | Why it fails | Correct approach |
|--------------|--------------|------------------|
| **Architecture after coding started** | Rework and boundary violations | Stage 1 clarity + Stage 2 review before implementation |
| **Untestable NFRs** ("highly available", "secure") | No verification bar | Measurable SLOs, threat model hooks |
| **Assumed scale** | Over- or under-engineering | State expected load; design for stated peak |
| **Ignored failure modes** | Outages in production | Explicit timeout, retry, degradation design |

---

## Detection Prompt

When reviewing a design or ADR, ask:

1. Is there an ADR with at least two alternatives and explicit consequences?
2. Is this the simplest design that meets the stated requirements?
3. Can this decision be reversed or migrated without a rewrite?
4. Is the API contract defined before implementation?
5. Does every new dependency have operational and exit cost documented?
6. Has a human accepted the ADR?

If any answer is no, the anti-pattern is present - remediate before handoff to implementation.
