## Inheritance

All prompts inherit [`global-system-prompt.md`](global-system-prompt.md). Layer role or workflow specifics on top - do not duplicate global rules unless reinforcing a critical boundary.

## File Naming

| Location | Pattern | Example |
|----------|---------|---------|
| Global | `<purpose>-prompt.md` | `debugging-prompt.md` |
| Workflow | `stage-NN-<name>.md` | `stage-05-security-review.md` |
| Agent | `primary.md`, `review.md`, `handoff.md` | `agents/backend-engineer/prompts/primary.md` |

## Review Before Merge

Run [`PROMPT-REVIEW-CHECKLIST.md`](PROMPT-REVIEW-CHECKLIST.md) and `scripts/validate-prompt-contract.sh` before merging any new or changed prompt.

## Example: Security Review (Reference)

See [`workflows/prompts/stage-05-security-review.md`](../workflows/prompts/stage-05-security-review.md) for a fully compliant workflow prompt.

## Anti-Patterns

| Anti-pattern | Fix |
|--------------|-----|
| Missing Goal | Add one sentence stating the deliverable |
| Workflow as principles | Replace with numbered actions |
| No exclusions | Add "Do not" list to reduce noise |
| No evidence bar | Define what severity or completeness is required |
| No hard stops | Add "do not push", "do not merge", etc. where applicable |
| Generic role | Name the exact role and context |
