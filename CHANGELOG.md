# Changelog - jev-superpowers

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Enforcement hooks: pre-commit gate blocking unless `git jev check` passes, Stop gate blocking on dirty tree or failing suite. SessionStart injects the Jev router.
- Fail-loud installers checking all 7 tools plus key validation.
- `docs/CONFIDENCE.md` single threshold table and Failure Modes in all 6 skills.
- Test suite expanded to 22 checks covering hooks, installer failure, and prose claims.
## [1.0.0] - 2026-09-21

### Added
- Release workflow: tag-based GitHub Release with auto-generated notes on `v*`, gated by the offline test suite.

## [0.1.0] - 2026-09-18

### Added
- Initial release of `jev-superpowers`.
- 6 core agent skills: `jev-using-superpowers`, `jev-brainstorming`, `jev-writing-plans`, `jev-executing-plans`, `jev-systematic-debugging`, `jev-verification`.
- Integrated TypeSafe Jev System One gates: `jev-scout` dependency verification, `jev-axi pick` convergence, `jev-guard` shell filter, `git-jev` commit gate, and `supercov quality` audit.
- Hybrid cross-platform installer (`install.sh`, `install.ps1`).
- Offline verification test harness (`scripts/test.ps1`, `scripts/test.sh`).
