
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
