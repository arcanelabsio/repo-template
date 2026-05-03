---
id: ADR-0003
title: Test behavior at boundaries, not implementation details
status: Accepted
date: 2026-05-03
---

## Context

Tests can either pin down behavior (good — they catch regressions) or pin down implementation (bad — they catch refactors). For a small team or solo developer, the cost of bad tests compounds fast: every refactor breaks them, devs lose trust, and the suite becomes ceremony to skip rather than a safety net.

We need a testing posture that:
- Catches real regressions.
- Survives refactors that don't change behavior.
- Doesn't require mocking infrastructure that becomes its own maintenance burden.
- Targets the highest-leverage code (data integrity, persistence, business logic) and de-prioritizes low-leverage code (UI pixels, framework internals).

## Options Considered

### Option A: 100% line coverage as a gate

Block PRs that drop coverage below 100%.

- **Pro:** Easy to measure.
- **Con:** Optimizes for coverage, not correctness. Generates trivial tests for getters and constants.
- **Con:** Punishes refactors that genuinely simplify code; the metric goes down despite the codebase improving.

### Option B: Heavy mocking, isolated unit tests

Mock every dependency; test each function in isolation.

- **Pro:** Tests run fast.
- **Con:** Mocks encode assumptions about how dependencies work; when the real dependency changes, mocks don't, and the test passes while production breaks.
- **Con:** Mock setup often exceeds test logic in line count; maintenance cost dominates.

### Option C: Behavior tests at boundaries (chosen)

Test what the code *does*, not how it does it. Specifically:

- **Pure functions:** unit-tested exhaustively (cheap, deterministic).
- **Persistence:** integration tests against a real filesystem. No fs mocks.
- **Features:** integration tests through the feature's public surface (`features/<f>/index.*`).
- **UI shell:** one smoke test per app — does the happy path render and respond?
- **Bug fixes:** every fix ships with a regression test that would have caught the bug.

Coverage targets are diagnostic, not gates: `core/` 90%+, `features/` 80%+, shell smoke only. Coverage drops are PR review prompts, not blockers.

- **Pro:** Tests survive refactors that preserve behavior.
- **Pro:** Real I/O at integration boundaries catches the bugs mocks hide.
- **Pro:** No mocking framework to maintain.
- **Con:** Some tests slower (seconds, not milliseconds). Acceptable for non-CI-hot-path tests.
- **Con:** Some bugs require careful test fixture design (e.g., corrupted file scenarios).

## Decision

**Option C.** Tests describe behavior; they target boundaries. No mocks unless the dependency is I/O *and* the test is a pure-logic unit test. Bug fixes always come with a regression test.

Coverage targets:
- `src/core/`: 90%+ branches.
- `src/features/<f>/repo` (persistence): 100% of paths.
- `src/features/<f>/logic` (pure): 80%+.
- `src/shell/`: smoke only — one happy-path E2E.

Hard rules:
- Test names describe behavior: `it_returns_empty_when_input_is_empty`, not `testSearch`.
- One assertion per test; multiple paths → multiple tests.
- No `.skip` / `.only` ever lands. A skipped test is a lie.

## Consequences

### Positive

- Refactors that don't change behavior don't break tests.
- The suite is small and trusted; devs run it before every commit.
- Bugs become permanent regression tests.

### Negative

- Slower than full mocking; integration tests touch the filesystem.
- Less "coverage theatre" to point at; metrics look lower than a 100%-coverage repo.

### Risks

- **Drift toward implementation testing.** Devs (or AI agents generating tests) test private internals. Mitigation: code review rejects tests that reach past the public surface. Tests of private functions are deleted.
- **Slow tests get skipped.** Integration tests creep past acceptable runtime. Mitigation: budget — full suite < 30s locally; if exceeded, parallelize or split slow tests to a separate "make check-slow" target, not deletion.

## Related Decisions

- ADR-0002 (filesystem-first) — our integration tests exercise real I/O against this format.
- ADR-0004 (error handling) — `Result` types make error-path tests trivial; `try/catch` makes them painful. Reinforces this ADR.
