# validate-prompt-contract.ps1 — Verify all **/prompts/*.md files match PROMPT-CONTRACT.md
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Stop"

$RequiredSections = @(
    "## Goal"
    "## Scope"
    "## Workflow"
    "## What to look for"
    "## Evidence bar"
    "## Response rules"
    "## Constraints"
)

$ExcludeFiles = @(
    "PROMPT-CONTRACT.md"
    "PROMPT-REVIEW-CHECKLIST.md"
)

Set-Location $RepoRoot

$promptFiles = Get-ChildItem -Path $RepoRoot -Recurse -Filter "*.md" -File |
    Where-Object { $_.FullName -match '[\\/]prompts[\\/]' } |
    Where-Object { $ExcludeFiles -notcontains $_.Name } |
    Sort-Object FullName

$checked = 0
$failures = @()

foreach ($file in $promptFiles) {
    $checked++
    $content = Get-Content -Path $file.FullName -Raw
    $rel = $file.FullName.Substring($RepoRoot.Length).TrimStart('\', '/')
    $missing = @()

    foreach ($section in $RequiredSections) {
        if ($content -notmatch [regex]::Escape($section)) {
            $missing += $section
        }
    }

    if ($missing.Count -gt 0) {
        $failures += [PSCustomObject]@{
            File    = $rel
            Missing = ($missing -join ", ")
        }
    }
}

if ($failures.Count -gt 0) {
    foreach ($failure in $failures) {
        Write-Host "FAIL: $($failure.File)"
        Write-Host "  Missing: $($failure.Missing)"
    }
    Write-Host ""
    Write-Host "$($failures.Count) file(s) failed prompt contract validation ($checked checked)."
    Write-Host "See prompts/PROMPT-CONTRACT.md for required structure."
    exit 1
}

if ($checked -eq 0) {
    Write-Host "WARN: No prompt files found under **/prompts/*.md"
    exit 0
}

Write-Host "OK: All $checked prompt file(s) pass contract validation."
