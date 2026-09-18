# Handoff Documentation - jev-superpowers

## Overview
`jev-superpowers` v0.1.0 provides a production-ready, drop-in extension of `obra/superpowers` augmented with TypeSafe Jev System One gates.

## Verification
- Run offline validation: `pwsh ./scripts/test.ps1` or `bash ./scripts/test.sh`.
- Tests verify valid frontmatter on all 6 skills and confirm cross-platform installer syntax with ₹0 token spend.

## Maintenance
- When adding new skills: ensure YAML frontmatter includes `name` and `description`.
- Run `pwsh ./scripts/test.ps1` before committing.
