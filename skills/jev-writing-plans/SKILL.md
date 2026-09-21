---
name: jev-writing-plans
description: Use when you have a spec or requirements for a multi-step task, before touching code - crafts bite-sized TDD plans and uses jev-scout to verify real crates/libraries, eliminating hallucinated packages
---

# Jev Writing Plans: Zero-Hallucination Implementation Planning

Inherits bite-sized task granularity, DRY/YAGNI principles, and strict TDD ordering from `superpowers:writing-plans`.

## The Rule of Dependency Verification (MANDATORY)

LLMs constantly hallucinate non-existent libraries, dead crates, or fantasy APIs during implementation planning.
In `jev-writing-plans`, **every proposed external dependency or library MUST be verified with `jev-scout` before adding it to the plan.**

```bash
jev-scout "<Library or Crate need>" --ecosystem <crates|github|all>
```

**Verification Criteria:**
- **Fit Score**: Must score $\ge 2.0 / 4.0$ against prompt requirements.
- **Active Maintenance (`Noul`)**: Maintenance probability must be $> 0.50$.
- **Command Output**: Paste the exact `cargo add <crate>` or `npm install <pkg>` command output from `jev-scout` into the task steps. Never guess package names.

## Task Structure & Bite-Sized Steps
Each task is 2-5 minutes of work:
1. **Task Header**: Files created/modified + dependencies verified via `jev-scout`.
2. **Step 1 (TDD Red)**: Write failing test.
3. **Step 2 (Verify Red)**: Run test command, verify expected failure.
4. **Step 3 (TDD Green)**: Write minimal implementation code.
5. **Step 4 (Verify Green)**: Run test command, verify 0 failures.
6. **Step 5 (Commit)**: Commit with conventional message (`feat:`, `fix:`).

Save implementation plans to `docs/superpowers/plans/YYYY-MM-DD-<feature>.md`.

## Failure Modes
See docs/CONFIDENCE.md for thresholds. When the gate tool is missing, the key is invalid, the registry is offline, or confidence falls below the Stop band: STOP, state which input failed, and never degrade to unverified guessing silently.
