
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
