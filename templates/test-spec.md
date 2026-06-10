# Test Specification: [Feature Title]

| Field | Value |
|-------|-------|
| **Feature ID** | FEAT-NNN |
| **Feature spec** | [link to feature-spec.md] |
| **Author** | |
| **Created** | YYYY-MM-DD |
| **Status** | Draft / Approved |
| **Approved by** | (human name, date - required before Stage 4) |
| **Phase** | Phase 1 - Test Specification |

---

## Scope

**In scope:**

-

**Out of scope:**

-

**System boundaries:**

| Layer | Under test | Mocked / stubbed |
|-------|------------|------------------|
| API | | |
| Database | | |
| External services | | |

---

## Traceability Matrix

| Req ID | Acceptance criterion | Test case IDs | Type |
|--------|---------------------|---------------|------|
| REQ-001 | AC-001 | TC-001 | Unit / Integration / E2E |
| REQ-001 | AC-002 | TC-002, TC-003 | |
| REQ-002 | AC-003 | TC-004 | |

**Coverage:** ___ / ___ acceptance criteria mapped

---

## Test Cases

### TC-001: [Short title]

| Field | Value |
|-------|-------|
| **Maps to** | REQ-001 / AC-001 |
| **Type** | Unit / Integration / E2E |
| **Priority** | Critical / High / Medium |

**Preconditions:**

-

**Steps:**

1.
2.

**Expected result:**

-

**Pass criteria:** Observable, unambiguous outcome.

---

### TC-002: [Short title]

| Field | Value |
|-------|-------|
| **Maps to** | REQ-001 / AC-002 |
| **Type** | |
| **Priority** | |

**Preconditions:**

-

**Steps:**

1.

**Expected result:**

-

---

## Edge Cases and Failure Modes

Minimum three edge cases per feature.

| ID | Scenario | Expected behavior | Test case |
|----|----------|-------------------|-----------|
| EC-001 | Invalid input | 400 with standard error envelope | TC-00X |
| EC-002 | Unauthorized access | 401/403 per contract | TC-00X |
| EC-003 | Downstream failure | Graceful degradation / retry | TC-00X |

---

## Authorization Tests

| Resource / action | Authorized actor | Unauthorized actor | Test case |
|-------------------|------------------|--------------------|-----------|
| | | | TC-00X |

---

## Performance and Load (if applicable)

| Scenario | Target | Test approach |
|----------|--------|---------------|
| | | |

---

## Test Data and Fixtures

| Fixture | Description | Location |
|---------|-------------|----------|
| | | |

---

## CI Requirements

- [ ] All new tests run in CI pipeline: `[pipeline name]`
- [ ] No flaky tests introduced
- [ ] Coverage must not decrease vs. baseline

---

## Untestable or Ambiguous Requirements

| Req ID | Issue | Escalation |
|--------|-------|------------|
| | | |

---

## Human Sign-Off

| Role | Name | Date | Decision |
|------|------|------|----------|
| QA Engineer (agent) | | | Submitted |
| Engineering lead | | | Approved for implementation |

---

*Generated from AI Engineering OS - Test specification template v1.0*
