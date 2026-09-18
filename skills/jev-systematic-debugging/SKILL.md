---
name: jev-systematic-debugging
description: Use when encountering any bug, test failure, or build error - enforces root-cause investigation using jev-axi triage for build errors and Jev Score for hypothesis ranking
---

# Jev Systematic Debugging: Root-Cause Investigation with Jev Triage

Enforces the Iron Law from `superpowers:systematic-debugging`:
```
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
```

Symptom patches are failures. Every fix must address the verified root cause.

## The Debugging Phases

### Phase 1: Automated Failure Triage (`jev-axi triage`)
When tests or builds fail, do not guess at the error. Pipe the raw compiler/test output into `jev-axi triage`:

```bash
cargo test 2>&1 | jev-axi triage
# or: npm test 2>&1 | jev-axi triage
```

`jev-axi triage` classifies the failure domain (syntax, type system, logic regression, flaky timing, environment) and identifies the exact failing boundary.

### Phase 2: Hypothesis Generation & Jev Scoring
Generate 2-3 plausible hypotheses for why the root failure occurred. For each hypothesis, score its plausibility given the error trace and recent git diff:

```bash
jev-axi check "Does this stack trace support the hypothesis: <hypothesis>?" --state "<stack trace & diff snippet>"
```

Select the hypothesis with the highest verified probability ($p > 0.70$).

### Phase 3: Minimal Reproducing Test Case
Write the smallest possible failing test that triggers the bug. Run it to confirm it fails.

### Phase 4: Root-Cause Fix & Green Verification
Implement the fix at the root cause. Run the test suite to confirm green, then run regression checks across all callers.
