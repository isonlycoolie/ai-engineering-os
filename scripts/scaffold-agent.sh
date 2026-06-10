EOF

write_file "$AGENT_DIR/architecture-rules.md" <<EOF
# ${ROLE_TITLE} Agent — Architecture Rules

Structural constraints for this role. Escalate to Architecture Engineer when changes affect system topology.

-

EOF

write_file "$AGENT_DIR/anti-patterns.md" <<EOF
# ${ROLE_TITLE} Agent — Anti-Patterns

Explicitly banned patterns. Flag and propose alternatives before handoff.

| Anti-pattern | Why it is banned | Alternative |
|--------------|------------------|-------------|
| | | |
EOF

write_file "$AGENT_DIR/tradeoffs.md" <<EOF
# ${ROLE_TITLE} Agent — Tradeoff Guidance

Select options from explicit context — not preference. Default to the simplest option that satisfies the requirement.

| Decision | Option A | Option B | Guidance |
|----------|----------|----------|----------|
| | | | |
EOF

write_file "$AGENT_DIR/checklists/pre-delivery.md" <<EOF
# ${ROLE_TITLE} — Pre-Delivery Checklist

Complete before handoff to human review or the next agent.

## Scope and requirements

- [ ] Task specification and acceptance criteria read in full
- [ ] All in-scope requirements addressed or explicitly flagged as out of scope

## Quality

- [ ] Output aligns with \`standards/\` and role instructions
- [ ] Evidence bar from \`prompts/primary.md\` met

## Handoff

- [ ] Open questions and risks documented
- [ ] Recommended next step named (agent role or human)

---

| Role | Name | Date | Decision |
|------|------|------|----------|
| ${ROLE_TITLE} (agent) | | | Ready for review |
| Human reviewer | | | Approved / Changes required |
EOF

write_file "$AGENT_DIR/templates/deliverable.md" <<EOF
# ${ROLE_TITLE} Deliverable

| Field | Value |
|-------|-------|
| **Feature / task** | |
| **Author (agent run)** | ${ROLE_SLUG} |
| **Date** | YYYY-MM-DD |

## Summary

## Changes

## Evidence

## Open questions

## Handoff
EOF

ROLE_LOWER="$(echo "$ROLE_TITLE" | tr '[:upper:]' '[:lower:]')"

prompt_stub() {
  local kind="$1"
  local goal="$2"
  cat <<EOF
You are a ${ROLE_LOWER} working on the repository and task described in the project context below.
Apply the role constraints, standards, and checklists provided in context.
Treat the open workspace as the source of truth for code, conventions, and file paths.

Inherits [\`global-system-prompt.md\`](../../../prompts/global-system-prompt.md). Follow [\`instructions.md\`](../instructions.md) and [\`limitations.md\`](../limitations.md).

## Project context

[Developer provides: repo, paths, stack, ticket, acceptance criteria, files in scope]

## Goal

${goal}

## Scope

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
