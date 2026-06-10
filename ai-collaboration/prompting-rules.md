# Prompting Rules

How engineers interact with AI agents in this system.

## Be Specific About Context

Before asking an agent to implement something, provide relevant existing code. An agent that cannot see the codebase cannot align with it.

Use [context-packing-guide.md](context-packing-guide.md).

## Ask for Reasoning, Not Just Output

When an agent proposes a solution, ask for tradeoffs. Understanding reasoning is as important as output.

## Challenge Outputs You Do Not Understand

If you cannot fully explain agent-generated code, do not merge. Ask the agent to explain every line until the implementation is fully understood.

## One Concern Per Prompt

A prompt asking for implementation, documentation, and testing simultaneously produces mediocre results. Separate concerns.

## Use Enterprise Prompts

Always attach the role or workflow prompt from `agents/` or `workflows/prompts/` plus [global-system-prompt.md](../prompts/global-system-prompt.md).

## Human Checkpoints

Agents do not sign off, merge, or deploy. Complete [human-review-checklist.md](human-review-checklist.md) before accepting output.
