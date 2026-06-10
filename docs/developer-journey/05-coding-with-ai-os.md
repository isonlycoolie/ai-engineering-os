# 05: Coding with the AI-OS

Best practices for writing excellent code while using AI agents. This is the discipline that separates fast output from correct output.

## The Core Rule

**You own every line that merges.** The AI is an acceleration layer, not a decision-maker.

Before merge, complete [human-review-checklist.md](../../ai-collaboration/human-review-checklist.md).

## Project First

1. Open **your project** in the IDE (not only this OS repo).
2. Fill [project context](../../templates/project-context.md) every session.
3. Attach global system prompt + role prompt.
4. Attach files from your project's source tree.

See [adopt-in-your-project.md](../adopt-in-your-project.md).

## Context Packing

Never ask an agent to implement blind. Attach per [context-packing-guide.md](../../ai-collaboration/context-packing-guide.md):

| Task | Minimum context |
|------|-----------------|
| Every session | **Project context** (repo, paths, ticket) |
| New feature | Feature spec, ADR, test spec, related files |
| Bug fix | Error logs, stack trace, failing test, affected module |
| Refactor | Target files, callers, test suite status |
| Review | Full PR diff, linked issue, standards links |

## One Concern Per Prompt

Split sessions:

| Session | Prompt |
|---------|--------|
| Clarify requirements | ambiguity-resolution |
| Design | architecture / stage-02 |
| Implement backend | backend-engineer primary |
| Implement frontend | frontend-engineer primary |
| Write tests | qa-engineer primary |
| Review | code-review or stage-05-security |

A single prompt asking for implementation + docs + tests produces mediocre results across all three.

## The Implementation Loop

```
1. Read spec + ADR + existing code (you and the agent)
2. List files to touch
3. Implement smallest vertical slice
4. Run tests
5. Complete pre-delivery checklist
6. Human review every line
7. Open PR → security → QA
```

Prompt: [workflows/prompts/stage-04-implementation.md](../../workflows/prompts/stage-04-implementation.md)

## Red Flags - Stop and Escalate

- Agent output you cannot explain line by line
- New dependency without ADR
- Auth or crypto implemented from scratch
- Tests deleted or skipped to pass CI
- `any` types, silent catch blocks, or removed error handling
- Agent confident about API versions or configs you did not provide

See [hallucination-prevention.md](../../ai-collaboration/hallucination-prevention.md).

## Prompt Quality

Bad: "Add user auth"

Good: "Implement JWT refresh rotation per ADR-003 and standards/security.md. Touch only `src/auth/`. Acceptance criteria: [paste]. Existing pattern: [paste file]."

See [prompt-anti-patterns.md](../../ai-collaboration/prompt-anti-patterns.md).

## Ask for Reasoning

When the agent proposes a solution, ask:

- What alternatives did you consider?
- What is the blast radius?
- What breaks if this external call fails?
- Which checklist items does this satisfy?

## Coding Standards by Layer

| Layer | Document |
|-------|----------|
| Backend | [agents/backend-engineer/coding-standards.md](../../agents/backend-engineer/coding-standards.md) |
| Frontend | [agents/frontend-engineer/architecture-rules.md](../../agents/frontend-engineer/architecture-rules.md) |
| API | [standards/api.md](../../standards/api.md) |
| Security | [standards/security.md](../../standards/security.md) |
| Tests | [standards/testing.md](../../standards/testing.md) |

## After AI Writes Code

