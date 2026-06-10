# Stage 3 - Test Specification

Define observable correct behavior and traceability from acceptance criteria to test cases before feature code is written.

**Previous stage:** [Stage 2 - Architecture Review](stage-02-architecture-review.md)  
**Next stage:** [Stage 4 - Implementation](stage-04-implementation.md)

---

## Input / Output / Human Checkpoint

| | |
|---|---|
| **Input** | Human-approved implementation plan, API contract, and feature specification |
| **Output** | Test specification with traceability matrix |
| **Human checkpoint** | Engineer confirms test coverage is sufficient before implementation starts |

---

## Agents Involved

| Agent | Role in this stage |
|-------|-------------------|
| [QA Engineer](../agents/qa-engineer/role.md) | Primary - test cases, traceability, edge cases, failure modes |

Supporting references:

- [qa-engineer/prompts/primary.md](../agents/qa-engineer/prompts/primary.md)
- [qa-engineer/prompts/handoff.md](../agents/qa-engineer/prompts/handoff.md)
- [standards/testing.md](../standards/testing.md)

---

## Prompt to Run

Attach approved spec, implementation plan, API contract, and ADR(s), then invoke:

**[workflows/prompts/stage-03-test-specification.md](prompts/stage-03-test-specification.md)**

Also attach:

- [prompts/global-system-prompt.md](../prompts/global-system-prompt.md)
- [standards/api.md](../standards/api.md) (for contract verification)

---

## Files to Produce

| Artifact | Location | Owner |
|----------|----------|-------|
| Test specification | `docs/features/<feature-name>/test-spec.md` or PR attachment | QA Engineer (agent) |
| Traceability matrix | Section in test spec (requirement ID → test case IDs) | QA Engineer (agent) |
| System boundaries | Section in test spec (under test / mocked / excluded) | QA Engineer (agent) |
| Human coverage sign-off | PR comment, ticket, or spec header | Human engineer |

Use [`templates/test-spec.md`](../templates/test-spec.md) as the output scaffold when available.

---

## Exit Criteria Checklist

### Inputs verified

- [ ] Approved feature specification with acceptance criteria read in full
- [ ] Implementation plan and API contract reviewed
- [ ] ADR(s) reviewed for test-relevant boundaries (auth, failure modes, idempotency)

### Traceability

- [ ] Every acceptance criterion mapped to at least one test case
- [ ] Each test case has ID, priority, preconditions, steps, and expected result
- [ ] Pass/fail criteria are unambiguous - no subjective "looks correct"

### Coverage depth

- [ ] Happy path covered for each acceptance criterion
- [ ] Edge cases documented (minimum three per feature or per major workflow)
- [ ] Failure modes covered - invalid input, unauthorized access, downstream failure
- [ ] Auth rules tested for both authorized and unauthorized scenarios

### Boundaries

- [ ] System under test vs. mocked dependencies vs. out-of-scope explicitly listed
- [ ] API contract assertions reference documented error envelope and codes
- [ ] E2E scope defined - critical user workflows only, not every UI tweak

### Escalation

- [ ] Untestable or ambiguous requirements flagged - none left silently assumed
- [ ] Gaps escalated to Stage 1 or Stage 2 owners when spec or contract is insufficient

### Human gate

- [ ] Human engineer confirmed coverage is sufficient
- [ ] Sign-off recorded with name and date
- [ ] QA handoff prepared per [qa-engineer/prompts/handoff.md](../agents/qa-engineer/prompts/handoff.md) (Phase 1)

---

## Common Failures and Recovery

| Failure | Signal | Recovery |
|---------|--------|----------|
| **Happy path only** | No negative or auth tests in spec | Add failure mode and unauthorized cases per [standards/testing.md](../standards/testing.md). Re-submit for human sign-off. |
| **Untestable criteria accepted** | Criteria still subjective ("user-friendly", "fast") | Block Stage 4. Return to Stage 1 to rewrite criteria with measurable targets. |
| **Tests tied to implementation** | Spec asserts internal class names or private methods | Rewrite tests to assert behavior and API contracts. Tests must survive refactoring. |
| **Contract drift** | Expected responses do not match OpenAPI | Align test spec with contract or escalate to Stage 2 for contract amendment. |
| **Implementation started early** | Code written before test spec approval | Pause implementation. Complete test spec and obtain sign-off. Retrofit spec from code only as last resort - risks gaps. |
| **E2E overreach** | E2E planned for every minor change | Scope E2E to critical workflows. Use unit/integration for the rest. |
| **Missing traceability** | Orphan test cases or uncovered acceptance criteria | Complete traceability matrix. Every criterion and every test case must link. |

---

## Handoff to Stage 4

When exit criteria are met, pass to [Stage 4 - Implementation](stage-04-implementation.md) with:

1. Signed test specification link
2. Traceability matrix
3. System boundaries and mock strategy
4. QA Phase 1 handoff (Status: Complete, Recommendation: Proceed)

**Phase 2 (test implementation) runs during Stage 4 - tests are written alongside feature code.**
