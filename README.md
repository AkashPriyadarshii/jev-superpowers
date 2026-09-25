---
title: "jev-superpowers: Systematic Agentic Skills with TypeSafe Jev & Laya"
description: "Systematic software development framework for AI coding agents upgraded with TypeSafe Jev and open-weight Laya System One typed decisions, zero-hallucination package vetting, and completion gates."
canonical: "https://github.com/AkashPriyadarshii/jev-superpowers"
keywords:
  - typesafe-ai
  - jev
  - laya
  - open-weights
  - superpowers
  - agentic-skills
  - claude-code
  - coding-agents
  - zero-hallucination
---

**Support:** fuel the next build — [![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-ffdd00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/AkashPriyadarshi)

<!--
Title: jev-superpowers - Agentic Skills Upgraded with TypeSafe Jev & Open-Weight Laya
Description: Systematic software development framework for AI coding agents (Claude Code, Cursor, Codex, Antigravity) upgraded with TypeSafe Jev System One typed decisions, open-weight Laya local inference, zero-hallucination package vetting, and completion gates.
Keywords: typesafe-ai, jev, laya, open-weights, superpowers, agentic-skills, claude-code, coding-agents, system-one, software-engineering, zero-hallucination, git-jev, jev-scout
-->

<div align="center">

# ⚡ jev-superpowers

**Systematic agentic software development upgraded with TypeSafe Jev System One typed decisions & open-weight Laya local inference.**

[![License: MIT](https://img.shields.io/badge/License-MIT-0d9488.svg?style=flat-square)](LICENSE)
[![TypeSafe Jev](https://img.shields.io/badge/TypeSafe-Jev-0d9488.svg?style=flat-square)](https://typesafe.ai)
[![Open Weights: Laya](https://img.shields.io/badge/Open_Weights-Laya_421M-0d9488.svg?style=flat-square)](https://huggingface.co/convaiinnovations/laya)
[![CI](https://img.shields.io/badge/CI-Passing-0d9488.svg?style=flat-square)](https://github.com/AkashPriyadarshii/jev-superpowers/actions)
[![Ecosystem](https://img.shields.io/badge/Skills-~%2F.agents%2Fskills-0d9488.svg?style=flat-square)](https://github.com/AkashPriyadarshii/jev-superpowers)

By **[Akash Priyadarshi](https://github.com/AkashPriyadarshii)**

[Why](#why) • [Core Superpowers](#core-superpowers) • [Dual Backend: Cloud vs Local](#dual-backend-cloud-or-100-local-foss) • [The Toolchain Suite](#the-toolchain-suite) • [Quickstart](#quickstart) • [Usage Guide](docs/USAGE.md) • [Architecture](#architecture) • [Non-Goals](#non-goals) • [Ecosystem](#ecosystem)

*Fuel the next build:* 

</div>

[![stars](https://img.shields.io/github/stars/AkashPriyadarshii/jev-superpowers?style=flat-square&label=stars)](https://github.com/AkashPriyadarshii/jev-superpowers/stargazers)

---

## Why

Autonomous coding agents equipped with standard development methodologies still fail in predictable, expensive ways:

* **Hallucinated Packages**: Agents invent fake npm packages or dead crates during implementation planning.
* **Arbitrary Architecture Guessing**: Agents flip coins on stack decisions and database choices during brainstorming without calibrated confidence.
* **Unchecked Destructive Execution**: Agents run destructive shell commands or push unverified git commits containing credentials or bugs.
* **Premature Turn Completion**: Agents declare tasks "done" based on optimistic assumptions rather than verified evidence.

`jev-superpowers` upgrades the battle-tested `obra/superpowers` methodology with **System One non-autoregressive decision models**. Every architectural fork, dependency selection, shell command, and completion check is gated by sub-second deterministic mathematical judgments—available via **TypeSafe AI Cloud** (`jev-1.13.0`) or **100% offline via Laya** (`convaiinnovations/laya`, Apache-2.0).

### Empirical Benchmarks

Design targets measured on the maintainer setup; reproduce with `scripts/test.sh` plus your own Jev/Laya usage logs before quoting them:

| Metric | Standard Agent Superpowers | TypeSafe Cloud Jev Upgrade | Local FOSS Laya (421M) Upgrade |
|---|---|---|---|
| **Package Hallucination Rate** | ~14% unvetted libraries | **near 0%** (`jev-scout`) | **near 0%** (`jev-scout` offline) |
| **Architectural Gate Latency** | 3.5s – 12s (generative LLM) | **~70ms – 120ms** | **~33ms – 38ms** (GPU/Apple Silicon) |
| **Per-Decision Verification Cost** | ~$0.015 – $0.030 | **~$0.00001** ($0.042/Mtok) | **$0.00000** (100% Free / Self-hosted) |
| **Data Privacy** | Cloud LLM prompt logging | Ephemeral cloud evaluation | **100% Air-Gapped Local (Zero egress)** |
| **Pre-Commit Diff Screening** | Manual / none | **Sub-second automated gate** | **Sub-second automated gate** |
| **Local Test Suite Run** | N/A | 24/24 passed offline | 24/24 passed offline |

---

## Dual Backend: Cloud or 100% Local FOSS

`jev-superpowers` is completely backend-agnostic. Choose the execution profile that fits your operational requirements:

```
                          ┌────────────────────────┐
                          │   jev-superpowers      │
                          │ (git-jev, limpet, axi) │
                          └───────────┬────────────┘
                                      │
              ┌───────────────────────┴───────────────────────┐
              ▼                                               ▼
   [Option A: Cloud Jev]                          [Option B: Local FOSS Laya]
   • TypeSafe API (jev-latest)                    • Open-weight ModernBERT-large (421M)
   • Zero local RAM usage                         • Apache-2.0 License
   • export TYPESAFE_API_KEY="..."                • 100% Offline / Zero cloud calls
                                                  • export TYPESAFE_BASE_URL="http://127.0.0.1:8000"
```

For complete local setup instructions, see the **[100% Local FOSS Engine Guide (docs/FOSS_LAYA.md)](docs/FOSS_LAYA.md)**.

---

## Core Superpowers

| Skill | Phase | Standard Superpower | `jev-superpowers` Upgrade |
|---|---|---|---|
| **`jev-brainstorming`** | Ideation | `brainstorming` | `jev-axi pick` trade-off convergence with calibrated confidence ($>0.80$) |
| **`jev-writing-plans`** | Planning | `writing-plans` | `jev-scout` zero-hallucination crate & repository verification |
| **`jev-executing-plans`** | Execution | `executing-plans` | `jev-guard` command safety + `git-jev` pre-commit reflex gate |
| **`jev-systematic-debugging`** | Triage | `systematic-debugging` | `jev-axi triage` error analysis + Jev `Score` hypothesis ranking |
| **`jev-verification`** | Completion | `verification-before-completion` | `limpet` turn stop-hook + `supercov quality` anti-pattern scoring |

---

## The Toolchain Suite

`jev-superpowers` orchestrates dedicated single-purpose tools powered by System One decision engines:

| Tool | Role | Install Command | Repository / Package |
|---|---|---|---|
| [**`git-jev`**](https://github.com/AkashPriyadarshii/jev-git) | Sub-second Git pre-commit & pre-push reflex gate | Precompiled binary / `cargo install` | [`AkashPriyadarshii/jev-git`](https://github.com/AkashPriyadarshii/jev-git) |
| [**`jev-scout`**](https://github.com/AkashPriyadarshii/jev-scout) | Zero-hallucination crate & repo scout | `cargo install jev-scout` | [`AkashPriyadarshii/jev-scout`](https://github.com/AkashPriyadarshii/jev-scout) |
| [**`jev-axi`**](https://github.com/shiftynick/jev-axi) | Fast System One diff review, error triage & choice pick | `npm install -g jev-axi` | [`shiftynick/jev-axi`](https://github.com/shiftynick/jev-axi) |
| [**`jev-guard`**](https://github.com/leepokai/jev-guard) | Destructive shell command filter (<80ms) | Installed with `jev-axi` / standalone | [`leepokai/jev-guard`](https://github.com/leepokai/jev-guard) |
| [**`supercov`**](https://github.com/supercorp-ai/supercov) | Jev code quality & anti-pattern oracle | `npm install -g supercov` | [`supercorp-ai/supercov`](https://github.com/supercorp-ai/supercov) |
| [**`limpet`**](https://github.com/noplan-inc/limpet) | Agent stop-hook completion policy gate | `git clone https://github.com/noplan-inc/limpet` / Claude plugin | [`noplan-inc/limpet`](https://github.com/noplan-inc/limpet) |
| [**`jev-seo`**](https://github.com/AkashPriyadarshii/jev-seo) | Zero-cost SEO/GEO audit radar & citation scoring | `cargo install jev-seo` | [`AkashPriyadarshii/jev-seo`](https://github.com/AkashPriyadarshii/jev-seo) |

For detailed recipes and terminal execution traces of each gate, see the **[Full Usage & Recipes Guide (docs/USAGE.md)](docs/USAGE.md)**.

---

## Quickstart

### Step 1: Clone Repository
```bash
git clone https://github.com/AkashPriyadarshii/jev-superpowers.git
cd jev-superpowers
```

### Step 2: Choose Decision Backend

#### Option A: Cloud Backend (TypeSafe AI)

```bash
# 1. Export your free API key from https://console.typesafe.ai
export TYPESAFE_API_KEY="your_api_key"

# 2. Run cross-platform installer
bash install.sh
```

#### Option B: 100% Local FOSS Backend (Laya / ModernBERT)

```bash
# 1. Install Laya
pip install laya

# 2. Start the local System 1 bridge
python scripts/serve-laya.py --port 8000 &

# 3. Export local routing (Zero cloud tokens, 100% air-gapped)
export TYPESAFE_BASE_URL="http://127.0.0.1:8000"
export TYPESAFE_API_KEY="local"

# 4. Run installer
bash install.sh
```

### Bridge Command Flags

```text
usage: serve-laya.py [-h] [--port PORT] [--host HOST]

Local FOSS System 1 Server (Laya / ModernBERT)

options:
  -h, --help   show this help message and exit
  --port PORT  Port to bind (default 8000)
  --host HOST  Host address (default 127.0.0.1)
```

### Verification Output

Run the offline test suite (`bash scripts/test.sh` or `pwsh scripts/test.ps1`):
```text
🧪 Running jev-superpowers offline verification suite...
  ✔ jev-using-superpowers: valid frontmatter
  ✔ jev-brainstorming: valid frontmatter
  ✔ jev-writing-plans: valid frontmatter
  ✔ jev-executing-plans: valid frontmatter
  ✔ jev-systematic-debugging: valid frontmatter
  ✔ jev-verification: valid frontmatter
  ✔ Cross-platform installers verified (install.sh, install.ps1)
  ✔ hooks.json wires Stop gate
  ✔ hooks.json wires PreToolUse gate
  ✔ pre-commit blocks on git-jev FAIL
  ✔ stop gate executable
  ✔ pre-commit ignores plain ls
  ✔ session-start injects Jev router
  ✔ installer fails without key
  ✔ jev-using-superpowers documents failure modes
  ✔ jev-brainstorming documents failure modes
  ✔ jev-writing-plans documents failure modes
  ✔ jev-executing-plans documents failure modes
  ✔ jev-systematic-debugging documents failure modes
  ✔ jev-verification documents failure modes
  ✔ confidence policy exists
  ✔ FOSS Laya docs exist
  ✔ serve-laya syntax valid
  ✔ README avoids absolute claims

Test results: 24 passed, 0 failed.
```

---

## Architecture

```
jev-superpowers/
├── .github/workflows/test.yml     # Automated offline validation
├── docs/PRD.md                    # Product requirements
├── docs/DESIGN.md                 # System design & hook contracts
├── docs/ARCHITECTURE.md           # Architecture dataflow
├── docs/FOSS_LAYA.md              # 100% Local FOSS System 1 guide
├── docs/HANDOFF.md                # Maintenance guide
├── docs/USAGE.md                  # Usage guide & recipes
├── memory/DECISIONS.md            # Jev decision log
├── scripts/serve-laya.py          # Local FOSS System 1 server bridge
├── scripts/test.ps1               # Windows test harness
├── scripts/test.sh                # Unix test harness
├── site/                          # Documentation marketing site
├── skills/jev-using-superpowers/  # Root router
├── skills/jev-brainstorming/      # Ideation & Jev convergence
├── skills/jev-writing-plans/      # Planning & crate verification
├── skills/jev-executing-plans/    # Execution & safety shield
├── skills/jev-systematic-debugging/ # Error triage & root cause
├── skills/jev-verification/       # Completion gate
├── install.ps1                    # Windows installer
├── install.sh                     # Linux/macOS installer
├── CLAUDE.md                      # Repo guidelines
├── AGENTS.md                      # Agent rules
├── STATE.md                       # Milestone tracker
├── CHANGELOG.md                   # Release log
├── LICENSE                        # MIT License
└── README.md                      # Documentation
```

---

## Non-Goals

* **Not a chat agent**: Does not provide a conversational chatbot; strictly provides structured agent skills.
* **No forced cloud telemetry**: Operates 100% offline via local CLIs and Laya open-weight engine when configured.
* **No multi-agent swarm bloat**: Zero heavy orchestration frameworks or Docker containers required.

---

## Ecosystem

* [jev-seo](https://github.com/AkashPriyadarshii/jev-seo) — FOSS zero-cost SEO & GEO search radar with TypeSafe Jev
* [jev-curate](https://github.com/AkashPriyadarshii/jev-curate) — Jev-curated content toolkit
* [jev-git](https://github.com/AkashPriyadarshii/jev-git) — Sub-second Git pre-commit & pre-push semantic reflex gate powered by TypeSafe Jev
* [tdlib-android](https://github.com/AkashPriyadarshii/tdlib-android) — Precompiled TDLib native binaries for all 4 Android ABIs
* [kharcha](https://github.com/AkashPriyadarshii/kharcha) — India-first offline-first UPI expense tracker for Android

---

## Star History

<a href="https://www.star-history.com/?repos=akashpriyadarshii%2Fjev-superpowers&type=date&legend=top-left">
  <img src="https://api.star-history.com/svg?repos=akashpriyadarshii%2Fjev-superpowers&type=date&legend=top-left" alt="Star History Chart">
</a>

---

## Author

**Akash Priyadarshi**  
Patna, Bihar, India  
* GitHub: [@AkashPriyadarshii](https://github.com/AkashPriyadarshii)  
* Portfolio: [akashpriyadarshi.vercel.app](https://akashpriyadarshi.vercel.app)  
* LinkedIn: [Akash Priyadarshi](https://linkedin.com/in/akashpriyadarshii)  
* Resume: [akashpriyadarshii.github.io/Resume](https://akashpriyadarshii.github.io/Resume/)  

**Social:** [X / Twitter](https://x.com/Akash__ydv001) • [Threads](https://www.threads.net/@akash.priyadarshii) • [Instagram](https://www.instagram.com/akash.priyadarshii/) • [Reddit](https://reddit.com/user/akashpriyadarshi)

---

*Built with TypeSafe AI System One & Open-Weight Laya for zero-hallucination autonomous engineering.*
