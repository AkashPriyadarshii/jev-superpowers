# System Architecture - jev-superpowers

## Component Interaction Flow

```
                      [User Prompt / Feature Goal]
                                    │
                                    ▼
                    ┌───────────────────────────────┐
                    │     jev-using-superpowers     │
                    └───────────────┬───────────────┘
                                    │
        ┌───────────────────────────┼───────────────────────────┐
        ▼                           ▼                           ▼
┌───────────────┐           ┌───────────────┐           ┌───────────────┐
│ jev-brainstorm│           │jev-writing-pln│           │jev-debugging  │
│   (Ideate)    │           │    (Plan)     │           │   (Triage)    │
└───────┬───────┘           └───────┬───────┘           └───────┬───────┘
        │                           │                           │
        ▼                           ▼                           ▼
 [jev-axi pick]               [jev-scout]               [jev-axi triage]
(Tradeoff Gate)             (Crate Vetting)            (Hypothesis Rank)
        │                           │                           │
        └───────────────────────────┼───────────────────────────┘
                                    │
                                    ▼
                    ┌───────────────────────────────┐
                    │      jev-executing-plans      │
                    │ (jev-guard & git-jev reflex)  │
                    └───────────────┬───────────────┘
                                    │
                                    ▼
                    ┌───────────────────────────────┐
                    │       jev-verification        │
                    │ (supercov quality & limpet)   │
                    └───────────────────────────────┘
```

## Directory Tree
```
jev-superpowers/
├── .github/workflows/test.yml     # Automated offline validation
├── docs/                          # Technical specifications
│   ├── PRD.md
│   ├── DESIGN.md
│   ├── ARCHITECTURE.md
│   └── HANDOFF.md
├── memory/
│   └── DECISIONS.md              # Jev decision log
├── scripts/
│   ├── test.ps1                  # Windows offline test runner
│   └── test.sh                   # Unix offline test runner
├── skills/
│   ├── jev-using-superpowers/    # Root router
│   ├── jev-brainstorming/        # Ideation & Jev convergence
│   ├── jev-writing-plans/        # Planning & crate verification
│   ├── jev-executing-plans/      # Execution & safety shield
│   ├── jev-systematic-debugging/ # Error triage & root cause
│   └── jev-verification/         # Completion gate
├── install.ps1                   # Windows installer
├── install.sh                    # Linux/macOS installer
├── CLAUDE.md                     # Repo instructions
├── AGENTS.md                     # Agent rules
├── STATE.md                      # Milestone tracker
├── CHANGELOG.md                  # Release log
├── LICENSE                       # MIT License
└── README.md                     # Standard documentation
```
