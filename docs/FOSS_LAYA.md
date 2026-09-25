# 100% Local & FOSS System 1 Engine: Laya

`jev-superpowers` is designed to be **backend-agnostic**. While the default cloud backend uses TypeSafe AI's hosted `jev-1.13.0` API, you can run the entire agent toolchain **100% offline and free** using **Laya**—an open-weight, non-autoregressive System 1 decision engine.

---

## What is Laya?

- **Model**: [Laya](https://huggingface.co/convaiinnovations/laya) (`convaiinnovations/laya` on Hugging Face, PyPI `laya`).
- **License**: **Apache-2.0** (Open Source).
- **Architecture**: 421M parameter model with a `ModernBERT-large` (395M) bidirectional backbone and a 2-layer decision head.
- **Latency**: ~33–38 ms on GPU, ~13.4 ms on Apple Silicon via `laya-mlx`, ~60–80 ms on modern x86 CPUs.
- **Output**: Returns typed decisions (`Choice`, `Score`, `Noul`) with mathematically calibrated probabilities in a single forward pass. Zero tokens generated. Zero parsing errors.

| Dimension | TypeSafe Cloud Jev | Local Laya Engine |
|---|---|---|
| **Weights** | Proprietary Cloud API | **Open Weights (Apache-2.0)** |
| **Data Privacy** | Cloud API transport | **100% Local / Air-gapped (Zero egress)** |
| **Token Cost** | $0.042 / Mtok | **$0.00 (Free forever)** |
| **P50 Latency** | 70–150 ms | **33–38 ms** |
| **Memory Footprint** | 0 MB local | ~850 MB RAM |

---

## Quickstart: Running 100% Locally

### 1. Install Laya
```bash
pip install laya
```
*(On macOS Apple Silicon, you can also use `pip install laya-mlx` for hardware-accelerated Metal inference).*

### 2. Start the System 1 Local Bridge
We provide a lightweight, zero-dependency bridge script that exposes the standard `POST /v1/systemone` endpoint:

```bash
python scripts/serve-laya.py --port 8000
```

Verify it is active:
```bash
curl http://127.0.0.1:8000/health
```

### 3. Configure Your Environment
Set `TYPESAFE_BASE_URL` to your local endpoint and assign any dummy string to `TYPESAFE_API_KEY` to satisfy client tool validation:

```bash
export TYPESAFE_BASE_URL="http://127.0.0.1:8000"
export TYPESAFE_API_KEY="local"
```

In PowerShell (Windows):
```powershell
$env:TYPESAFE_BASE_URL = "http://127.0.0.1:8000"
$env:TYPESAFE_API_KEY = "local"
```

### 4. Install jev-superpowers
Run the installer with the local environment set:
```bash
bash install.sh
```
The installer automatically detects `TYPESAFE_BASE_URL` and enables local FOSS mode without requiring cloud registration.

---

## Compatible Tooling

All Jev reflex gates in this repository honor `TYPESAFE_BASE_URL`:

1. **`git-jev`**: Verifies staged commits locally before git commit.
2. **`limpet`**: Runs turn-completion stop gates against the local Laya engine.
3. **`jev-axi`**: Performs diff triage and log analysis offline.
4. **`jev-guard`**: Inspects shell commands before execution.

---

## Zero-Dependency Dev Mode (Fallback)

If you have not downloaded the 421M model weights yet or are running in an environment with limited RAM, `scripts/serve-laya.py` automatically runs in lightweight heuristic mode. This allows you to test scripts, CI pipelines, and agent workflows without internet access or GPU acceleration.
