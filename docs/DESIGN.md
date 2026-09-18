# System Design - jev-superpowers

## 1. Architectural Philosophy
Following Ponytail principles:
- **Reuse Existing CLIs**: Rather than introducing a bloated binary, `jev-superpowers` orchestrates established tools on PATH (`jev-scout`, `jev-axi`, `git-jev`, `jev-guard`, `supercov`).
- **Coexistence over Disruption**: Skills live in a `jev-*` namespace, allowing engineers to retain standard `superpowers` alongside Jev gates.

## 2. Gate Specifications

### A. Convergence Gate (`jev-axi pick`)
- **Inputs**: Options list, instructions, context text.
- **Output**: Picked option, probability distribution, confidence score (0.0–1.0).
- **Threshold**: Requires confidence $\ge 0.80$ for autonomous recommendation; requires human tie-break when confidence $< 0.80$.

### B. Dependency Vetting Gate (`jev-scout`)
- **Inputs**: Package/library requirement query.
- **Output**: Ranked candidates with Fit Score (1.0–4.0) and Active maintenance probability.
- **Threshold**: Candidate Fit $\ge 2.0/4.0$, Maintenance $p > 0.50$.

### C. Reflex Gate (`git-jev`)
- **Inputs**: Staged git diff (`git diff --staged` or `git show HEAD`).
- **Output**: Secret leak probability ($p < 0.10$), Destructive payload probability ($p < 0.10$).
- **Threshold**: Fails pre-commit when $p \ge 0.10$.

### D. Anti-Pattern & Quality Gate (`supercov quality`)
- **Inputs**: Source code tree.
- **Output**: Anti-pattern judgment (duplicated logic, deep nesting, magic values).
- **Threshold**: 0 weak files required before turn completion.
