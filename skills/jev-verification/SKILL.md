---
name: jev-verification
description: Use before claiming work is complete, fixed, or passing - enforces fresh test evidence, supercov quality anti-pattern auditing, and limpet stop-policy checks before finishing a turn
---

# Jev Verification: Evidence-Based Completion Gate

Enforces the Iron Law from `superpowers:verification-before-completion`:
```
NO COMPLETION CLAIMS WITHOUT FRESH VERIFICATION EVIDENCE
```

Never say "I'm done" or "The fix is complete" based on assumptions, unrun code, or LLM optimism.

## The Verification Gate

### Step 1: Execute Fresh Test Commands
Run the complete, un-mocked test command:
- Verify exit code 0.
- Verify 0 failed tests, 0 compiler warnings.

### Step 2: Code Quality & Anti-Pattern Audit (`supercov`)
Before declaring a feature ready, audit modified source files with `supercov quality` powered by `jev-1.13.0`:

```bash
supercov quality <src-dir>
```

**Quality Standards:**
- **0 Weak Files**: No file may have critical anti-pattern flags (`unhandled_errors`, `deep_nesting > 0.90`, `duplicated_logic`).
- If anti-patterns are flagged, address the root smell before claiming completion.

### Step 3: Stop-Policy Verification (`limpet`)
Verify that all requirements defined in the initial user prompt have been tested and satisfied. If `limpet` (https://github.com/noplan-inc/limpet) is installed, it operates as an automated agent Stop hook that prevents the agent from ending the turn prematurely without meeting defined stop criteria:

```bash
# Automated Hook: Intercepts Stop event in Claude Code / Codex / Antigravity
# Rule evaluation against ~/.limpet/rules.md judged by TypeSafe Jev

# Manual transcript review / calibration:
python3 ~/limpet/limpet.py suggest
```

Only when all test commands pass, `supercov quality` passes with 0 critical anti-patterns, and all requirements are proven may you declare the task complete.

## Failure Modes
See docs/CONFIDENCE.md for thresholds. When the gate tool is missing, the key is invalid, the registry is offline, or confidence falls below the Stop band: STOP, state which input failed, and never degrade to unverified guessing silently.
