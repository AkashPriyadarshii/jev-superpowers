---
name: jev-executing-plans
description: Use when executing a written implementation plan - guides step-by-step TDD execution while enforcing jev-guard for command safety and git-jev for pre-commit diff screening
---

# Jev Executing Plans: Safe & Verified Execution

Follows the disciplined execution loop from `superpowers:executing-plans`, but inserts deterministic System One safety gates before dangerous actions and commits.

## The Execution Loop

### 1. Load & Critical Review
- Read the plan file in `docs/superpowers/plans/`.
- Verify worktree isolation if applicable (`using-git-worktrees`).
- Create a clear checklist of tasks.

### 2. Command Safety Gate (`jev-guard`)
Before executing any potentially destructive shell command (mass deletion, recursive file changes, branch manipulation, schema migrations):
You MUST screen the command through `jev-guard`:

```bash
jev-guard "<command-to-execute>"
```

If `jev-guard` flags the command as destructive or unsafe, STOP and request explicit human confirmation.

### 3. Pre-Commit Reflex Gate (`git-jev`)
Before completing any task commit or git push:
1. Stage your changes: `git add <files>`
2. Screen the diff through `git-jev`:
   ```bash
   git jev check
   ```
3. Verify that:
   - No unredacted secrets or private tokens are leaked ($p < 0.10$).
   - No destructive payloads or backdoor patterns exist ($p < 0.10$).
4. Commit only after `[PASS]` is reported.

### 4. Stop on Blockers
If a test fails unexpectedly or an instruction is ambiguous:
- STOP immediately.
- Do NOT force changes or attempt blind symptom fixes.
- Switch to `jev-systematic-debugging`.
