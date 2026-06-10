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
