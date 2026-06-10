# Stage 7 - Documentation

Update public developer documentation after QA verification.

## Position in Flow

| | |
|---|---|
| **Previous** | [Stage 6 - QA Verification](stage-06-qa-verification.md) |
| **Next** | [Stage 8 - Production Deployment](stage-08-production-deployment.md) |
| **Prompt** | [workflows/prompts/stage-07-documentation.md](prompts/stage-07-documentation.md) |
| **Agent** | [devrel-engineer](../agents/devrel-engineer/role.md) |

---

## Input

- QA-verified implementation merged or ready to merge on the PR branch
- Feature spec, OpenAPI spec, and release diff
- Existing API reference, guides, and changelog for affected surfaces
- QA report with known edge cases and error behaviors

---

## Output

- Updated API reference, integration guides, and changelog entries
- Runnable code samples with verification log entries
- Completed [doc-quality checklist](../agents/devrel-engineer/checklists/doc-quality.md)
- Gap list for any live behavior that differs from the contract

---

## Process

### 1. Inventory changes

1. Read the PR diff, OpenAPI spec, and feature spec.
2. List every public surface that changed: endpoints, webhooks, SDK methods, CLI commands, error codes.
3. List every documentation file that must be updated.

### 2. Write and verify documentation

1. Invoke the DevRel Engineer agent with [stage-07-documentation prompt](prompts/stage-07-documentation.md).
2. **Execute** the API or SDK - do not write from the spec alone.
3. Draft guides using [developer-guide template](../agents/devrel-engineer/templates/developer-guide.md).
4. Update changelog with specific per-change descriptions - no vague entries.
5. Review new and changed error messages - each must include recovery guidance.
6. Run every code sample; record environment, date, and pass/fail in the verification log.

### 3. Quality gate

1. Complete [doc-quality checklist](../agents/devrel-engineer/checklists/doc-quality.md).
2. Flag blocking inaccuracies that require engineering fixes before publication.
3. Cross-check against `standards/api.md` and relevant ADRs.

### 4. Human review

1. Request review from one engineer familiar with the feature.
2. Address feedback; do not merge documentation without human approval.

---

## Human Checkpoint

| Role | Decision |
|------|----------|
| Engineer (human) | Documentation approved for merge |

**Hard stops:**

- No samples published without execution against a real environment
- No contradictions with OpenAPI, ADRs, or live behavior without escalation
- Breaking changes require migration steps and deprecation timeline

---

## Exit Criteria

- [ ] Every new public surface documented
- [ ] All code samples executed and logged
- [ ] Changelog updated with specific entries
- [ ] Error messages reviewed for actionability
- [ ] `checklists/doc-quality.md` complete
- [ ] Human engineer documentation review complete

---

## Escalation

| Situation | Action |
|-----------|--------|
| Live API differs from contract | Escalate to implementing engineer before publishing |
| Internal endpoint needs public docs | Require explicit product approval |
| Error message lacks recovery path | Escalate for engineering fix or document workaround |

---

## Related

