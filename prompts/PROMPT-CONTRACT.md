# Enterprise Prompt Contract

Every prompt in the AI Engineering OS must follow this contract. Consistency is what makes the framework auditable, teachable, and enterprise-grade.

## Why This Exists

A prompt is not a suggestion. It is an **operating instruction** with a defined outcome, evidence bar, and hard boundaries. Agents that receive ambiguous prompts produce ambiguous output. This contract eliminates that failure mode.

## Canonical Structure

Every prompt file must contain these sections in order:

```markdown
You are a [role] working on the repository and task described in the project context below.
Apply the role constraints, standards, and checklists provided in context.
Treat the open workspace as the source of truth for code, conventions, and file paths.

## Project context
[Developer provides: repo, paths, stack, ticket, acceptance criteria, files in scope]

## Goal
[Single measurable outcome: what "done" looks like]

## Scope
[What is in/out of scope for this run]

## Workflow
1. [Ordered steps the agent must follow]
2. [...]

## What to look for
Prioritize:
- [High-signal checks]

Do not:
- [Exclusions]

## Evidence bar
[What counts as a valid finding, deliverable, or sign-off]

## Response rules
- [Output format, escalation, handoff]
- [Hard stops]

## Constraints
[Non-negotiable boundaries from role limitations]
```

## Section Definitions

### Role declaration (opening line)

State who the agent is and the context. Be specific:

- Good: `You are a security reviewer for pull requests.`
- Bad: `You are a helpful assistant.`

### Goal

One paragraph. Answer: **What does success look like when this prompt finishes?**

Must be measurable or verifiable. Avoid vague goals like "help the user" or "improve the code."

### Scope

Explicit boundaries. State what files, systems, or time horizons are included and excluded.

Example exclusions:
- "Review only added or modified code unless unchanged code is required to prove exploitability."
- "Do not refactor unrelated modules."

### Workflow

Numbered steps executed in order. Each step is an action, not a principle.

- Good: `1. Read the PR diff and list all modified files.`
- Bad: `1. Be thorough.`

### What to look for

Split into **Prioritize** (high-signal) and **Do not** (false positives, out-of-scope).

Align with the role. Security prompts prioritize attack paths; QA prompts prioritize untested acceptance criteria.

### Evidence bar

Define what counts as a valid output:

- Security: medium+ severity with attacker-controlled input traced to sink
- Architecture: ADR with alternatives and consequences
- Implementation: tests passing + checklist complete

### Response rules

Output format, where to post comments, what to hand off, and **hard stops** (e.g., "Do not push changes").

### Constraints

Pull from `agents/<role>/limitations.md`. Repeat the non-negotiables so the agent cannot miss them.

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
