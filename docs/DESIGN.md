# System Design Specification: jev-superpowers

```
Document Version: 1.2.0
Status: ACTIVE / PRODUCTION
Classification: Engineering Design Document (RFC-Tier)
Subsystem: Deterministic Decision Interceptors & Reflex Gates
```

---

## 1. Design Principles & Tenets

1. **Deterministic Gates over Prompt Hints**: Coding agents treat system prompts as negotiable guidelines. Physical hooks (`PreToolUse`, `Stop`, git hooks) treat policies as non-negotiable invariant boundaries.
2. **Sub-Second Reflex Execution**: Decision gates execute in $<120$ms (cloud) or $<40$ms (local), preventing developer flow interruption.
3. **Speculative Fan-Out**: Ingest state context once per turn. Dispatch multiple independent decision questions in a single parallel payload to maximize throughput and minimize cost.
4. **Zero Ambient Data Leakage**: Support air-gapped environments. The system functions with 100% feature parity using the local Laya open-weight engine without internet access.
5. **No Synthetic Dependencies**: Do not introduce heavy runtime frameworks or container dependencies. Rely on native shell wrappers and lightweight HTTP bridges.

---

## 2. Mathematical Decision Primitives

The core evaluation protocol operates on three orthogonal decision primitives:

### A. Choice Primitive
- **Mathematical Form:**
  $$\text{Choice}(S, C) = \arg\max_{c \in C} P(c \mid S)$$
  Where $S$ is the input repository state and $C = \{c_1, c_2, \dots, c_k\}$ is a finite set of discrete options.
- **Output Structure:** Selected option string, normalized probability distribution vector $\mathbf{p}$, and confidence scalar $\gamma \in [0.0, 1.0]$.
- **Usage:** Architecture divergence (`jev-axi pick`), command danger classification (`jev-guard`).

### B. Score Primitive
- **Mathematical Form:**
  $$\text{Score}(S, R) = \sum_{l \in L} v(l) \cdot P(l \mid S, R)$$
  Where $R$ is a rubric specification and $L$ represents discretized evaluation levels with numeric values $v(l)$.
- **Output Structure:** Expected scalar score, discrete level probabilities, confidence metric.
- **Usage:** Error hypothesis ranking (`jev-axi triage`), code quality anti-pattern evaluation (`supercov quality`).

### C. Noul Primitive (Calibrated Probability)
- **Mathematical Form:**
  $$\text{Noul}(S, A) = P(A = \text{True} \mid S) \in [0.00, 1.00]$$
  Where $A$ is an atomic boolean assertion evaluated against state $S$.
- **Output Structure:** Pure calibrated probability scalar without text generation.
- **Usage:** Git secret leakage probability, destructive command detection, turn stop gate policy.

---

## 3. Finite State Machine (FSM) Workflow Lifecycle

An agent turn moves through strict state transitions:

```
[INIT]
  │
  ▼
[SESSION_START] ──▶ Injects jev-using-superpowers router
  │
  ▼
[IDLE / READY]
  │
  ├── User requests architecture / feature ──▶ [PHASE_1: BRAINSTORM]
  │                                                  │ (jev-axi pick, confidence >= 0.80)
  │                                                  ▼
  ├── User requests implementation plan   ──▶ [PHASE_2: PLAN]
  │                                                  │ (jev-scout crate validation)
  │                                                  ▼
  ├── Agent invokes tool / command        ──▶ [PHASE_3: EXECUTE]
  │                                                  │ (jev-guard hook, git-jev pre-commit)
  │                                                  ▼
  ├── Execution fails / compiler error    ──▶ [PHASE_4: TRIAGE]
  │                                                  │ (jev-axi triage, root-cause 4-phase)
  │                                                  ▼
  └── Agent calls Stop / finish turn      ──▶ [PHASE_5: VERIFY]
                                                     │ (limpet check, test.sh suite)
                                                     ▼
                                              [TURN_COMPLETE]
```

### Transition Guards & Action Table

| Source State | Target State | Triggering Event | Gate Invariant | Failure Action |
|---|---|---|---|---|
| `PHASE_1` | `PHASE_2` | Spec Finalization | Confidence $\ge 0.80$ | Request human clarification |
| `PHASE_2` | `PHASE_3` | Plan Acceptance | Zero unvetted packages | Replace with real registered crate |
| `PHASE_3` | `COMMIT` | Git Commit Event | Secret $p < 0.10$, Danger $p < 0.10$ | Block commit with exit code `2` |
| `PHASE_3` | `PHASE_4` | Test or Command Failure | Context size within threshold | Prune log noise via `jev-pruner` |
| `PHASE_5` | `IDLE` | Agent Stop Call | Clean git tree & exit code `0` | Block turn stop; re-enter work loop |

---

## 4. Hook Contracts & Failure Policies

### Policy Matrix

| Interceptor | Target | Fail-Closed Policy | Fail-Open Fallback | Timeout Ceiling |
|---|---|---|---|---|
| `PreToolUse:Bash` | Destructive commands | **YES** (exit code 2) | Block if ambiguous | 250 ms |
| `PreToolUse:Git` | Git commit & push | **YES** (exit code 2) | Block if unverified | 350 ms |
| `Stop:Limpet` | Premature done claim | **YES** (exit code 2) | Block if tests fail | 500 ms |
| `SessionStart` | Router bootstrap | NO (advisory log) | Pass through to agent | 100 ms |

---

## 5. Security & Isolation Architecture

1. **Subprocess Isolation:** Hook scripts run in isolated subshells (`hooks/run-hook.cmd`) with strict environment segregation.
2. **Secret Defense:** Staged diffs are inspected prior to repository persistence. High-entropy strings, private key headers, and credential variables trigger instant rejection.
3. **Zero Network Egress Mode:** When configured with `TYPESAFE_BASE_URL="http://127.0.0.1:8000"`, zero external network calls are dispatched across the entire development lifecycle.
