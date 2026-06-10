# rebind-prompts.ps1 - Update prompts to project-bound language
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$OldPatterns = @(
    'You are an enterprise-grade engineering agent operating within the AI Engineering OS\.',
    'You are a ([^.]+) operating within the AI Engineering OS\.',
    'You are a ([^.]+) for pull requests within the AI Engineering OS\.',
    'You are a senior engineer performing a general code review for pull requests within the AI Engineering OS\.'
)

$NewEnterprise = @"
You are an enterprise-grade engineering agent working on the repository and task described in the project context below.
Apply the role constraints, standards, and checklists provided in context.
Treat the open workspace as the source of truth for code, conventions, and file paths.
"@

Set-Location $RepoRoot
$count = 0

Get-ChildItem -Path @("prompts", "agents", "workflows\prompts") -Recurse -Filter "*.md" -File -ErrorAction SilentlyContinue | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $orig = $content

    if ($content -match 'operating within the AI Engineering OS') {
        if ($_.Name -eq 'global-system-prompt.md') {
            $content = $content -replace 'You are an enterprise-grade engineering agent operating within the AI Engineering OS\.', $NewEnterprise.Trim()
        } elseif ($content -match '^You are a senior engineer performing a general code review') {
            $content = $content -replace 'You are a senior engineer performing a general code review for pull requests within the AI Engineering OS\.', @"
You are a senior engineer performing a general code review for pull requests on the repository described in the project context below.
Apply the role constraints, standards, and checklists provided in context.
Treat the open workspace as the source of truth for code, conventions, and file paths.
"@
        } else {
            $content = $content -replace '(?m)^You are a (.+?) operating within the AI Engineering OS\.\r?\n', @"
You are a `$1 working on the repository and task described in the project context below.
Apply the role constraints, standards, and checklists provided in context.
Treat the open workspace as the source of truth for code, conventions, and file paths.

"@
        }
    }

    if ($content -ne $orig) {
        Set-Content -Path $_.FullName -Value $content.TrimEnd() -NoNewline -Encoding UTF8
        $count++
        Write-Host "Rebound: $($_.FullName.Substring($RepoRoot.Length))"
    }
}

Write-Host "Prompts updated: $count"
