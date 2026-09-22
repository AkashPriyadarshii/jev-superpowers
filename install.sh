#!/usr/bin/env bash
set -euo pipefail

echo "⚡ Installing jev-superpowers..."

TARGET_DIR="${HOME}/.agents/skills"
mkdir -p "${TARGET_DIR}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Copy all skills
cp -r "${SCRIPT_DIR}/skills/"* "${TARGET_DIR}/"

echo "✔ Skills installed to ${TARGET_DIR}:"
ls -d "${TARGET_DIR}/jev-"*

# Check prerequisite binaries
echo ""
echo "🔍 Checking TypeSafe Jev tooling on PATH..."

check_tool() {
    local tool="$1"
    local install_cmd="$2"
    if [ $# -ge 3 ]; then
        local probe="$3"
        if $probe >/dev/null 2>&1; then
            echo "  ✔ $tool found"
        else
            echo "  ✘ $tool MISSING! Install via: $install_cmd"
            MISSING=$((MISSING + 1))
        fi
    elif command -v "$tool" >/dev/null 2>&1; then
        echo "  ✔ $tool found ($(command -v "$tool"))"
    else
        echo "  ✘ $tool MISSING! Install via: $install_cmd"
        MISSING=$((MISSING + 1))
    fi
}

MISSING=0
check_tool "jev-scout" "cargo install jev-scout"
check_tool "jev-axi" "npm install -g jev-axi"
check_tool "git-jev" "git jev install" "git jev --version"
check_tool "jev-guard" "npm install -g jev-guard"
check_tool "supercov" "npm install -g supercov"
check_tool "limpet" "git clone https://github.com/noplan-inc/limpet ~/limpet (or /plugin install limpet@limpet)" "[ -f \"$HOME/limpet/limpet.py\" ] || command -v limpet || (command -v claude >/dev/null 2>&1 && claude plugin list 2>/dev/null | grep -q limpet)"
check_tool "jev-seo" "cargo install jev-seo"

if [ -z "${TYPESAFE_API_KEY:-}" ]; then
    echo ""
    echo "✘ TYPESAFE_API_KEY environment variable is not set."
    echo "  Get your free API key at: https://console.typesafe.ai"
    echo "  Export it with: export TYPESAFE_API_KEY=\"your_key\""
    MISSING=$((MISSING + 1))
else
    echo "✔ TYPESAFE_API_KEY is configured."
fi

echo ""
if [ "$MISSING" -gt 0 ]; then
    echo "⚠️  Skills installed successfully, but ${MISSING} prerequisite tool(s) were not detected."
    echo "   Install the missing tools above to activate their respective Jev reflex gates."
else
    echo "✔ All TypeSafe Jev tools and environment variables verified!"
fi
echo "🚀 jev-superpowers ready! Use 'jev-using-superpowers' or 'jev-brainstorming' in your agent sessions."
