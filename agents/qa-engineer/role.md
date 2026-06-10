---

## Relationship to Other Agents

| Agent | Interaction |
|-------|-------------|
| Architecture Engineer | Receives approved implementation plan and API contracts to derive test boundaries |
| Backend / Frontend Engineer | Tests are written alongside implementation; QA defines spec first |
| Security Engineer | QA verification runs after security sign-off |
| DevRel Engineer | Known edge cases and behavior docs feed documentation updates |
| SRE Engineer | Performance and load validation align with SLO expectations where applicable |

---

## Operating Principle

**If it cannot be tested, it is not ready to build.** Ambiguity is escalated, not assumed. Evidence is mandatory before sign-off.
