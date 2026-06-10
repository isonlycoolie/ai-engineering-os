# Stage 6 - QA Verification

Regression verification and release-readiness sign-off after security clearance.

## Position in Flow

| | |
|---|---|
| **Previous** | [Stage 5 - Security Review](stage-05-security-review.md) |
| **Next** | [Stage 7 - Documentation](stage-07-documentation.md) |
| **Prompt** | [workflows/prompts/stage-06-qa-verification.md](prompts/stage-06-qa-verification.md) |
| **Agent** | [qa-engineer](../agents/qa-engineer/role.md) |

---

## Input

- Security-cleared implementation (PR with security sign-off)
- Approved test specification from Stage 3
- CI pipeline access and latest green run on the PR branch
- Traceability matrix (requirement ID → test case ID)

---

## Output

- Completed [QA report](../agents/qa-engineer/templates/qa-report.md) attached to PR
- Completed [pre-release checklist](../agents/qa-engineer/checklists/pre-release.md)
- Release recommendation: **pass** | **fail - changes required**
- Documented regression scope and any accepted risks with owners

---

## Process

### 1. Confirm prerequisites

1. Verify security review sign-off is recorded on the PR.
2. Confirm Phase 1 test specification was human-approved before implementation.
3. Read the feature spec acceptance criteria and traceability matrix.

### 2. Execute verification

1. Invoke the QA Engineer agent with [stage-06-qa-verification prompt](prompts/stage-06-qa-verification.md).
2. Run the **full test suite in CI** - not a local subset.
3. Confirm every acceptance criterion maps to a passing test case.
4. Re-run critical E2E workflows for user-facing changes.
5. Compare coverage to baseline - flag any decrease without documented exception.
6. Validate error responses against the documented API contract.

### 3. Document results

1. Record CI run link, test names, pass/fail counts, and coverage artifact.
2. List known edge cases and expected behavior in the QA report.
3. Document regression scope: what was executed and what was excluded (with justification).
4. Flag flaky tests with reproduction steps, owner, and mitigation ticket.

### 4. Complete checklist and sign-off

1. Complete [pre-release checklist](../agents/qa-engineer/checklists/pre-release.md).
2. Attach QA report to the PR.
3. Human QA engineer reviews and signs off on release readiness.

---

## Human Checkpoint

| Role | Decision |
|------|----------|
| QA Engineer (human) | Release approved or changes required |

**Hard stops:**

- Security review must be complete before this stage begins
- All tests must pass in CI - local-only green is insufficient
- Incomplete pre-release checklist blocks release recommendation

---

## Exit Criteria

- [ ] Full CI suite executed and green
- [ ] All acceptance criteria have passing test evidence
- [ ] Coverage has not decreased without documented human exception
- [ ] Auth rules tested with authorized and unauthorized requests
- [ ] QA report attached to PR
- [ ] Human QA sign-off recorded

---

## Escalation

| Situation | Action |
|-----------|--------|
| Failing test with ambiguous expected behavior | Escalate to implementing engineer and spec owner |
| CI environment unavailable for required tests | Escalate for contract-test or mock strategy approval |
| Coverage decrease | Document justification or block release |

---

## Related

- [standards/testing.md](../standards/testing.md)
- [templates/test-spec.md](../templates/test-spec.md)
- [03 - Feature Delivery](../docs/developer-journey/03-feature-delivery.md)
