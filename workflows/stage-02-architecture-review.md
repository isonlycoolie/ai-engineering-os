# Stage 2 - Architecture Review

Produce a justified, reversible design with defined API contracts before implementation or test specification begins.

**Previous stage:** [Stage 1 - Requirement Clarity](stage-01-requirement-clarity.md)  
**Next stage:** [Stage 3 - Test Specification](stage-03-test-specification.md)

---

## Input / Output / Human Checkpoint

| | |
|---|---|
| **Input** | Human-approved feature specification with testable acceptance criteria |
| **Output** | Implementation plan, API contract, ADR(s) for structural changes |
| **Human checkpoint** | Lead engineer accepts ADR(s) and approves implementation plan |

---

## Agents Involved

| Agent | Role in this stage |
|-------|-------------------|
| [Architecture Engineer](../agents/architecture-engineer/role.md) | Primary - topology, ADRs, API contracts, failure modes, implementation plan |

Supporting references:

- [architecture-engineer/prompts/primary.md](../agents/architecture-engineer/prompts/primary.md)
- [architecture-engineer/prompts/review.md](../agents/architecture-engineer/prompts/review.md)
- [architecture-engineer/prompts/handoff.md](../agents/architecture-engineer/prompts/handoff.md)
- [architecture-engineer/checklists/architecture-review.md](../agents/architecture-engineer/checklists/architecture-review.md)
- [prompts/architecture-prompt.md](../prompts/architecture-prompt.md) (ADR deep-dive)

---

## Prompt to Run

Attach the approved feature spec, existing ADRs, and relevant architecture docs, then invoke:

**[workflows/prompts/stage-02-architecture-review.md](prompts/stage-02-architecture-review.md)**

Also attach:

- [prompts/global-system-prompt.md](../prompts/global-system-prompt.md)
- [architecture/README.md](../architecture/README.md)
- [standards/api.md](../standards/api.md)

---

## Files to Produce

| Artifact | Location | When required |
|----------|----------|---------------|
| Architecture Decision Record (ADR) | `architecture/decisions/ADR-NNN-<title>.md` | New services, databases, queues, dependencies, or boundary changes |
| API contract | OpenAPI or equivalent in repo (e.g., `api/openapi.yaml`) | Any new or changed public behavior |
| Implementation plan | Linked from feature spec, ADR, or `docs/features/<feature>/implementation-plan.md` | Always |
| Blast radius summary | Section in implementation plan or ADR | Always |
| Tradeoff table | ADR or implementation plan | Significant decisions with viable alternatives |

Templates:

- [architecture/decisions/ADR-000-template.md](../architecture/decisions/ADR-000-template.md)
- [agents/architecture-engineer/templates/adr-template.md](../agents/architecture-engineer/templates/adr-template.md)

---

## Exit Criteria Checklist

Complete [architecture-engineer/checklists/architecture-review.md](../agents/architecture-engineer/checklists/architecture-review.md) before handoff.

### Requirements alignment

- [ ] Approved feature specification read in full
- [ ] Acceptance criteria mapped to design elements
- [ ] Non-functional requirements addressed in design

### ADR completeness (when structural change applies)

- [ ] ADR created with Status **Proposed** (not Accepted - human accepts)
- [ ] Context, Decision, Alternatives (≥2), Consequences, Review Date present
- [ ] Reversibility classified (low / medium / high cost)
- [ ] Every new dependency justified with exit strategy

### Structural design

- [ ] Blast radius documented - services, stores, queues, external systems
- [ ] Service boundaries respect bounded contexts
- [ ] Failure modes analyzed - timeout, retry, idempotency, degradation
- [ ] Simplest design selected, or ADR explains why not

### API contract

- [ ] Contract defined **before** implementation handoff
- [ ] Response envelope aligns with [standards/api.md](../standards/api.md)
- [ ] Error codes machine-readable with actionable messages
- [ ] URL versioning strategy documented (`/v1/`, deprecation if breaking)

### Handoff readiness

- [ ] Implementation plan linked with defined contracts
- [ ] QA can derive test boundaries from spec and contract
- [ ] Open questions and blockers listed with owners
- [ ] **Lead engineer (human) accepted ADR(s) and approved plan** - recorded with name and date

---

## Common Failures and Recovery

| Failure | Signal | Recovery |
|---------|--------|----------|
| **ADR skipped for structural change** | New service, DB, or dependency without ADR | Stop. Write ADR with alternatives. Set Status to Proposed. Obtain human acceptance before Stage 3. |
| **Agent marked ADR Accepted** | ADR Status is Accepted without human sign-off | Revert Status to Proposed. Document human acceptance separately in handoff. |
| **API contract after code** | Implementation started before OpenAPI exists | Halt implementation. Define contract first. Amend plan if code diverged. |
| **Microservices by default** | Service split without team or scaling justification | Revisit ADR alternatives. Default to modular monolith unless forcing function documented. |
| **Missing failure modes** | No retry, timeout, or idempotency for external calls | Add failure mode section to ADR/plan. Design for failure before handoff. |
| **Untestable design** | QA cannot derive boundaries from plan | Clarify system boundaries, mocks, and contract examples. Re-run architecture prompt with QA traceability request. |
| **Premature optimization** | Caching, sharding, or async added without NFR evidence | Remove or justify with NFR from spec. Profile-driven optimization belongs in later stages. |

---

## Handoff to Stage 3

When exit criteria are met, pass to [Stage 3 - Test Specification](stage-03-test-specification.md) with:

1. Accepted ADR link(s) (Status: Accepted by human)
2. API contract link
3. Implementation plan with blast radius
4. Completed architecture review checklist
5. Architecture handoff per [architecture-engineer/prompts/handoff.md](../agents/architecture-engineer/prompts/handoff.md)

**Do not hand off to QA or implementation agents with Proposed-only ADRs for structural changes.**
