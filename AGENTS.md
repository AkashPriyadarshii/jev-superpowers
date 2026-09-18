# Project Agent Rules - jev-superpowers

## Mission
Provide zero-hallucination, deterministic agent skills for software engineering. Every architectural trade-off, dependency selection, destructive command, and completion check is gated by TypeSafe Jev System One.

## Directory Structure
- `skills/`: Individual skills ready to symlink or copy to `~/.agents/skills/`
  - `jev-using-superpowers/`: Root activator and dispatcher
  - `jev-brainstorming/`: Divergent exploration + `jev-axi pick` convergence
  - `jev-writing-plans/`: Implementation plans with mandatory `jev-scout` vetting
  - `jev-executing-plans/`: Execution loop with `jev-guard` and `git-jev` gates
  - `jev-systematic-debugging/`: Root-cause triage via `jev-axi triage` and Jev `Score`
  - `jev-verification/`: Turn completion stop-policy gate via `supercov`
- `scripts/`: Offline validation test runner and fixture checks
- `docs/`: Technical specifications (PRD, Design, Architecture, Handoff)

## Tooling Contract
- `jev-scout`: Dependency and crate verification
- `jev-axi`: Typed choice (`pick`) and triage
- `git-jev`: Pre-commit diff reflex checks
- `jev-guard`: Shell command destructive action filter
- `supercov`: Test coverage and code quality audit
