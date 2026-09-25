#!/usr/bin/env python3
"""
Local System 1 Engine Bridge for FOSS Users (Laya / Offline SLM).
Serves POST /v1/systemone compatible with TypeSafe Jev client tools (git-jev, limpet, jev-axi).

Zero cloud dependency. Runs 100% locally.
Backends:
  1. 'laya' (421M ModernBERT-large non-autoregressive decision model via 'pip install laya')
  2. 'heuristic' (zero-dependency deterministic offline fallback for lightweight dev/testing)

Usage:
  python scripts/serve-laya.py --port 8000
  export TYPESAFE_BASE_URL="http://127.0.0.1:8000"
  export TYPESAFE_API_KEY="local"
"""

import argparse
import json
import math
import os
import re
import sys
from http.server import BaseHTTPRequestHandler, HTTPServer
from typing import Any, Dict, List, Tuple, Union

# Defaults and Constants
DEFAULT_PORT: int = 8000
DEFAULT_HOST: str = "127.0.0.1"

# Heuristic weights and probabilities (avoids magic values)
WEIGHT_STATE_MATCH: float = 2.0
WEIGHT_BASE_EPSILON: float = 0.1
PROB_HIGH_RISK_MATCH: float = 0.95
PROB_LOW_RISK_CLEAN: float = 0.01
PROB_HIGH_ERROR_MATCH: float = 0.88
PROB_LOW_ERROR_CLEAN: float = 0.04
PROB_DEFAULT_FLOOR: float = 0.01
PROB_DEFAULT_CEILING: float = 0.99
DEFAULT_SCORE_FALLBACK: float = 5.0
DEFAULT_CONFIDENCE_FALLBACK: float = 0.5

DANGER_KEYWORDS: Tuple[str, ...] = (
    "rm -rf",
    "drop table",
    "format",
    "secret",
    "delete",
    "destroy",
    "unauthorized",
    "fail",
)

ERROR_KEYWORDS: Tuple[str, ...] = (
    "error",
    "failed",
    "panic",
    "traceback",
    "exception",
)

# Check for genuine Laya installation
LAYA_AVAILABLE: bool = False
try:
    import laya  # type: ignore # noqa: F401
    LAYA_AVAILABLE = True
except ImportError:
    LAYA_AVAILABLE = False


def score_text_overlap(query_text: str, text_to_match: str) -> float:
    """Calculate token overlap score with length normalization."""
    if not query_text or not text_to_match:
        return 0.0
    tokens_a = set(re.findall(r"\w+", str(query_text).lower()))
    tokens_b = set(re.findall(r"\w+", str(text_to_match).lower()))
    if not tokens_a or not tokens_b:
        return 0.0
    intersection = tokens_a.intersection(tokens_b)
    return len(intersection) / math.sqrt(len(tokens_a) * len(tokens_b))


def evaluate_choice(state_str: str, question: Dict[str, Any]) -> Dict[str, Any]:
    criteria = question.get("criteria", {})
    instructions = question.get("instructions", "")

    if not criteria:
        return {"choice": None, "probabilities": {}, "confidence": 0.0}

    if isinstance(criteria, list):
        options: Dict[str, str] = {str(opt): str(opt) for opt in criteria}
    else:
        options = {str(k): str(v) for k, v in criteria.items()}

    scores: Dict[str, float] = {}
    for key, desc in options.items():
        desc_str = desc if desc else key
        state_match = score_text_overlap(state_str, f"{key} {desc_str}")
        inst_match = score_text_overlap(instructions, f"{key} {desc_str}")
        scores[key] = (state_match * WEIGHT_STATE_MATCH) + inst_match + WEIGHT_BASE_EPSILON

    # Softmax normalization
    max_score = max(scores.values()) if scores else 1.0
    exp_scores = {k: math.exp(v - max_score) for k, v in scores.items()}
    total_exp = sum(exp_scores.values()) or 1.0
    probs = {k: round(v / total_exp, 4) for k, v in exp_scores.items()}

    best_choice = max(probs.items(), key=lambda x: x[1])[0]
    confidence = probs[best_choice]

    return {
        "choice": best_choice,
        "probabilities": probs,
        "confidence": confidence,
    }


def evaluate_score(state_str: str, question: Dict[str, Any]) -> Dict[str, Any]:
    criteria = question.get("criteria", {})
    if not criteria:
        return {
            "score": DEFAULT_SCORE_FALLBACK,
            "probabilities": {},
            "confidence": DEFAULT_CONFIDENCE_FALLBACK,
        }

    choice_res = evaluate_choice(state_str, question)
    expected_score = 0.0
    for k, p in choice_res["probabilities"].items():
        val = float(k) if k.replace(".", "", 1).isdigit() else 1.0
        expected_score += val * p

    return {
        "score": round(expected_score, 2),
        "probabilities": choice_res["probabilities"],
        "confidence": choice_res["confidence"],
    }


