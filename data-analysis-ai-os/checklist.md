# Checklist

# Analysis Pre-Release Checklist

Complete every item before attaching the Analysis report and recommending release. Attach evidence (CI run link, coverage artifact, test names) for each checked item.

**Feature:** _______________  
**PR:** _______________  
**Reviewer:** _______________  
**Date:** _______________

---

## Specification and Traceability

- [ ] All acceptance criteria from the specification have corresponding test cases
- [ ] Traceability matrix is complete (requirement ID → test case ID)
- [ ] No acceptance criterion remains untested or marked "manual only" without human exception
- [ ] Known ambiguous requirements were escalated and resolved before sign-off

---

## Test Coverage

- [ ] Happy path is covered with passing automated tests
- [ ] At least three edge cases are covered per feature
- [ ] Failure modes are covered (invalid input, downstream errors, timeouts where applicable)
- [ ] Authentication and authorization rules are tested with both authorized and unauthorized requests
- [ ] Error responses match the documented API contract (envelope, codes, messages)
- [ ] Critical user-facing workflows have E2E coverage where specified

---

## Test Quality

- [ ] Tests assert behavior and contracts, not unnecessary implementation details
- [ ] No skipped, ignored, or commented-out failing tests in the suite
- [ ] No `.only` or debug flags left in committed test code
- [ ] Flaky tests are documented with ticket, owner, and mitigation plan - or fixed
- [ ] Test fixtures do not contain production secrets, PII, or real credentials

---

## CI and Coverage

- [ ] All tests pass in the CI pipeline - not just locally
- [ ] Full test suite was executed (not a subset) for this release verification
- [ ] Test coverage has not decreased from the previous release
- [ ] Any coverage decrease has documented human approval and justification
- [ ] Performance under expected load has been validated where requirements specify measurable targets

---

## Process and Dependencies

- [ ] Phase 1 test specification was human-approved before implementation
- [ ] Phase 2 tests were written alongside implementation
- [ ] Security review sign-off is complete before this checklist
- [ ] Analysis report is written using [`templates/qa-report.md`](../templates/qa-report.md)
- [ ] Analysis report is attached to the pull request

---

## Documentation

- [ ] Known edge cases and expected behavior are documented in the Analysis report
- [ ] Accepted risks or deferred test gaps are explicitly listed with owner and follow-up ticket
- [ ] Regression scope is documented (what was re-run and what was excluded)

---

## Sign-Off

| Role | Name | Date | Decision |
|------|------|------|----------|
| Analysis Engineer (agent) | | | Pass / Fail recommendation |
| Analysis Engineer (human) | | | Release approved / Changes required |

**Notes:**

---

*Incomplete checklists block release recommendation. Waivers require documented human exception.*

## Analysis-specific

- [ ] Question and metrics defined in writing
- [ ] Sanity checks recorded with numbers
- [ ] Limitations stated prominently
- [ ] Reproducible artifact saved with data window
- [ ] Peer review for high-stakes outputs
