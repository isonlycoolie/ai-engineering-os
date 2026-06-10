# Stage 1 - Requirement Clarity

Resolve ambiguities and produce testable acceptance criteria before any design or implementation work begins.

**Previous stage:** None (entry point)  
**Next stage:** [Stage 2 - Architecture Review](stage-02-architecture-review.md)

---

## Input / Output / Human Checkpoint

| | |
|---|---|
| **Input** | Feature request, task description, or product brief |
| **Output** | Approved feature specification with testable acceptance criteria |
| **Human checkpoint** | Engineer signs off on acceptance criteria and out-of-scope items |

---

## Agents Involved

| Agent | Role in this stage |
|-------|-------------------|
| [Architecture Engineer](../agents/architecture-engineer/role.md) | Primary - surfaces ambiguities, rewrites criteria, produces feature spec |

Supporting references:

- [architecture-engineer/prompts/primary.md](../agents/architecture-engineer/prompts/primary.md)
- [architecture-engineer/prompts/handoff.md](../agents/architecture-engineer/prompts/handoff.md)
- [prompts/ambiguity-resolution-prompt.md](../prompts/ambiguity-resolution-prompt.md) (optional deep-dive)

---

## Prompt to Run

Attach context (feature request, related tickets, prior specs) and invoke:

**[workflows/prompts/stage-01-requirement-clarity.md](prompts/stage-01-requirement-clarity.md)**

Also attach:

- [prompts/global-system-prompt.md](../prompts/global-system-prompt.md)
- [ai-collaboration/context-packing-guide.md](../ai-collaboration/context-packing-guide.md) (minimum context rules)

---

## Files to Produce

| Artifact | Location | Owner |
|----------|----------|-------|
| Feature specification | `docs/features/<feature-name>/feature-spec.md` or PR description | Architecture Engineer (agent) + human |
| Ambiguity log | Section inside feature spec or linked issue comments | Architecture Engineer (agent) |
| Out-of-scope list | Section inside feature spec | Architecture Engineer (agent) |
| Human sign-off record | PR comment, ticket, or spec header (`Approved by:`, date) | Human engineer |

Use [`templates/feature-spec.md`](../templates/feature-spec.md) as the output scaffold when available.

---

## Exit Criteria Checklist

Complete every item before advancing to Stage 2.

### Requirement completeness

- [ ] Full requirement read - no partial interpretation
- [ ] Stated goals, constraints, and assumptions extracted
- [ ] Non-functional requirements identified (latency, scale, availability, retention, compliance)
- [ ] Authorization rules defined (who can do what, on which resources)

### Ambiguity resolution

- [ ] Every ambiguous term listed with proposed resolution or clarifying question
- [ ] No compound clarifying questions - one question per gap
- [ ] Requirements that cannot be tested flagged for rewrite
- [ ] No open ambiguities remain without explicit human decision

### Acceptance criteria

- [ ] Acceptance criteria written in Given/When/Then or numbered checklist format
- [ ] Each criterion is observable and pass/fail testable
- [ ] Confirmed requirements separated from pending human decisions
- [ ] Explicit out-of-scope items documented

### Human gate

- [ ] Human engineer reviewed and signed off on acceptance criteria
- [ ] Sign-off recorded with name and date
- [ ] Architecture handoff prepared per [architecture-engineer/prompts/handoff.md](../agents/architecture-engineer/prompts/handoff.md)

---

## Common Failures and Recovery

| Failure | Signal | Recovery |
|---------|--------|----------|
| **Vague requirements accepted** | Criteria use words like "handle", "support", "improve" without measurable targets | Stop. Rewrite each criterion with observable expected behavior. Re-run Stage 1 prompt. |
| **Agent assumed missing behavior** | Spec contains "confirmed" items never stated in the original request | Revert assumed items to "pending human decision." Ask one question per gap. |
| **Implementation started early** | Code or ADR work began before sign-off | Halt implementation. Complete exit checklist. Do not merge partial work without approved spec. |
| **Security or data rules deferred** | Auth, PII handling, or retention marked "TBD" | Block Stage 2. Escalate to product owner or security liaison. These cannot be "figured out later." |
| **Scope creep in spec** | Spec grows beyond original request without approval | Move additions to a separate "future" section or new ticket. Re-sign off on in-scope criteria only. |
| **Untestable NFRs** | "Fast", "scalable", or "secure" without numeric or verifiable targets | Replace with measurable targets (e.g., p95 latency, RPS, retention days) or mark as out of scope for this release. |

---

## Handoff to Stage 2

When exit criteria are met, pass to [Stage 2 - Architecture Review](stage-02-architecture-review.md) with:

1. Signed feature specification link
2. Acceptance criteria checklist
3. Out-of-scope list
4. Open questions resolved or explicitly owned

**Do not proceed to architecture review with unresolved ambiguities.**
