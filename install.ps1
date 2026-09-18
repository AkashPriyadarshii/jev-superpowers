# PowerShell installer for jev-superpowers
$ErrorActionPreference = "Stop"

Write-Host "⚡ Installing jev-superpowers..." -ForegroundColor Cyan

$targetDir = Join-Path $HOME ".agents\skills"
if (!(Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
}

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Copy skills
Get-ChildItem (Join-Path $scriptDir "skills") | ForEach-Object {
    $dest = Join-Path $targetDir $_.Name
    Copy-Item $_.FullName -Destination $dest -Recurse -Force
}

Write-Host "✔ Skills installed to $targetDir" -ForegroundColor Green

# Check tooling
Write-Host "`n🔍 Checking TypeSafe Jev tooling on PATH..." -ForegroundColor Cyan

function Check-Tool ($tool, $installCmd) {
    $cmd = Get-Command $tool -ErrorAction SilentlyContinue
    if ($cmd) {
        Write-Host "  ✔ $tool found ($($cmd.Source))" -ForegroundColor Green
    } else {
        Write-Host "  ⚠ $tool missing! Install via: $installCmd" -ForegroundColor Yellow
    }
}

Check-Tool "jev-scout" "cargo install jev-scout"
Check-Tool "jev-axi" "npm install -g jev-axi"
Check-Tool "git-jev" "git jev install"
Check-Tool "supercov" "npm install -g supercov"

if (!$env:TYPESAFE_API_KEY) {
    Write-Host "`n⚠ TYPESAFE_API_KEY environment variable is not set." -ForegroundColor Yellow
    Write-Host "  Get your free API key at: https://console.typesafe.ai"
    Write-Host "  Set it in PowerShell with: `$env:TYPESAFE_API_KEY = 'your_key'"
} else {
    Write-Host "✔ TYPESAFE_API_KEY is configured." -ForegroundColor Green
}

Write-Host "`n🚀 jev-superpowers ready! Use 'jev-using-superpowers' or 'jev-brainstorming' in your agent sessions." -ForegroundColor Cyan
