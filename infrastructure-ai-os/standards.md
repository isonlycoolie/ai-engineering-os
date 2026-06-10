# Standards

# Architecture Engineer - Architecture Rules

Every architectural decision must be recorded, reviewable, and reversible where possible. These rules govern how structure is proposed, documented, and handed off to implementation.

---

## Architecture Decision Records (ADR)

### Location and Naming

```
architecture/decisions/
└── ADR-<number>-<short-title>.md
```

- Numbers are sequential integers: `ADR-001`, `ADR-002`, …
- Titles are kebab-case, short, and descriptive: `ADR-003-event-driven-order-fulfillment.md`
- One decision per ADR - do not bundle unrelated decisions

### Required ADR Structure

Use [`templates/adr-template.md`](templates/adr-template.md). Every ADR must contain:

| Section | Purpose |
|---------|---------|
| **Status** | `Proposed` \| `Accepted` \| `Deprecated` \| `Superseded by ADR-XXX` |
| **Context** | Situation, constraints, forces driving the decision |
| **Decision** | Clear, unambiguous statement of what was decided |
| **Alternatives Considered** | Minimum two options with rejection rationale |
| **Consequences** | Easier, harder, new risks |
| **Review Date** | When to revisit - architectural decisions expire |

### ADR Lifecycle

1. Agent creates ADR with Status **Proposed**
2. Human engineer reviews alternatives, consequences, and alignment with system direction
3. Human sets Status **Accepted** or requests revision
4. Implementation proceeds only after **Accepted** (or explicit human waiver documented)
5. When superseded, set Status **Superseded by ADR-NNN** - do not delete historical ADRs

**No architectural decision proceeds without a completed ADR reviewed by a human engineer.**

---

## When an ADR Is Required

An ADR is mandatory when the change:

- Adds, removes, or splits a **service** or deployable unit
- Introduces a new **database**, cache, queue, or persistence technology
- Adds a new **external dependency** or materially changes an integration
- Changes **service boundaries** or ownership of a domain
- Alters **consistency model** (strong vs eventual) for shared data
- Changes **API versioning** or public contract breaking behavior
- Affects **security trust boundaries** (auth model, network zones, data classification)
- Commits to **irreversible** infrastructure or data layout

An ADR is **not** required for:

- Internal refactors within an existing bounded context that preserve boundaries and contracts
- Bug fixes that do not change structural assumptions
- Dependency patch version updates with no API or behavior change

When in doubt, write an ADR - over-documentation of structure is preferable to silent drift.

---

## System Topology Rules

### Default Topology

- **Modular monolith** is the default deployment shape
- Extract services only when **team boundaries**, **independent scaling**, or **failure isolation** requirements are explicit and documented

### Service Boundaries

- One bounded context per service when services exist
- Services communicate via **defined APIs or events** - not shared database tables across contexts
