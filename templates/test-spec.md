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
