# Architectural Decision Log - jev-superpowers

Every architectural and design decision was evaluated deterministically using TypeSafe AI Jev System One (`jev-1.13.0`):

1. **Namespace Strategy**:
   - Question: How should `jev-superpowers` structure its namespace relative to `obra/superpowers`?
   - Decision: `coexist_prefixed_namespace` ($P = 0.98$, Confidence: $0.96$).
   - Rationale: Avoids destroying existing user configurations while enabling clean invocation.

2. **Missing API Key Behavior**:
   - Question: How should `jev-superpowers` handle missing `$TYPESAFE_API_KEY`?
   - Decision: `fail_fast_with_signup_url` ($P = 0.96$, Confidence: $0.94$).
   - Rationale: Silent fallback to LLM guessing defeats the entire purpose of mathematical certainty.

3. **Execution Architecture**:
   - Question: How should the skills in `jev-superpowers` invoke Jev primitives?
   - Decision: `orchestrate_existing_clis` ($P = 0.98$, Confidence: $0.97$).
   - Rationale: Re-uses already-installed local binaries (`jev-scout`, `git-jev`, `jev-guard`, `supercov`).

4. **Distribution Format**:
   - Question: What is the best installer distribution mechanism?
   - Decision: `curl_powershell_hybrid_script` ($P = 0.93$, Confidence: $0.89$).
   - Rationale: Cross-platform one-liner installer for macOS, Linux, and Windows.

5. **Test Suite Architecture**:
   - Question: Should `jev-superpowers` include an offline mock test suite?
   - Decision: `include_offline_mock_test_suite` ($P = 1.00$, Confidence: $1.00$).
   - Rationale: Zero-token test execution in GitHub Actions CI.
