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

echo ""
echo "Test results: ${PASSED} passed, ${FAILED} failed."
if [ "$FAILED" -gt 0 ]; then
    exit 1
fi
