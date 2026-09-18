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
Run `limpet check` to verify that all requirements defined in the initial user prompt have been tested and satisfied:

```bash
limpet check
```

Only when all test commands pass, `supercov quality` passes, and `limpet` validates completion may you make the completion claim to the user.
