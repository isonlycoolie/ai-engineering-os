# Branch Protection

Configure in the platform UI. Document here so every new repository is consistent.

## GitHub (`main` and `develop`)

Settings → Branches → Branch protection rules

For both `main` and `develop`:

- Require a pull request before merging
- Require approvals: 1 (develop), 2 (main)
- Dismiss stale approvals when new commits are pushed
- Require status checks: lint, test, build, security, commit-discipline, pr-size
- Require branches up to date before merging
- Require conversation resolution before merging
- Include administrators
- **Never** allow force pushes
- **Never** allow deletions on main

## GitLab

Settings → Repository → Protected Branches

**main:** merge Maintainers only; push no one; code owner approval required.

**develop:** merge Developers + Maintainers; push no one; require passing pipeline.

## Bitbucket

Repository settings → Branch permissions

**main:** write Administrators only; minimum 2 approvals; successful builds; all checks passed.

**develop:** write Administrators only; minimum 1 approval; successful build required.

## Agent Invocation

[agents/shared/git-workflow-instructions.md](../agents/shared/git-workflow-instructions.md)
