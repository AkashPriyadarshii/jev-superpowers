# Offline validation test suite for jev-superpowers
$ErrorActionPreference = "Stop"

Write-Host "Running jev-superpowers offline verification suite..." -ForegroundColor Cyan

$baseDir = Split-Path -Parent $PSScriptRoot
$skillsDir = Join-Path $baseDir "skills"
$jevSkills = @(
    "jev-using-superpowers",
    "jev-brainstorming",
    "jev-writing-plans",
    "jev-executing-plans",
    "jev-systematic-debugging",
    "jev-verification"
)

$passed = 0
$failed = 0

foreach ($skill in $jevSkills) {
    $skillFile = Join-Path $skillsDir "$skill\SKILL.md"
    if (!(Test-Path $skillFile)) {
        Write-Host "  FAIL: Missing skill file: $skillFile" -ForegroundColor Red
        $failed++
        continue
    }

    $content = Get-Content $skillFile -Raw
    
    # Check YAML frontmatter
    if ($content -match "(?ms)^---\r?\nname:\s*$skill\r?\ndescription:\s*.+?\r?\n---") {
        Write-Host "  PASS: $skill has valid frontmatter" -ForegroundColor Green
        $passed++
    } else {
        Write-Host "  FAIL: $skill has invalid frontmatter schema" -ForegroundColor Red
        $failed++
    }
}

# Test installer existence
$installSh = Join-Path $baseDir "install.sh"
$installPs1 = Join-Path $baseDir "install.ps1"

if ((Test-Path $installSh) -and (Test-Path $installPs1)) {
    Write-Host "  PASS: Cross-platform installers verified (install.sh, install.ps1)" -ForegroundColor Green
    $passed++
} else {
    Write-Host "  FAIL: Missing installers" -ForegroundColor Red
    $failed++
}

$color = "Red"
if ($failed -eq 0) { $color = "Green" }
Write-Host "`nTest results: $passed passed, $failed failed." -ForegroundColor $color
if ($failed -gt 0) {
    exit 1
}
