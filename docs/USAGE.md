# ⚡ jev-superpowers Usage & Workflow Guide

`jev-superpowers` replaces unverified agent assumptions with deterministic TypeSafe AI Jev System One gates across every phase of software development.

---

## 1. Toolchain Prerequisites

`jev-superpowers` orchestrates the local Jev tooling suite installed on your system. Each tool runs offline or executes sub-second System One calls via `$TYPESAFE_API_KEY`:

| Tool | Purpose | Install Command | Link |
|---|---|---|---|
| **`git-jev`** | Sub-second pre-commit & pre-push reflex gate | Precompiled binary / `cargo install` | [AkashPriyadarshii/jev-git](https://github.com/AkashPriyadarshii/jev-git) |
| **`jev-scout`** | Zero-hallucination crate & repo verification | `cargo install jev-scout` | [AkashPriyadarshii/jev-scout](https://github.com/AkashPriyadarshii/jev-scout) |
| **`jev-axi`** | Fast 70–120ms System One diff review & triage | `npm install -g jev-axi` | [npmjs.com/package/jev-axi](https://www.npmjs.com/package/jev-axi) |
| **`jev-guard`** | Destructive shell command filter | Installed with `jev-axi` | [AkashPriyadarshii/jev-guard](https://github.com/AkashPriyadarshii) |
| **`supercov`** | Jev-powered code quality & anti-pattern oracle | `npm install -g supercov` | [npmjs.com/package/supercov](https://www.npmjs.com/package/supercov) |
| **`limpet`** | Agent stop-hook completion policy gate | Precompiled binary on PATH | [AkashPriyadarshii/limpet](https://github.com/AkashPriyadarshii) |

---

## 2. End-to-End Workflow & Recipes

### Phase 1: Brainstorming & Architecture Decisions (`jev-brainstorming`)

When designing a feature or choosing between architectures, agents evaluate options using `jev-axi pick`. Unlike conversational LLMs that generate persuasive but uncalibrated justifications, Jev returns probability distributions and a strict confidence score.

```bash
jev-axi pick "Which database engine fits an offline-first single-user CLI?" \
  --options "sqlite,duckdb,sled,rocksdb" \
  --text "Single user local storage, zero daemons, fast key-value lookups, transactions needed."
```

**Real Output:**
```text
picked: sqlite
confidence: 0.94
probabilities:
  sqlite: 0.88
  duckdb: 0.08
  sled: 0.03
  rocksdb: 0.01
```

*Rule: If confidence is below `0.80`, the agent must gather more requirements rather than guessing.*

---

### Phase 2: Implementation Planning (`jev-writing-plans`)

Before writing code, agents produce an implementation plan with strict TDD steps. The plan must vet every external crate or npm library using `jev-scout`.

```bash
jev-scout "fast memory mapped ring buffer in rust" --ecosystem rust --json
```

**What Happens When an Agent Proposes a Hallucinated Package:**
If an agent invents a fake crate like `ringbuf-ultra-fast`, `jev-scout` queries the registry and returns 0 matching candidates:
```text
[jev-scout] Searching crates.io for "ringbuf-ultra-fast"...
[jev-scout] 0 verified crates found.
[GATE FAILED] Cannot add unverified dependency to implementation plan.
```
The agent is forced to use verified alternatives (`rigtorp`, `crossbeam-channel`, or std primitives).

---

### Phase 3: Plan Execution & Safety Guard (`jev-executing-plans`)

During execution, every shell command is screened by `jev-guard` before running:

```bash
# Safe command: passes instantly (<80ms)
jev-guard "cargo build --release"
# Output: PASS (destructive: 0.01)

# Dangerous command: caught and rejected
jev-guard "git reset --hard HEAD~5"
# Output:
# verdict: block
# top_hazard: destructive (0.96)
# [BLOCKED] Destructive command requires explicit user confirmation.
```

When changes are staged, `git-jev` verifies the diff before committing:
```bash
git add src/
git jev check
```

**Output:**
```text
✔ No secrets detected (p=0.02)
✔ No destructive payloads detected (p=0.01)
[PASS] Commit diff verified by git-jev.
```

---

### Phase 4: Systematic Debugging & Failure Triage (`jev-systematic-debugging`)

When builds or tests fail, piping the stderr into `jev-axi triage` categorizes the failure domain and pinpoints the root cause in under 120ms:

```bash
cargo test 2>&1 | jev-axi triage
```

**Output:**
```text
domain: type_mismatch
root_cause: Expected `u64` but found `usize` in buffer offset calculation at src/lib.rs:42
fix_direction: Cast index using `as u64` or modify struct field to `usize`.
```

---

### Phase 5: Verification Before Turn Completion (`jev-verification`)

Autonomous agents frequently say "All done!" while tests are broken or unexecuted. `jev-verification` clamps onto the agent loop:

1. **Anti-pattern audit**:
   ```bash
   supercov quality src
   ```
   Ensures zero weak files or architectural anti-patterns exist.

2. **Stop policy verification**:
   ```bash
   limpet check
   ```
   If acceptance criteria from the plan remain unproven, the agent cannot finish its turn.

---

## 3. Supported Agent Environments

Install once into your user directory, and all skills become accessible across:
* **Claude Code**: Loaded via `~/.agents/skills/`
* **Cursor**: Symlinked into `.cursor/rules/`
* **Codex CLI**: Native skill runner
* **Google Antigravity / Gemini CLI**: Direct skill discovery
* **Devin / OpenCode / Hermes / Pi**: Multi-agent harness compatible