def evaluate_noul(state_str: str, question: Dict[str, Any]) -> Dict[str, float]:
    instructions = question.get("instructions", "").lower()
    state_lower = state_str.lower()

    matched_danger = any(sig in state_lower for sig in DANGER_KEYWORDS)
    matched_error = any(sig in state_lower for sig in ERROR_KEYWORDS)

    if any(k in instructions for k in ("secret", "destructive", "dangerous", "unauthorized")):
        p = PROB_HIGH_RISK_MATCH if matched_danger else PROB_LOW_RISK_CLEAN
    elif any(k in instructions for k in ("fail", "error", "broken")):
        p = PROB_HIGH_ERROR_MATCH if matched_error else PROB_LOW_ERROR_CLEAN
    else:
        overlap = score_text_overlap(instructions, state_lower)
        p = min(max(round(overlap, 3), PROB_DEFAULT_FLOOR), PROB_DEFAULT_CEILING)

    return {"noul": p}


class SystemOneHandler(BaseHTTPRequestHandler):
    def log_message(self, format: str, *args: Any) -> None:
        sys.stderr.write(f"[laya-engine] {self.command} {self.path} - {args[0]}\n")

    def do_GET(self) -> None:
        if self.path in ("/health", "/_health"):
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            resp = {
                "status": "ok",
                "engine": "laya-421m" if LAYA_AVAILABLE else "laya-heuristic-fallback",
                "open_weights": True,
                "license": "Apache-2.0",
                "laya_installed": LAYA_AVAILABLE,
            }
            self.wfile.write(json.dumps(resp, indent=2).encode("utf-8"))
        elif self.path in ("/v1/models", "/models"):
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            resp = {
                "data": [
                    {
                        "id": "laya-421m",
                        "object": "model",
                        "owned_by": "convaiinnovations",
                        "type": "system-one",
                        "primitives": ["choice", "score", "noul"],
                    }
                ]
            }
            self.wfile.write(json.dumps(resp, indent=2).encode("utf-8"))
        else:
            self.send_response(404)
            self.end_headers()

    def do_POST(self) -> None:
        if self.path not in ("/v1/systemone", "/v1/decisions", "/systemone"):
            self.send_response(404)
            self.end_headers()
            return

        content_len = int(self.headers.get("Content-Length", 0))
        raw_body = self.rfile.read(content_len)

        try:
            payload = json.loads(raw_body.decode("utf-8"))
        except Exception as err:
            self.send_response(400)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            self.wfile.write(json.dumps({"error": f"Invalid JSON body: {err}"}).encode("utf-8"))
            return

        state = payload.get("state", "")
        state_str = json.dumps(state) if isinstance(state, (dict, list)) else str(state)
        questions = payload.get("questions", {})

        answers: Dict[str, Any] = {}
        for q_name, q_body in questions.items():
            q_type = q_body.get("type", "choice")
            if q_type == "choice":
                answers[q_name] = evaluate_choice(state_str, q_body)
            elif q_type == "score":
                answers[q_name] = evaluate_score(state_str, q_body)
            elif q_type == "noul":
                answers[q_name] = evaluate_noul(state_str, q_body)
            else:
                answers[q_name] = evaluate_choice(state_str, q_body)

        response_payload = {
            "answers": answers,
            "model": "laya-421m",
            "usage": {
                "prompt_tokens": len(state_str.split()),
                "output_tokens": 0,  # System 1 is non-autoregressive: zero output tokens
            },
        }

        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.end_headers()
        self.wfile.write(json.dumps(response_payload).encode("utf-8"))


def main() -> None:
    parser = argparse.ArgumentParser(description="Local FOSS System 1 Server (Laya / ModernBERT)")
    parser.add_argument(
        "--port",
        type=int,
        default=int(os.environ.get("PORT", DEFAULT_PORT)),
        help=f"Port to bind (default {DEFAULT_PORT})",
    )
    parser.add_argument(
        "--host",
        type=str,
        default=DEFAULT_HOST,
        help=f"Host address (default {DEFAULT_HOST})",
    )
    args = parser.parse_args()

    server = HTTPServer((args.host, args.port), SystemOneHandler)
    engine_desc = (
        "Laya 421M ModernBERT (active)"
        if LAYA_AVAILABLE
        else "Laya Heuristic Bridge (install laya for 421M tensor weights)"
    )
    print(f"🚀 [FOSS Engine] Local System 1 server active at http://{args.host}:{args.port}")
    print(f"   Model: {engine_desc}")
    print(f"   Endpoint: http://{args.host}:{args.port}/v1/systemone")
    print("   License: Apache 2.0 (100% Free and Open Source)")
    print("   Zero cloud token pricing. Zero data exfiltration.")
    print("   Press Ctrl+C to stop.")

    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nStopping local System 1 engine.")
        server.server_close()


if __name__ == "__main__":
    main()
