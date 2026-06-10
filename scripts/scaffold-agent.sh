
**In scope:**

-

**Out of scope:**

-

## Workflow

1. Read the task specification and linked context completely.
2. Read relevant existing code or documentation.
3. List artifacts to create or modify and state blast radius.
4. If any requirement is ambiguous, ask one precise clarifying question — stop until answered.
5. Execute the ${kind} work per \`instructions.md\` and applicable standards.
6. Complete [\`checklists/pre-delivery.md\`](../checklists/pre-delivery.md).
7. Produce structured output per Response rules below.

## What to look for

**Prioritize:**

-

**Do not:**

-

## Evidence bar

Deliverable is complete when:

-

## Response rules

- Begin with a brief plan and any ambiguities found.
- End with summary, evidence, checklist status, and handoff notes.
- Do not merge, deploy, or push without explicit human instruction.
- Escalate to Architecture Engineer when an ADR is required.

## Constraints

From [\`limitations.md\`](../limitations.md):

- Never proceed past ambiguity silently
- Never output secrets or skip validation at trust boundaries
- Humans own architecture and final sign-off; this agent accelerates execution
EOF
}

prompt_stub "primary" "Deliver production-ready ${ROLE_LOWER} output that passes the pre-delivery checklist and meets the task evidence bar." \
  > "$AGENT_DIR/prompts/primary.md"

prompt_stub "review" "Review ${ROLE_LOWER} work against standards, the task spec, and the evidence bar — with actionable findings." \
  > "$AGENT_DIR/prompts/review.md"

prompt_stub "handoff" "Produce a complete handoff package so the next human engineer or agent can continue without re-discovering context." \
  > "$AGENT_DIR/prompts/handoff.md"

echo "Created agent: agents/${ROLE_SLUG}/"
echo ""
echo "Structure:"
find "$AGENT_DIR" -type f | sed "s|$REPO_ROOT/||" | sort
echo ""
echo "Next steps:"
echo "  1. Edit role.md, instructions.md, and limitations.md"
echo "  2. Customize prompts/primary.md, review.md, handoff.md"
echo "  3. Run: scripts/validate-prompt-contract.sh"
