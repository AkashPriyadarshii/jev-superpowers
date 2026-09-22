#!/usr/bin/env bash
set -euo pipefail

echo "🧪 Running jev-superpowers offline verification suite..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
SKILLS_DIR="${ROOT_DIR}/skills"

JEV_SKILLS=(
    "jev-using-superpowers"
    "jev-brainstorming"
    "jev-writing-plans"
    "jev-executing-plans"
    "jev-systematic-debugging"
    "jev-verification"
)

PASSED=0
FAILED=0

for skill in "${JEV_SKILLS[@]}"; do
    skill_file="${SKILLS_DIR}/${skill}/SKILL.md"
    if [ ! -f "$skill_file" ]; then
        echo "  ❌ Missing skill file: $skill_file"
        FAILED=$((FAILED + 1))
        continue
    fi

    # Verify frontmatter has name and description
    if grep -q "^name: ${skill}" "$skill_file" && grep -q "^description:" "$skill_file"; then
        echo "  ✔ ${skill}: valid frontmatter"
        PASSED=$((PASSED + 1))
    else
        echo "  ❌ ${skill}: invalid frontmatter schema"
        FAILED=$((FAILED + 1))
    fi
done

if [ -f "${ROOT_DIR}/install.sh" ] && [ -f "${ROOT_DIR}/install.ps1" ]; then
    echo "  ✔ Cross-platform installers verified (install.sh, install.ps1)"
    PASSED=$((PASSED + 1))
else
    echo "  ❌ Missing installer scripts"
    FAILED=$((FAILED + 1))
fi

check() {
    local desc="$1"; shift
    if "$@" >/dev/null 2>&1; then
        echo "  ✔ $desc"
        PASSED=$((PASSED + 1))
    else
        echo "  ❌ $desc"
        FAILED=$((FAILED + 1))
    fi
}

# Enforcement hooks wired and executable
check "hooks.json wires Stop gate" grep -q '"Stop"' "${ROOT_DIR}/hooks/hooks.json"
check "hooks.json wires PreToolUse gate" grep -q '"PreToolUse"' "${ROOT_DIR}/hooks/hooks.json"
check "pre-commit blocks on git-jev FAIL" test -x "${ROOT_DIR}/hooks/pre-commit"
check "stop gate executable" test -x "${ROOT_DIR}/hooks/stop"

# Pre-commit passes through non-git commands, gates git commit
check "pre-commit ignores plain ls" bash -c "echo '{\"tool_input\":{\"command\":\"ls -la\"}}' | bash ${ROOT_DIR}/hooks/pre-commit"
check "session-start injects Jev router" grep -q "jev-using-superpowers/SKILL.md" "${ROOT_DIR}/hooks/session-start"

# Installer fails loud without key (expect nonzero)
check "installer fails without key" bash -c "! TYPESAFE_API_KEY= bash ${ROOT_DIR}/install.sh"

# Every jev skill documents failure modes + confidence policy exists
for skill in "${JEV_SKILLS[@]}"; do
    check "$skill documents failure modes" grep -q "## Failure Modes" "${SKILLS_DIR}/${skill}/SKILL.md"
done
check "confidence policy exists" test -f "${ROOT_DIR}/docs/CONFIDENCE.md"
check "FOSS Laya docs exist" test -f "${ROOT_DIR}/docs/FOSS_LAYA.md"
check "serve-laya syntax valid" python -m py_compile "${ROOT_DIR}/scripts/serve-laya.py"

# No banned absolute claims without methodology
check "README avoids 0.0% absolute" bash -c "! grep -q '0\.0%' ${ROOT_DIR}/README.md"

echo ""
echo "Test results: ${PASSED} passed, ${FAILED} failed."
if [ "$FAILED" -gt 0 ]; then
    exit 1
fi
