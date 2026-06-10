# open-pr.ps1 - Create a pull request with standard template
param(
    [Parameter(Mandatory = $true)][string]$Title,
    [Parameter(Mandatory = $true)][string]$Ticket,
    [string]$BaseBranch = "develop"
)

$CurrentBranch = git rev-parse --abbrev-ref HEAD
Write-Host "Opening PR: $Title"
Write-Host "From: $CurrentBranch -> $BaseBranch"

git push origin $CurrentBranch

$body = @"
## What This PR Does

## Why This Change Is Needed

Closes: #$Ticket

## How It Was Implemented

## What Was Considered But Not Done

## Testing Evidence

- [ ] Unit tests written and passing
- [ ] Integration tests written and passing
- [ ] No existing tests broken
- [ ] Pre-delivery checklist completed

## Security Considerations

## Reviewer Notes
"@

$body | gh pr create --title $Title --base $BaseBranch --head $CurrentBranch --body-file -
Write-Host "PR created."
