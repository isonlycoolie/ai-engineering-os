# fix-em-dash.ps1 - Replace em-dash (U+2014) in markdown and YAML
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path,
    [switch]$WhatIf
)

$EmDash = [char]0x2014
$ExcludeDirs = @("node_modules", ".git", "dist", ".next", "__pycache__", ".pytest_cache", ".venv", "venv", "coverage")
$ExcludeFiles = @("ai-engineering-os (1).md", "fix-em-dash.ps1")

Set-Location $RepoRoot
$fixed = 0

Get-ChildItem -Path $RepoRoot -Recurse -Include *.md,*.yml,*.yaml -File -ErrorAction SilentlyContinue | ForEach-Object {
    $rel = $_.FullName.Substring($RepoRoot.Length).TrimStart('\', '/')
    if ($ExcludeFiles -contains $_.Name) { return }
    $skip = $false
    foreach ($dir in $ExcludeDirs) {
        if ($rel -match "(^|[\\/])$([regex]::Escape($dir))([\\/]|$)") { $skip = $true; break }
    }
    if ($skip) { return }

    $raw = [System.IO.File]::ReadAllText($_.FullName)
    if (-not $raw.Contains($EmDash)) { return }

    $updated = $raw
    $updated = $updated -replace ' — ', ': '
    $updated = $updated -replace "$EmDash", '-'

    if ($updated -ne $raw) {
        $fixed++
        if (-not $WhatIf) {
            [System.IO.File]::WriteAllText($_.FullName, $updated, [System.Text.UTF8Encoding]::new($false))
        }
        Write-Host "Fixed: $rel"
    }
}

Write-Host "Files updated: $fixed"
