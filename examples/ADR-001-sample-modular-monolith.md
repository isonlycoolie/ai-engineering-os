# ADR-001: Default to Modular Monolith for New Services

> **Sample ADR** - illustrative example for `architecture/decisions/`. Not a binding decision for your project unless accepted by a human lead.

---

## Status

**Accepted**

---

## Context

- **Feature / initiative:** Greenfield payments platform - initial team of four engineers, expected MVP in 12 weeks.
- **Forcing function:** Need to ship quickly with strong transactional consistency for ledger entries; no proven independent scaling requirement yet.
- **Current state:** Empty repository; no existing microservices topology.
- **Constraints:** Small team, limited SRE capacity, PCI scope for card data handling.
- **Non-functional requirements:** 99.9% availability target at launch; p95 API latency < 300ms; audit trail for all money movement.

---

## Decision

Deploy a **modular monolith** as a single Node.js/TypeScript service with domain modules (`users`, `ledger`, `payments`, `notifications`). Modules communicate via internal interfaces within the process - not HTTP between services. Use PostgreSQL as the system of record with schema separation per module where practical.

Extract services only when independent scaling, team ownership, or deployment cadence boundaries are evidenced - not preemptively.

---

## Alternatives Considered

| Option | Pros | Cons | Why rejected |
|--------|------|------|--------------|
| Microservices from day one | Independent deploy/scale per domain | Operational overhead, distributed transactions, higher PCI surface | No scaling or team boundary evidence at MVP |
| Serverless functions per endpoint | Low idle cost | Cold starts, complex local dev, harder audit trail | Poor fit for consistent ledger transactions |
| Modular monolith | Simple ops, ACID transactions, fast iteration | Must enforce module boundaries in code | **Selected** - best fit for team size and consistency needs |

---

## Consequences

**Easier:**

- Single deployment pipeline and observability footprint
- ACID transactions across ledger and payments modules
- Faster onboarding for new engineers

**Harder:**

- Must discipline module boundaries to avoid spaghetti imports
- Cannot scale payments workers independently without later extraction

**Risks:**

- Module boundaries erode under time pressure → schedule architecture reviews at extraction triggers

**Reversibility:** Medium cost - extraction to services requires API contracts and data migration planning.

---

## API Contract Impact

| Item | Detail |
|------|--------|
| **Public API change** | ☐ None ☑ Additive ☐ Breaking |
| **Version** | `/v1/` |
| **Deprecation plan** | N/A at launch |

---

## Related Decisions

| ADR | Relationship |
|-----|--------------|
| - | First structural ADR for this system |

---

## Review Date

**Revisit by:** 2026-12-01

**Triggers for early review:**

- Payments queue depth requires independent worker scaling for > 30 minutes sustained
- Second team owns notifications module with divergent release cadence

---

## Sign-Off

| Role | Name | Date | Decision |
|------|------|------|----------|
| Architecture Engineer (agent) | - | 2026-06-01 | Submitted Proposed |
| Lead engineer (human) | A. Rivera | 2026-06-03 | Accepted |

---

*Sample from AI Engineering OS - see [architecture/patterns/modular-monolith.md](../architecture/patterns/modular-monolith.md)*
