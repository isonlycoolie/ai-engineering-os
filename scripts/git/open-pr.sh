#!/usr/bin/env bash
# open-pr.sh - Create a pull request with standard template
# Usage: ./scripts/git/open-pr.sh "feat(auth): add refresh token rotation" "AUTH-42" "develop"
set -euo pipefail

TITLE="${1:?PR title is required}"
TICKET="${2:?Ticket ID is required}"
BASE_BRANCH="${3:-develop}"
CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"

echo "Opening PR: $TITLE"
echo "From: $CURRENT_BRANCH -> $BASE_BRANCH"

git push origin "$CURRENT_BRANCH"

gh pr create \
  --title "$TITLE" \
  --base "$BASE_BRANCH" \
  --head "$CURRENT_BRANCH" \
  --body "$(cat <<EOF
## What This PR Does

<!-- Filled in by the implementing engineer or agent -->

## Why This Change Is Needed

Closes: #$TICKET

## How It Was Implemented

<!-- Brief approach and significant decisions -->

## What Was Considered But Not Done

<!-- Deferred work or known limitations -->

## Testing Evidence

- [ ] Unit tests written and passing
- [ ] Integration tests written and passing
- [ ] No existing tests broken
- [ ] Pre-delivery checklist completed

## Security Considerations

<!-- Auth, data storage, or external integrations? -->

## Reviewer Notes

<!-- Focus areas for reviewers -->
EOF
)" \
  --assignee "@me" \
  --label "needs-review" 2>/dev/null || gh pr create \
  --title "$TITLE" \
  --base "$BASE_BRANCH" \
  --head "$CURRENT_BRANCH" \
  --body-file - <<EOF
## What This PR Does

## Why This Change Is Needed

Closes: #$TICKET

## Testing Evidence

- [ ] Unit tests written and passing
- [ ] Integration tests written and passing
- [ ] No existing tests broken
- [ ] Pre-delivery checklist completed

## Security Considerations

## Reviewer Notes
EOF

echo "PR created. CI pipeline should start automatically."
