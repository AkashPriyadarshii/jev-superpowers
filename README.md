<!--
Title: jev-superpowers - Agentic Skills Upgraded with TypeSafe Jev System One
Description: Systematic software development framework for AI coding agents (Claude Code, Cursor, Codex, Antigravity) upgraded with TypeSafe Jev System One typed decisions, zero-hallucination package vetting, and completion gates.
Keywords: typesafe-ai, jev, superpowers, agentic-skills, claude-code, coding-agents, system-one, software-engineering, zero-hallucination, git-jev, jev-scout
-->

<div align="center">

# ⚡ jev-superpowers

**Systematic agentic software development upgraded with TypeSafe Jev System One typed decisions.**

[![License: MIT](https://img.shields.io/badge/License-MIT-0d9488.svg?style=flat-square)](LICENSE)
[![TypeSafe Jev](https://img.shields.io/badge/TypeSafe-Jev-0d9488.svg?style=flat-square)](https://typesafe.ai)
[![CI](https://img.shields.io/badge/CI-Passing-0d9488.svg?style=flat-square)](https://github.com/AkashPriyadarshii/jev-superpowers/actions)
[![Ecosystem](https://img.shields.io/badge/Skills-~%2F.agents%2Fskills-0d9488.svg?style=flat-square)](https://github.com/AkashPriyadarshii/jev-superpowers)

By **[Akash Priyadarshi](https://github.com/AkashPriyadarshii)**

[Why](#why) • [Core Superpowers](#core-superpowers) • [Quickstart](#quickstart) • [Architecture](#architecture) • [Non-Goals](#non-goals) • [Ecosystem](#ecosystem)

</div>

---

## Why

Autonomous coding agents equipped with standard development methodologies still fail in predictable, expensive ways:

* **Hallucinated Packages**: Agents invent fake npm packages or dead crates during implementation planning.
* **Arbitrary Architecture Guessing**: Agents flip coins on stack decisions and database choices during brainstorming without calibrated confidence.
* **Unchecked Destructive Execution**: Agents run destructive shell commands or push unverified git commits containing credentials or bugs.
* **Premature Turn Completion**: Agents declare tasks "done" based on optimistic assumptions rather than verified evidence.

`jev-superpowers` upgrades the battle-tested `obra/superpowers` methodology with **TypeSafe AI Jev System One** (`jev-1.13.0`). Every architectural fork, dependency selection, shell command, and completion check is gated by sub-second deterministic mathematical judgments.

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

## Quickstart

### 1. One-Line Installation

**Linux / macOS:**
```bash
curl -fsSL https://raw.githubusercontent.com/AkashPriyadarshii/jev-superpowers/master/install.sh | bash
```

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/AkashPriyadarshii/jev-superpowers/master/install.ps1 | iex
```

### 2. Configure Your ₹0 Jev API Key
```bash
export TYPESAFE_API_KEY="your_api_key"
# Windows PowerShell: $env:TYPESAFE_API_KEY = "your_api_key"
```
Get a free API key at [console.typesafe.ai](https://console.typesafe.ai).

### 3. Verification Output
Run the offline test suite:
```text
Running jev-superpowers offline verification suite...
  PASS: jev-using-superpowers has valid frontmatter
  PASS: jev-brainstorming has valid frontmatter
  PASS: jev-writing-plans has valid frontmatter
  PASS: jev-executing-plans has valid frontmatter
  PASS: jev-systematic-debugging has valid frontmatter
  PASS: jev-verification has valid frontmatter
  PASS: Cross-platform installers verified (install.sh, install.ps1)

Test results: 7 passed, 0 failed.
```

---

## Architecture

```
jev-superpowers/
├── .github/workflows/test.yml     # Automated offline validation
├── docs/PRD.md                    # Product requirements
├── docs/DESIGN.md                 # System design
├── docs/ARCHITECTURE.md           # Architecture flow
├── docs/HANDOFF.md                # Maintenance guide
├── memory/DECISIONS.md            # Jev decision log
├── scripts/test.ps1               # Windows test harness
├── scripts/test.sh                # Unix test harness
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
* **No cloud execution**: All checks run locally via native CLIs on your laptop.
* **No multi-agent swarm bloat**: Zero heavy orchestration frameworks or Docker containers.

---

## Ecosystem

* [design-genius](https://github.com/AkashPriyadarshii/design-genius) — Autonomous design system intelligence for web applications
* [akash-design-engineering](https://github.com/AkashPriyadarshii/akash-design-engineering) — High-performance editorial brutalist design tokens and cookbook
* [tdlib-android](https://github.com/AkashPriyadarshii/tdlib-android) — Precompiled TDLib native binaries for all 4 Android ABIs
* [kharcha](https://github.com/AkashPriyadarshii/kharcha) — India-first offline-first UPI expense tracker for Android

---

## Author

**Akash Priyadarshi**  
Patna, Bihar, India  
* GitHub: [@AkashPriyadarshii](https://github.com/AkashPriyadarshii)  
* Portfolio: [akashpriyadarshi.vercel.app](https://akashpriyadarshi.vercel.app)  
* LinkedIn: [Akash Priyadarshi](https://linkedin.com/in/akash-priyadarshi-1aa51b37a)  
* Resume: [akashpriyadarshii.github.io/Resume](https://akashpriyadarshii.github.io/Resume/)  

**Social:** [X / Twitter](https://x.com/Akash__ydv001) • [Threads](https://www.threads.net/@akash.priyadarshii) • [Instagram](https://www.instagram.com/akash.priyadarshii/) • [Reddit](https://reddit.com/user/DragonfruitWeak2801)

---

*Built with TypeSafe AI System One models for zero-hallucination autonomous engineering.*
