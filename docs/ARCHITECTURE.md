# Enterprise Architecture Specification: jev-superpowers

```
Document Version: 1.2.0
Status: ACTIVE / PRODUCTION
Classification: Public Open-Source Framework Specification
Architectural Tier: Autonomous Agent Infrastructure & Deterministic Reflex Gates
```

---

## 1. System Overview & Executive Topology

`jev-superpowers` is a dual-tier agentic software engineering harness. It couples autonomous LLM coding agents (Claude Code, Cursor, Codex, Pi, OpenCode, Antigravity) with sub-second non-autoregressive decision engines (TypeSafe AI Jev System One or open-weight Laya ModernBERT).

Traditional coding agents operate exclusively in System 2: generating long token streams, making probabilistic guesses about third-party crates, and relying on conversational self-correction. `jev-superpowers` injects hard lifecycle interceptors that enforce deterministic contracts at tool invocation, commit, and session termination boundaries.

```
                      ┌──────────────────────────────────────────┐
                      │          Developer / Agent Task          │
                      └─────────────────────┬────────────────────┘
                                            │
                                            ▼
                      ┌──────────────────────────────────────────┐
                      │    Harness Router: jev-using-superpowers │
                      │  Intercepts lifecycle hooks & activates  │
                      └───────┬──────────────────────────┬───────┘
                              │                          │
        Phase 1: Divergence   │                          │  Phase 2: Planning
        ┌─────────────────────┴───────┐          ┌───────┴─────────────────────┐
        │     jev-brainstorming       │          │      jev-writing-plans      │
        │  • Options generation       │          │  • Task decomposition       │
        │  • jev-axi pick scoring     │          │  • jev-scout package check  │
        │  • Confidence floor >= 0.80 │          │  • Hallucination floor = 0  │
        └─────────────┬───────────────┘          └─────────────┬───────────────┘
                      │                                        │
                      └───────────────────┬────────────────────┘
                                          │
                                          ▼
                      ┌──────────────────────────────────────────┐
                      │ Phase 3: Gated Execution                 │
                      │ jev-executing-plans                      │
                      │  • Shell pre-execution: jev-guard        │
                      │  • Git staging: git-jev diff gate        │
                      └───────────────────┬──────────────────────┘
                                          │
                  ┌───────────────────────┴───────────────────────┐
                  │ Error / Test Failure?                         │
                  ▼                                               ▼
     [YES: Divert to Triage]                         [NO: Advance to Gate]
  ┌───────────────────────────────┐               ┌───────────────────────────┐
  │ Phase 4: Systematic Debugging │               │ Phase 5: Verification     │
  │ jev-systematic-debugging      │               │ jev-verification          │
  │  • Log prune: jev-pruner      │               │  • Code quality: supercov │
  │  • Hypothesis: jev-axi triage │               │  • Turn gate: limpet      │
  │  • 4-phase root cause isolate │               │  • Test check: test.sh    │
  └───────────────┬───────────────┘               └─────────────┬─────────────┘
                  │                                             │
                  └───────────────────────┬─────────────────────┘
                                          ▼
                      ┌──────────────────────────────────────────┐
                      │            Verified Ship / PR            │
                      └──────────────────────────────────────────┘
```

---

## 2. Decision Engine Abstraction Layer (DEAL)

The framework isolates decision consumers (`git-jev`, `limpet`, `jev-axi`, `jev-guard`) from the concrete backend via the System One protocol (`POST /v1/systemone`).

```
                    ┌──────────────────────────────────────┐
                    │ Client Utilities (git-jev, limpet)   │
                    └──────────────────┬───────────────────┘
                                       │
                      HTTP JSON Protocol (POST /v1/systemone)
                                       │
                 ┌─────────────────────┴─────────────────────┐
                 ▼                                           ▼
      [Backend A: Cloud Jev]                      [Backend B: Local Laya]
      • URL: api.typesafe.ai/v1                   • URL: 127.0.0.1:8000/v1
      • Target: jev-1.13.0                        • Target: Laya 421M ModernBERT
      • Cloud managed                             • 100% Air-gapped / Local RAM
      • Auth: TYPESAFE_API_KEY                    • Auth: Dummy / Keyless
```

### Transport Payload Schema
```json
{
  "state": "<Raw string or JSON payload up to 32k tokens>",
  "questions": {
    "decision_id": {
      "type": "choice | score | noul",
      "instructions": "<Evaluation criteria>",
      "criteria": {
        "option_a": "<Description>",
        "option_b": "<Description>"
      }
    }
  }
}
```

---

## 3. Data Flow & Security Boundaries

### Boundary 1: Host Command Execution (`jev-guard`)
- **Hook Point:** `PreToolUse` on Bash / PowerShell calls.
- **Fail Strategy:** Fail-closed on high destructive probability ($p \ge 0.80$).
- **Inspectors:** Sub-string regex scan + System One semantic command classification.

### Boundary 2: Version Control Ingress (`git-jev`)
- **Hook Point:** Git pre-commit and pre-push reflex gate.
- **Payload:** Staged git index (`git diff --staged`).
- **Inspection Vectors:**
  1. High-entropy strings and credentials (private keys, tokens, `.env` files).
  2. Malicious build script alterations (obfuscated curl piping, suspicious lifecycle hooks).
- **Latency Budget:** $<120$ ms on Cloud, $<40$ ms on Local Laya.

### Boundary 3: Stop-Hook Termination Gate (`limpet`)
- **Hook Point:** Turn completion (`Stop`).
- **Evaluation Criteria:**
  1. Working directory clean (`git status --porcelain`).
  2. Test suite exit code clean (`scripts/test.sh` / `scripts/test.ps1`).
  3. Acceptance criteria satisfaction verified via Jev semantic check.
- **Behavior:** Returns exit code `2` to harness to prevent premature turn closure.

---

## 4. Cross-Platform Runtime Matrix

| Platform | Host Environment | Hook Runner | Test Harness | Default Transport |
|---|---|---|---|---|
| **Linux** | Ubuntu 20.04+, Debian, Arch | `hooks/run-hook.cmd` (bash mode) | `bash scripts/test.sh` | Unix domain or TCP loopback |
| **macOS** | macOS 12+ (Intel / Apple Silicon) | `hooks/run-hook.cmd` (bash mode) | `bash scripts/test.sh` | Metal accelerated / TCP |
| **Windows** | Windows 10/11 x64 | `hooks/run-hook.cmd` (cmd batch mode) | `pwsh scripts/test.ps1` | WinHTTP / Named Pipe / TCP |

---

## 5. Token Economics & Latency Budgets

| Operation | Standard LLM Cost | Jev Cloud Cost | Local Laya Cost | Target P50 | Target P99 |
|---|---|---|---|---|---|
| Command Guard | ~$0.004 | ~$0.00001 | $0.00000 | 74ms | 110ms |
| Crate Scout Check | ~$0.008 | ~$0.00002 | $0.00000 | 82ms | 130ms |
| Git Pre-Commit Diff | ~$0.015 | ~$0.00003 | $0.00000 | 94ms | 150ms |
| Stop Gate Audit | ~$0.012 | ~$0.00002 | $0.00000 | 76ms | 120ms |
| **Complete 400-Turn Day** | **~$6.50** | **~$0.008** | **$0.000** | **<90ms** | **<140ms** |
