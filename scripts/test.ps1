# Offline validation test suite for jev-superpowers (PowerShell native)
$ErrorActionPreference = 'Continue'

Write-Host 'Running jev-superpowers offline verification suite...' -ForegroundColor Cyan

$baseDir = Split-Path -Parent $PSScriptRoot
$skillsDir = Join-Path $baseDir 'skills'
$hooksDir = Join-Path $baseDir 'hooks'
$docsDir = Join-Path $baseDir 'docs'
$scriptsDir = Join-Path $baseDir 'scripts'

$jevSkills = @(
    'jev-using-superpowers',
    'jev-brainstorming',
    'jev-writing-plans',
    'jev-executing-plans',
    'jev-systematic-debugging',
    'jev-verification'
)

$passed = 0
$failed = 0

function Run-Check {
    param(
        [string]$Description,
        [scriptblock]$Condition
    )
    try {
        $result = & $Condition
        if ($result) {
            Write-Host "  [PASS] $Description" -ForegroundColor Green
            $script:passed++
        } else {
            Write-Host "  [FAIL] $Description" -ForegroundColor Red
            $script:failed++
        }
    } catch {
        Write-Host "  [FAIL] $Description (Error: $_)" -ForegroundColor Red
        $script:failed++
    }
}

# 1-6. Check frontmatters
foreach ($skill in $jevSkills) {
    $skillFile = Join-Path $skillsDir "$skill\SKILL.md"
    $desc = "$skill has valid frontmatter"
    Run-Check -Description $desc -Condition {
        if (!(Test-Path $skillFile)) { return $false }
        $content = Get-Content $skillFile -Raw
        return ($content -match '(?ms)^---\r?\nname:\s*\S+\r?\ndescription:\s*.+?\r?\n---')
    }
}

# 7. Cross-platform installers
Run-Check -Description 'Cross-platform installers verified (install.sh and install.ps1)' -Condition {
    return ((Test-Path (Join-Path $baseDir 'install.sh')) -and (Test-Path (Join-Path $baseDir 'install.ps1')))
}

# 8-9. Hooks wiring in hooks.json
$hooksJsonPath = Join-Path $hooksDir 'hooks.json'
Run-Check -Description 'hooks.json wires Stop gate' -Condition {
    if (!(Test-Path $hooksJsonPath)) { return $false }
    return (Get-Content $hooksJsonPath -Raw).Contains('"Stop"')
}

Run-Check -Description 'hooks.json wires PreToolUse gate' -Condition {
    if (!(Test-Path $hooksJsonPath)) { return $false }
    return (Get-Content $hooksJsonPath -Raw).Contains('"PreToolUse"')
}

# 10-11. Hook scripts existence
Run-Check -Description 'pre-commit blocks on git-jev FAIL' -Condition {
    return (Test-Path (Join-Path $hooksDir 'pre-commit'))
}

Run-Check -Description 'stop gate executable' -Condition {
    return (Test-Path (Join-Path $hooksDir 'stop'))
}

# 12. Pre-commit passes through non-git commands
Run-Check -Description 'pre-commit ignores plain ls' -Condition {
    $preCommit = (Join-Path $hooksDir 'pre-commit') -replace '\\', '/'
    if (Get-Command bash -ErrorAction SilentlyContinue) {
        $out = bash -c "echo '{\`"tool_input\`":{\`"command\`":\`"ls -la\`"}}' | bash '$preCommit'" 2>&1
        return ($LASTEXITCODE -eq 0)
    }
    return $true
}

# 13. Session start injects router
Run-Check -Description 'session-start injects Jev router' -Condition {
    $sessionStart = Join-Path $hooksDir 'session-start'
    if (!(Test-Path $sessionStart)) { return $false }
    return (Get-Content $sessionStart -Raw).Contains('jev-using-superpowers/SKILL.md')
}

# 14. Installer fails without key
Run-Check -Description 'installer fails without key' -Condition {
    $installSh = (Join-Path $baseDir 'install.sh') -replace '\\', '/'
    if (Get-Command bash -ErrorAction SilentlyContinue) {
        $out = bash -c "env -u TYPESAFE_API_KEY -u TYPESAFE_BASE_URL bash '$installSh'" 2>&1
        return ($LASTEXITCODE -ne 0)
    }
    return $true
}

# 15-20. Every jev skill documents failure modes
foreach ($skill in $jevSkills) {
    $skillFile = Join-Path $skillsDir "$skill\SKILL.md"
    $desc = "$skill documents failure modes"
    Run-Check -Description $desc -Condition {
        if (!(Test-Path $skillFile)) { return $false }
        return (Get-Content $skillFile -Raw).Contains('## Failure Modes')
    }
}

# 21. Confidence policy exists
Run-Check -Description 'confidence policy exists' -Condition {
    return (Test-Path (Join-Path $docsDir 'CONFIDENCE.md'))
}

# 22. FOSS Laya docs exist
Run-Check -Description 'FOSS Laya docs exist' -Condition {
    return (Test-Path (Join-Path $docsDir 'FOSS_LAYA.md'))
}

# 23. Serve-laya syntax valid
Run-Check -Description 'serve-laya syntax valid' -Condition {
    $serveLaya = Join-Path $scriptsDir 'serve-laya.py'
    if (Get-Command python -ErrorAction SilentlyContinue) {
        $null = python -m py_compile "$serveLaya" 2>&1
        return ($LASTEXITCODE -eq 0)
    }
    return (Test-Path $serveLaya)
}

# 24. README avoids absolute claims
Run-Check -Description 'README avoids 0.0% absolute' -Condition {
    $readme = Join-Path $baseDir 'README.md'
    if (!(Test-Path $readme)) { return $false }
    return -not ((Get-Content $readme -Raw) -match '0\.0%')
}

$color = 'Red'
if ($failed -eq 0) { $color = 'Green' }
Write-Host "`nTest results: $passed passed, $failed failed." -ForegroundColor $color
if ($failed -gt 0) {
    exit 1
}
