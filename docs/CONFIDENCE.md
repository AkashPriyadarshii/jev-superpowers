# Confidence Policy (single source of truth)

Every Jev verdict in these skills gates on calibrated confidence, not on the
choice alone. Thresholds below; tune here, nowhere else.

| Situation | Act (do it) | Confirm (ask human) | Stop (do not act) |
|---|---|---|---|
| `pick` recommendation | ≥ 0.80 | 0.50–0.80, human tie-breaks | < 0.50, gather requirements |
| Destructive shell (`jev-guard`) | clear | flagged → explicit confirm | always confirm, never auto-run |
| Commit gate (`git jev`) | `[PASS]` and p < 0.10 | any flag → fix first | never commit on FAIL |
| Debug hypothesis | p > 0.70, top pick | all < 0.70 → collect more evidence | never blind-fix |
| Missing tool / key / offline | — | — | STOP, print install line |

Rules: confidence is per-answer distribution concentration, not permission.
A near-tie (e.g. 0.56/0.44) is low confidence even with a clear winner.
Unknown branches are ignored, never gated. Thresholds are starting values;
validate against your own reviewed cases.
