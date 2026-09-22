# DESIGN.md — jev-superpowers landing & hub

Spec for `site/`. Static, zero build step, multi-page hub-and-spoke topology.

## Intent

Developer-tool landing and documentation hub for AI coding agent practitioners, software engineers, and autonomous agent loops (Claude Code, Cursor, Codex, OpenCode, Devin, Gemini CLI, Hermes).
Purpose: index visibility, GEO presence, clear technical authority, and a zero-slop home for the `jev-superpowers` framework.
Read: *warm-light Innocent language, flat pink-on-white, TypeSafe brand.*

Dials: `VARIANCE 5 / MOTION 4 / DENSITY 4`.

## Palette

Substrate `#fefefe` (OKLCH 0.99 0 0), ink `#000000`. Accent pink `#f386a1`
(OKLCH 0.77 0.15 0.025), deep accent magenta `#d45bb6` (OKLCH 0.64 0.27 0.34).
Small-text accent `#a2278f` (AA verified 6.5:1 on white).
Greys: `#1e1e1e` hairline, `#dedede` border, `#c4c4c4` muted, `#abbab9` faint chip substrate.

Primary pink appears sparingly: primary CTA button and terminal status dot. Never body
copy. Verified pairs: black on pink 8.74:1 AAA, black on white 21:1, ink on white
17.5:1 AAA, deep magenta `#a2278f` on white 6.5:1 AA for small text and badges.

## Type

Local fallbacks deliver universally without network lag or external Google font blocking.

| Role | Stack | Weight |
|---|---|---|
| Display | "LisaTerminal Paper 2X3Y Medium", "Book Antiqua", Georgia, serif | 500 |
| Body | "Die Grotesk C Regular", Candara, "Segoe UI", sans-serif | 400 |
| Code | "JetBrains Mono", Cascadia Mono, Consolas, monospace | 400/500 |

Scale: 68 hero display, 40 section H2, 28 sub, 20 lead, 18 body, 16 meta, 14 label, 13 code. Line-height display 1.05, body 1.6, code 1.5.

## Space, Shape, Motion

- Spacing base 5px; rhythm 5/20/30/40/60/80/100/200. Section padding 100px vertical, 24px horizontal on mobile.
- Radius 4px everywhere (buttons, code cards, terminal, chips, step indicators).
- Single hard shadow: `2px 2px 0 rgba(0,0,0,0.4)` for cards and hero terminal. Zero blur, zero glassmorphism, zero gradients.
- Motion: 50ms hover press (`transform: translate(1px, 1px)`), 200ms ease transitions (`cubic-bezier(0.16, 1, 0.3, 1)`). Full support for `prefers-reduced-motion`.

## Topology & Hub-and-Spoke Architecture

Hub page:
1. `index.html`: Main landing, terminal gate simulation, failure mode breakdown, 6 Jev skills, quickstart, 6 steps, cost/speed stat bar, author slab, ecosystem footer.

Spoke pages:
2. `benchmarks.html`: 22/22 offline test verification, gate latency (70-120ms), token cost comparison table.
3. `what-is-jev.html`: System One typed decision engine primer (Choice, Score, Noul vs chat generation).
4. `comparison.html`: jev-superpowers vs unguided coding agents (hallucination, premature stops, destructive commands).
5. `comparison-tools.html`: jev-superpowers vs generic prompt packs & raw agent frameworks.
6. `use-cases.html`: Dependency vetting, pre-commit reflex gates, root-cause error triage, stop-policy enforcement.
7. `glossary.html`: Semantic definitions for GEO/SEO (Choice, Score, Noul, git-jev, jev-guard, limpet, supercov).
8. `about.html`: Origin, philosophy, author background (Akash Priyadarshi).
9. `contact.html`: Community issue tracker, direct developer contacts.
10. `privacy.html`: Zero telemetry, zero cloud logging, local hook execution guarantees.

## Contracts & Anti-Slop
- Zero simulation: 22/22 tests verified from `scripts/test.sh`, TypeSafe pricing from model specs ($0.042/M tokens).
- HTML5 semantic structure: `<header>`, `<nav>`, `<main>`, `<section>`, `<article>`, `<footer>`.
- JavaScript footprint: under 50 LOC, zero dependencies, vanilla copy-to-clipboard and accessible hamburger drawer.
- Prohibited patterns: no purple/blue gradients, no rounded pills, no Inter/Roboto fallback defaults, no emoji in UI buttons/labels.
