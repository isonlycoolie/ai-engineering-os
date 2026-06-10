# Stage 4 - Implementation

Deliver production-ready code and executable tests on a `feature/*` branch, aligned to approved spec, contract, and test specification.

**Previous stage:** [Stage 3 - Test Specification](stage-03-test-specification.md)  
**Next stage:** [Stage 5 - Security Review](stage-05-security-review.md)

---

## Input / Output / Human Checkpoint

| | |
|---|---|
| **Input** | Human-approved test specification, implementation plan, API contract, and feature specification |
| **Output** | Implementation with tests on `feature/*` branch, ready for PR |
| **Human checkpoint** | Engineer reviews every line before opening pull request |

---

## Agents Involved

| Agent | Role in this stage |
|-------|-------------------|
| [Backend Engineer](../agents/backend-engineer/role.md) | Server-side APIs, services, persistence, migrations |
| [Frontend Engineer](../agents/frontend-engineer/role.md) | UI, hooks, client state, accessibility, E2E when scoped |
| [QA Engineer](../agents/qa-engineer/role.md) | Phase 2 - implements tests alongside feature code (coordinate, do not skip spec) |

Supporting references:

- [backend-engineer/prompts/primary.md](../agents/backend-engineer/prompts/primary.md)
- [frontend-engineer/prompts/primary.md](../agents/frontend-engineer/prompts/primary.md)
- [qa-engineer/prompts/primary.md](../agents/qa-engineer/prompts/primary.md)
- [docs/developer-journey/05-coding-with-ai-os.md](../docs/developer-journey/05-coding-with-ai-os.md)

---

## Prompt to Run

Attach approved spec, ADR, API contract, test spec, and relevant source files, then invoke:

**[workflows/prompts/stage-04-implementation.md](prompts/stage-04-implementation.md)**

For split sessions (recommended), also use role-specific prompts:

- Backend: [agents/backend-engineer/prompts/primary.md](../agents/backend-engineer/prompts/primary.md)
- Frontend: [agents/frontend-engineer/prompts/primary.md](../agents/frontend-engineer/prompts/primary.md)
- Tests: [agents/qa-engineer/prompts/primary.md](../agents/qa-engineer/prompts/primary.md)

Also attach:

- [prompts/global-system-prompt.md](../prompts/global-system-prompt.md)
- [ai-collaboration/context-packing-guide.md](../ai-collaboration/context-packing-guide.md)

---

## Files to Produce

| Artifact | Location | Owner |
|----------|----------|-------|
| Feature code | `feature/*` branch - per project layout | Backend / Frontend Engineer |
| Database migrations | Project migrations directory | Backend Engineer |
| OpenAPI updates | Project API spec path | Backend Engineer |
| Unit and integration tests | `tests/` or project convention | Backend / QA Engineer |
| E2E tests | Project E2E directory (critical workflows only) | Frontend / QA Engineer |
| Implementation summary | Per agent template | Backend / Frontend Engineer |
| Pre-delivery checklist | Completed checklist in PR or summary | Implementing engineer |

Templates and checklists:

- [agents/backend-engineer/templates/implementation-summary.md](../agents/backend-engineer/templates/implementation-summary.md)
- [agents/frontend-engineer/templates/implementation-summary.md](../agents/frontend-engineer/templates/implementation-summary.md)
- [agents/backend-engineer/checklists/pre-delivery.md](../agents/backend-engineer/checklists/pre-delivery.md)
- [agents/frontend-engineer/checklists/pre-delivery.md](../agents/frontend-engineer/checklists/pre-delivery.md)

---

## Exit Criteria Checklist

### Preconditions

- [ ] Stage 3 test specification human-approved - Phase 2 may proceed
- [ ] ADR(s) Accepted by human for any structural change in scope
- [ ] API contract and implementation plan available

### Implementation quality

- [ ] Codebase read first - changes follow existing patterns
- [ ] Blast radius documented (files and services affected)
- [ ] Business logic in correct layer (service, not controller/route handler)
- [ ] All inputs validated at trust boundaries
- [ ] Auth enforced; authorization in service layer (backend)
- [ ] No hardcoded secrets or environment-specific values in source

### Tests (Phase 2)

- [ ] Tests written alongside implementation - not deferred to Stage 6 only
- [ ] Happy path + at least two failure modes per new public endpoint or critical workflow
- [ ] Tests assert behavior and contracts - not implementation internals
- [ ] Full test suite passes locally
- [ ] Traceability matrix satisfied - each test maps to spec test case IDs

### Documentation and contract

- [ ] OpenAPI updated for new or changed public endpoints
- [ ] Error responses follow [standards/api.md](../standards/api.md) envelope
- [ ] New environment variables documented in `.env.example`

### Checklists and handoff

- [ ] Applicable pre-delivery checklist completed (backend and/or frontend)
- [ ] Implementation summary produced with rollback plan for schema/contract changes
- [ ] Open questions and items requiring human decision listed explicitly

### Human gate

- [ ] Human engineer reviewed every line - can explain each change
- [ ] [human-review-checklist.md](../ai-collaboration/human-review-checklist.md) completed
- [ ] PR opened on `feature/*` branch - **not merged** (Stage 5 follows)

---

## Common Failures and Recovery

| Failure | Signal | Recovery |
|---------|--------|----------|
| **Blind implementation** | Agent did not read existing code; patterns diverge | Stop. Re-run with context-packing guide. Refactor to match codebase conventions. |
| **Structural change without ADR** | New DB, service, or dependency in PR | Halt PR. Return to Stage 2. Write ADR, get acceptance, then resume. |
| **Tests deleted or weakened** | Skipped or removed tests to pass CI | Restore tests. Fix implementation or escalate spec gap. Never green by deletion. |
| **Contract drift** | Implementation responses differ from OpenAPI | Update OpenAPI or fix code - they must match before PR. |
| **Missing failure mode tests** | Only happy path covered | Add tests per test spec and [standards/testing.md](../standards/testing.md). |
| **Unexplained agent output** | Reviewer cannot explain a line | Rewrite or remove. Do not merge code you do not understand. |
| **Scope creep** | PR includes unrelated refactors or features | Split PR. Keep feature branch focused on approved spec only. |
| **Auth/crypto from scratch** | Custom JWT, crypto, or auth bypass | Stop. Use project-standard patterns. Escalate to Security Engineer if pattern missing. |

---

## Handoff to Stage 5

When exit criteria are met, open PR and proceed to [Stage 5 - Security Review](stage-05-security-review.md) with:

1. PR link on `feature/*` branch
2. Implementation summary
3. Completed pre-delivery checklist(s)
4. Test evidence - local and CI passing
5. Traceability to test specification

**Do not merge until Stages 5 and 6 complete.**
