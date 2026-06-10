# install-ai-os.ps1 - Copy minimal OS rule set into a target project
param(
    [Parameter(Mandatory = $true)]
    [string]$TargetPath,
    [string]$OsRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Stop"

$TargetPath = Resolve-Path $TargetPath
$OsDest = Join-Path $TargetPath ".ai-os"

$DirsToCopy = @(
    "agents",
    "prompts",
    "standards",
    "ai-collaboration"
)

Write-Host "Installing AI Engineering OS into: $TargetPath"

if (-not (Test-Path $TargetPath)) {
    New-Item -ItemType Directory -Path $TargetPath -Force | Out-Null
}

if (Test-Path $OsDest) {
    Write-Warning ".ai-os already exists. Merging/overwriting files."
} else {
    New-Item -ItemType Directory -Path $OsDest -Force | Out-Null
}

foreach ($dir in $DirsToCopy) {
    $src = Join-Path $OsRoot $dir
    $dst = Join-Path $OsDest $dir
    if (Test-Path $src) {
        Copy-Item -Path $src -Destination $dst -Recurse -Force
        Write-Host "  Copied $dir/"
    }
}

# workflows/prompts only
$wpSrc = Join-Path $OsRoot "workflows\prompts"
$wpDst = Join-Path $OsDest "workflows\prompts"
if (Test-Path $wpSrc) {
    New-Item -ItemType Directory -Path (Split-Path $wpDst) -Force | Out-Null
    Copy-Item -Path $wpSrc -Destination $wpDst -Recurse -Force
    Write-Host "  Copied workflows/prompts/"
}

# agents/shared
$sharedSrc = Join-Path $OsRoot "agents\shared"
$sharedDst = Join-Path $OsDest "agents\shared"
if (Test-Path $sharedSrc) {
    Copy-Item -Path $sharedSrc -Destination $sharedDst -Recurse -Force
    Write-Host "  Copied agents/shared/"
}

# registry manifest + profiles (for MCP local resolver)
$regSrc = Join-Path $OsRoot "registry"
$regDst = Join-Path $OsDest "registry"
if (Test-Path $regSrc) {
    New-Item -ItemType Directory -Path $regDst -Force | Out-Null
    Copy-Item -Path (Join-Path $regSrc "manifest.yaml") -Destination $regDst -Force -ErrorAction SilentlyContinue
    if (Test-Path (Join-Path $regSrc "profiles")) {
        Copy-Item -Path (Join-Path $regSrc "profiles") -Destination $regDst -Recurse -Force
    }
    if (Test-Path (Join-Path $regSrc "dist\registry.json")) {
        Copy-Item -Path (Join-Path $regSrc "dist") -Destination $regDst -Recurse -Force
    }
    Write-Host "  Copied registry/"
}

# Config and project context template
$configSrc = Join-Path $OsRoot "templates\ai-os.config.yaml"
$configDst = Join-Path $TargetPath "ai-os.config.yaml"
if (-not (Test-Path $configDst)) {
    Copy-Item -Path $configSrc -Destination $configDst
    Write-Host "  Created ai-os.config.yaml"
}

$ctxSrc = Join-Path $OsRoot "templates\project-context.md"
$ctxDst = Join-Path $TargetPath "docs\project-context.md"
$ctxDir = Split-Path $ctxDst
if (-not (Test-Path $ctxDir)) { New-Item -ItemType Directory -Path $ctxDir -Force | Out-Null }
Copy-Item -Path $ctxSrc -Destination $ctxDst -Force
Write-Host "  Created docs/project-context.md"

Write-Host ""
Write-Host "Done. Next steps:"
Write-Host "  1. Open $TargetPath in your IDE"
Write-Host "  2. Read docs/project-context.md and fill it for each AI session"
Write-Host "  3. See OS docs/adopt-in-your-project.md for track-specific paths"
