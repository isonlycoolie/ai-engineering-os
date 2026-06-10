# ADR-NNN: [Decision Title]

> Copy to `architecture/decisions/ADR-NNN-<short-title>.md` and replace placeholders. Agents set Status to **Proposed** only - humans accept.

---

## Status

**Proposed**

<!-- Accepted | Deprecated | Superseded by ADR-XXX - human-maintained only -->

---

## Context

What is the situation that requires this decision? What constraints exist?

- **Feature / initiative:**
- **Forcing function:** (scale, team boundary, compliance, latency, etc.)
- **Current state:**
- **Constraints:** (time, budget, team skill, existing stack, regulatory)
- **Non-functional requirements:**

---

## Decision

What was decided? State it clearly and without ambiguity.

[One to three paragraphs. Active voice. No hedging.]

---

## Alternatives Considered

### Alternative A: [Name]

**Description:**

**Pros:**

**Cons:**

**Why rejected:**

---

### Alternative B: [Name]

**Description:**

**Pros:**

**Cons:**

**Why rejected:**

---

### Alternative C: [Name] *(optional)*

**Description:**

**Pros:**

**Cons:**

**Why rejected:**

---

## Consequences

### What becomes easier

-

### What becomes harder

-

### New risks introduced

-

### Reversibility

| Class | ☐ Low cost ☐ Medium cost ☐ High cost |
|-------|----------------------------------------|
| **Revert strategy:** | |
| **Migration cost if wrong:** | |

---

## API Contract Impact

| Item | Detail |
|------|--------|
| **Public API change** | ☐ None ☐ Additive ☐ Breaking |
| **Version** | `/v1/` … |
| **OpenAPI link** | |
| **Deprecation plan** | (required if breaking) |

---

## Dependencies

| Dependency | Type | New? | Justification | Exit strategy |
|------------|------|------|---------------|---------------|
| | service / DB / SaaS / library | ☐ | | |

---

## Observability and Operations

- **Correlation ID propagation:**
- **Key metrics:**
- **Health check semantics:**
- **On-call / ownership:**

---

## Security Considerations

- **Auth model:**
- **Trust boundaries:**
- **Data classification:**

---

## Related Decisions

| ADR | Relationship |
|-----|--------------|
| ADR-XXX | supersedes / depends on / related |

---

## Review Date

**Revisit by:** YYYY-MM-DD

**Triggers for early review:**

-

---

## Checklist

- [ ] [`checklists/architecture-review.md`](../checklists/architecture-review.md) completed
- [ ] Human lead engineer review scheduled

---

## Sign-Off

| Role | Name | Date | Decision |
|------|------|------|----------|
| Architecture Engineer (agent) | | | Submitted Proposed |
| Lead engineer (human) | | | Accepted / Revisions required |

---

*Generated from AI Engineering OS - Architecture Engineer ADR template v1.0*
