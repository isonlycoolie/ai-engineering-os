# QA Engineer - Anti-Patterns

The following patterns are explicitly banned. If a workflow or test suite exhibits any of these, the agent must flag it and propose a corrective alternative before sign-off.

---

## Specification Anti-Patterns

| Anti-pattern | Why it fails | Correct approach |
|--------------|--------------|------------------|
| **Testing after implementation only** | Defects and ambiguity discovered too late; rework cost is high | Phase 1 test spec before any implementation |
| **Vague acceptance criteria** ("works correctly", "is user-friendly") | No objective pass/fail; disputes at release | Rewrite criteria in observable, testable terms |
| **Missing traceability** | Cannot prove a requirement was verified | Maintain requirement → test case matrix |
| **Spec by example only** | Edge cases and failures are ignored | Explicit edge case and failure mode sections |

---

## Test Design Anti-Patterns

| Anti-pattern | Why it fails | Correct approach |
|--------------|--------------|------------------|
| **Testing implementation, not behavior** | Refactoring breaks tests; false confidence | Assert on outputs, contracts, and side effects |
| **Happy path only** | Production failures occur at boundaries | Minimum three edge cases per feature |
| **Shared mutable test state** | Order-dependent flaky failures | Isolated fixtures; parallel-safe setup/teardown |
| **Hard-coded sleeps** | Slow, flaky, non-deterministic | Wait for conditions, use retry with timeout |
| **Over-mocking** | Tests pass while integration fails | Integration tests at real boundaries |
| **Under-mocking in unit tests** | Unit tests are slow and brittle | Mock external I/O; test logic in isolation |

---

## Suite Integrity Anti-Patterns

| Anti-pattern | Why it fails | Correct approach |
|--------------|--------------|------------------|
| **Deleting failing tests** | Hides defects; erodes trust in CI | Fix implementation or escalate spec change |
| **`.skip` / `.only` left in main** | Incomplete coverage in CI | Remove before merge; block in CI |
| **Ignored flaky tests** | Known defects ship to production | Fix or quarantine with ticket and owner |
| **Local-only green** | CI failures discovered at merge | All tests pass in pipeline before sign-off |
| **Coverage gaming** | Meaningless assertions inflate metrics | Test behavior that matters; review diff |

---

## Authorization and Security Testing Gaps

| Anti-pattern | Why it fails | Correct approach |
|--------------|--------------|------------------|
| **Testing only as admin** | Authorization bugs reach production | Authorized and unauthorized cases per endpoint |
| **Missing negative auth tests** | Privilege escalation undetected | Test forbidden roles, expired tokens, missing scopes |
| **Secrets in test output** | Credential leakage in CI logs | Redact; use vault or ephemeral test credentials |

---

## Reporting Anti-Patterns

| Anti-pattern | Why it fails | Correct approach |
|--------------|--------------|------------------|
| **"All tests pass" without evidence** | Unverifiable claim | Link CI run, coverage report, checklist |
| **Rubber-stamp QA report** | Checklist theater; no real verification | Complete every pre-release item with proof |
| **Undocumented known issues** | Surprises in production | List edge cases and accepted risks explicitly |
| **QA report after merge** | Too late to block defects | Report attached before merge request approval |

---

## Process Anti-Patterns

| Anti-pattern | Why it fails | Correct approach |
|--------------|--------------|------------------|
| **QA as final gate only** | Shift-left value lost | Three-phase workflow: spec → implement → regression |
| **Manual-only regression** | Not repeatable; human error | Automate regression; manual for exploratory only |
| **Blocking on perfection** | No measurable bar | Use evidence bar in prompts and pre-release checklist |
| **QA owns requirements** | Wrong accountability | QA validates; product/engineering defines requirements |

---

## Detection Prompt

When reviewing a test suite or QA artifact, ask:

1. Can every acceptance criterion be traced to a passing test?
2. Would a refactor of internal structure break these tests unnecessarily?
3. Are failure modes and unauthorized access explicitly covered?
4. Is CI green, not just local?
5. Does the QA report cite evidence, not assertions?

If any answer is no, the anti-pattern is present - remediate before sign-off.
