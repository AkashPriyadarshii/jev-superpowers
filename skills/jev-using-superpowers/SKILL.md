---
name: jev-using-superpowers
description: Use when starting any non-trivial engineering conversation - establishes Jev-verified skill invocation, enforcing TypeSafe System One decisions, crate vetting, and completion gates
---

# Jev-Superpowers: Systematic Engineering with TypeSafe Jev

Upgrades the `superpowers` methodology by replacing LLM hallucinations and arbitrary guesswork with 70ms deterministic TypeSafe Jev System One judgments.

<EXTREMELY-IMPORTANT>
If a task involves planning, architecture, library selection, command execution, or debugging:
YOU MUST INVOKE THE CORRESPONDING JEV-SUPERPOWER.
</EXTREMELY-IMPORTANT>

## The Routing Matrix

| Phase | Standard Superpower | Jev-Superpower | Core Jev Enhancement |
|---|---|---|---|
| **Ideation / Architecture** | `brainstorming` | `jev-brainstorming` | `jev-axi pick` trade-off convergence with calibrated confidence ($>0.80$) |
| **Implementation Plan** | `writing-plans` | `jev-writing-plans` | `jev-scout` zero-hallucination crate & repository verification |
| **Execution Loop** | `executing-plans` | `jev-executing-plans` | `jev-guard` command safety + `git-jev` pre-commit reflex gate |
| **Root-Cause Debugging** | `systematic-debugging` | `jev-systematic-debugging` | `jev-axi triage` error analysis + Jev `Score` hypothesis ranking |
| **Completion Gate** | `verification-before-completion` | `jev-verification` | `limpet` turn stop-hook + `supercov quality` anti-pattern scoring |

## Prerequisites
All skills require local Jev tooling:
- `jev-scout` on PATH (`cargo install jev-scout`)
- `jev-axi` on PATH (`npm install -g jev-axi`)
- `git-jev` on PATH (`git jev install`)
- `jev-guard` on PATH
- `supercov` on PATH (`npm install -g supercov`)
- Valid `$TYPESAFE_API_KEY` (Free tier from `https://console.typesafe.ai`)

If `$TYPESAFE_API_KEY` is missing: **STOP IMMEDIATELY**.
Direct user to export `TYPESAFE_API_KEY` before proceeding. Never fall back to unverified LLM guessing silently.

## Failure Modes
See docs/CONFIDENCE.md for thresholds. When the gate tool is missing, the key is invalid, the registry is offline, or confidence falls below the Stop band: STOP, state which input failed, and never degrade to unverified guessing silently.
