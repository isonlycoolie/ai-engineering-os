# Prompt Review Checklist

Use this checklist before merging any prompt in `prompts/`, `agents/*/prompts/`, or `workflows/prompts/`.

## Structure

- [ ] Opens with a specific role declaration (not "helpful assistant")
- [ ] Contains `## Goal` with a measurable outcome
- [ ] Contains `## Scope` with in/out boundaries
- [ ] Contains `## Workflow` with numbered actionable steps
- [ ] Contains `## What to look for` with Prioritize and Do not subsections
- [ ] Contains `## Evidence bar` defining valid output
- [ ] Contains `## Response rules` with format and hard stops
- [ ] Contains `## Constraints` aligned with role limitations

## Quality

- [ ] Goal is single-purpose - not multiple unrelated outcomes
- [ ] Workflow steps are ordered and actionable
- [ ] Exclusions prevent speculative or out-of-scope findings
- [ ] Evidence bar matches the role (security vs docs vs implementation)
- [ ] Hard stops are explicit where automation could cause harm
- [ ] Inherits global rules from `global-system-prompt.md` without contradicting them

## Integration

- [ ] Linked from relevant workflow playbook or developer journey doc
- [ ] Referenced in agent `instructions.md` or `role.md` where applicable
- [ ] Passes `scripts/validate-prompt-contract.sh`

## Reviewer Sign-off

| Field | Value |
|-------|-------|
| Prompt path | |
| Reviewer | |
| Date | |
| Contract compliant | Yes / No |
