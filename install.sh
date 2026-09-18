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
    if command -v "$tool" >/dev/null 2>&1; then
        echo "  ✔ $tool found ($(command -v "$tool"))"
    else
        echo "  ⚠ $tool missing! Install via: $install_cmd"
    fi
}

check_tool "jev-scout" "cargo install jev-scout"
check_tool "jev-axi" "npm install -g jev-axi"
check_tool "git-jev" "git jev install"
check_tool "supercov" "npm install -g supercov"

if [ -z "${TYPESAFE_API_KEY:-}" ]; then
    echo ""
    echo "⚠ TYPESAFE_API_KEY environment variable is not set."
    echo "  Get your free API key at: https://console.typesafe.ai"
    echo "  Export it with: export TYPESAFE_API_KEY=\"your_key\""
else
    echo "✔ TYPESAFE_API_KEY is configured."
fi

echo ""
echo "🚀 jev-superpowers ready! Use 'jev-using-superpowers' or 'jev-brainstorming' in your agent sessions."
