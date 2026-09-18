# Product Requirements Document (PRD) - jev-superpowers

## 1. Problem Statement
`obra/superpowers` established the industry standard for disciplined agentic coding workflows (brainstorming, writing plans, executing plans, systematic debugging). However, autonomous LLMs operating within this framework still suffer from cognitive failure modes:
1. **Hallucinatory Package Guessing**: Inventing non-existent crates or deprecated packages during planning.
2. **Uncalibrated Architecture Choices**: Generating pros/cons lists that pick arbitrary technical paths without quantifiable confidence.
3. **Unchecked Destructive Execution**: Running irreversible shell commands without guardrails.
4. **Premature Turn Completion**: Declaring tasks finished based on optimistic assumptions rather than verified evidence.

## 2. Solution Overview
`jev-superpowers` is a drop-in agent skills extension that upgrades `superpowers` with TypeSafe AI Jev System One (`jev-1.13.0`). It replaces open-ended LLM guesses with deterministic 70ms typed decisions, crate verification, and completion gates.

## 3. Core Capabilities
1. **`jev-brainstorming`**: Gated convergence using `jev-axi pick` with calibrated confidence.
2. **`jev-writing-plans`**: Strict dependency vetting via `jev-scout` before adding any crate/library to a plan.
3. **`jev-executing-plans`**: Command screening via `jev-guard` and pre-commit reflex checks via `git-jev`.
4. **`jev-systematic-debugging`**: Automated compiler error triage via `jev-axi triage` and hypothesis scoring.
5. **`jev-verification`**: Enforced stop-hook via `limpet` and anti-pattern auditing via `supercov quality`.

## 4. Non-Functional Constraints
- **₹0 Runtime Cost**: Skills orchestrate already-installed local CLIs on PATH (`jev-scout`, `git-jev`, `jev-guard`, `supercov`).
- **Low Memory Footprint**: Zero heavy daemons or Docker dependencies.
- **Cross-Platform**: Tested on Windows 11, macOS, and Linux.
