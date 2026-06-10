# lint-no-em-dash.ps1 - Fail if em-dash (U+2014) appears in markdown or YAML
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Stop"
$EmDash = [char]0x2014

$ExcludeDirs = @(
    "node_modules", ".git", "dist", ".next", "__pycache__",
    ".pytest_cache", ".venv", "venv", "coverage"
)

$ExcludeFiles = @(
    "ai-engineering-os (1).md"
)

Set-Location $RepoRoot

$extensions = @("*.md", "*.yml", "*.yaml")
$violations = @()

foreach ($ext in $extensions) {
    Get-ChildItem -Path $RepoRoot -Recurse -Filter $ext -File -ErrorAction SilentlyContinue | ForEach-Object {
        $rel = $_.FullName.Substring($RepoRoot.Length).TrimStart('\', '/')
        if ($ExcludeFiles -contains $_.Name) { return }
        foreach ($dir in $ExcludeDirs) {
            if ($rel -match "(^|[\\/])$([regex]::Escape($dir))([\\/]|$)") { return }
        }
        $lines = Get-Content -Path $_.FullName -Encoding UTF8
        for ($i = 0; $i -lt $lines.Count; $i++) {
            if ($lines[$i].Contains($EmDash)) {
                $violations += "${rel}:$($i + 1): $($lines[$i].Trim())"
            }
        }
    }
}

if ($violations.Count -gt 0) {
    Write-Host "FAIL: Found em-dash (U+2014) in $($violations.Count) location(s). Use colon, period, or hyphen instead." -ForegroundColor Red
    $violations | Select-Object -First 50 | ForEach-Object { Write-Host "  $_" }
    if ($violations.Count -gt 50) {
        Write-Host "  ... and $($violations.Count - 50) more"
    }
    exit 1
}

Write-Host "OK: No em-dashes found in markdown or YAML files."
exit 0
