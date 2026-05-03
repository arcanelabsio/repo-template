---
id: ADR-0004
title: Use Result types for expected errors; throw for bugs
status: Accepted
date: 2026-05-03
---

## Context

Errors fall into two fundamentally different categories:

1. **Expected:** part of business logic. File not found, network offline, invalid user input, version mismatch on a persisted file. The caller has a meaningful response — show a UI message, retry, prompt, fall back.
2. **Unexpected:** bugs and broken invariants. Index out of bounds, null where the type system says it can't be, an unreachable branch. The caller has no meaningful response; the program is in an undefined state.

Conflating them — by `try/catch`-ing everything, or by returning `null` for both — produces code that hides bugs as "handled errors" and treats real edge cases as fatal. The result is silent data corruption, swallowed exceptions, and `catch (_) {}` graveyards.

## Options Considered

### Option A: Throw exceptions for everything

Expected and unexpected errors both surface as thrown exceptions; callers `try/catch` to handle.

- **Pro:** Idiomatic in many languages.
- **Con:** No way for the type system to tell you which functions can fail or how.
- **Con:** Tempts `catch (_)` blocks that swallow real bugs.
- **Con:** Hard to reason about control flow; exception throws look like assignments.

### Option B: Return null / sentinel values for failures

`function find(): T | null` where `null` means "not found, not exceptional".

- **Pro:** Lightweight.
- **Con:** Conflates "not found" with "I/O error" with "permission denied" — caller can't distinguish.
- **Con:** Lossy; the *reason* a value is missing is the most important information for debugging.

### Option C: Result types for expected, throw for bugs (chosen)

Two-track:
- **Expected errors** return `Result<T, E>` (or language idiom: `Either<L,R>`, sealed class, tagged union, `(value, error)` tuple). Caller is forced by the type system to handle. The error type carries enough context to debug: error code, what was attempted, sanitized inputs.
- **Bugs** throw / panic. Let the program crash with a stack trace. Don't `catch` to "be safe"; only catch when there's a specific recovery action for a specific error type.
- **Boundary conversion:** at the I/O edge, exceptions from libraries are caught once and converted to `Result.Err`. Inside trusted code, exceptions remain exceptional.

- **Pro:** The type system enforces error handling for expected failures.
- **Pro:** Bugs surface loudly; no `catch (_)` graveyard.
- **Pro:** Error values carry context; debugging doesn't require source access.
- **Con:** More verbose at every callsite that can fail.
- **Con:** Requires discipline at the boundary (one place that converts thrown → `Result`).

## Decision

**Option C.**

- Functions that can fail in expected ways return `Result<T, E>`. The error type is a tagged union with at minimum a code, a description, and any context needed to debug.
- Functions that fail unexpectedly throw. The shell/entrypoint has a top-level handler that logs and exits cleanly.
- At I/O boundaries (file, network, OS calls), library exceptions are caught once and converted to `Result.Err`. Internal code does not `try/catch`.
- `catch` blocks without explicit recovery actions are a code review reject.

## Consequences

### Positive

- Compile-time enforcement that error paths are handled (or explicitly propagated).
- Bugs are loud, not silent — fewer mysteries in production.
- Error values can be unit-tested directly without throwing simulation.

### Negative

- Verbosity at every callsite that touches I/O.
- Onboarding cost: devs (and AI agents) used to throw-everything need to internalize the split.

### Risks

- **`Result.Err` becomes the new `null`.** Devs erase the error context with `.unwrapOr(default)`. Mitigation: code review rejects unwrap-with-default unless the default is documented as semantically meaningful.
- **Boundary leak.** A library exception escapes the boundary and crashes a feature. Mitigation: every I/O wrapper has an integration test that exercises the failure path.

## Related Decisions

- ADR-0002 (filesystem-first) — every fs operation is an expected-failure boundary; returns `Result`.
- ADR-0003 (testing) — error-path tests are trivial when errors are values, painful when they're exceptions. Reinforces this ADR.
