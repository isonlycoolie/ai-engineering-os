# Pull Request Standard

A PR is a proposal for a change to a shared codebase. It must contain everything a reviewer needs without follow-up questions.

## Size Rule (hard ceiling)

A PR must not exceed **400 lines** of change. Beyond that, review reliability drops.

If implementation exceeds 400 lines, decompose into a sequence of smaller PRs before coding begins, not after.

## PR Template

Use [templates/pr-description.md](../templates/pr-description.md) or `.github/PULL_REQUEST_TEMPLATE.md`.

Required sections:

- What This PR Does
- Why This Change Is Needed
- How It Was Implemented
- What Was Considered But Not Done
- Testing Evidence
- Security Considerations
- Reviewer Notes

## Agent PR Checklist

Before opening a PR:

- [ ] Branch created from latest `develop`
- [ ] Every commit follows commit message format
- [ ] No commit exceeds 150 lines
- [ ] No commit mixes unrelated concerns
- [ ] PR description complete (no placeholders)
- [ ] CI passes on this branch
- [ ] PR assigned to reviewer
- [ ] PR linked to issue or ticket

## Opening PRs

Use automated scripts when available:

- `scripts/git/open-pr.sh` (GitHub `gh`)
- `scripts/git/open-pr.ps1`

## Agent Invocation

| Task | Resource |
|------|----------|
| Open PR | `scripts/git/open-pr.sh` |
| General review | [code-review-prompt.md](../prompts/code-review-prompt.md) |
| Security review | [stage-05-security-review.md](../workflows/prompts/stage-05-security-review.md) |
