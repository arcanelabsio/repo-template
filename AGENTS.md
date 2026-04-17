# AGENTS.md — {{REPO_NAME}}

> Authoritative guide for AI coding assistants (Claude Code, Codex, Copilot, Gemini) working in this repo. `CLAUDE.md` imports this file via `@AGENTS.md`; edit here, not there.

## Purpose

{{REPO_PURPOSE}}

Before changing anything non-trivial, read this file and the docs it links to. Arcane Labs repos prize invariants over defaults — the right edit respects the constraints that were chosen deliberately.

## Key Rules

- **Conventional Commits.** `feat|fix|chore|docs|refactor|test|ci(<scope>): <subject>`. No `Co-Authored-By:` trailers.
- **ADRs for structural decisions.** If a change alters data flow, storage shape, trust boundary, or scope, it ships with an ADR in `docs/adr/` (even if the ADR is three paragraphs).
- **No silent scope expansion.** If a task grows beyond its original intent, surface it in the PR description and propose splitting. Don't quietly add features, refactors, or abstractions.
- **Comments only when the *why* is non-obvious.** Well-named code doesn't need comments explaining what it does. Use comments to record hidden constraints, subtle invariants, workarounds.
- **Tests live alongside code** and cover the invariants below. A PR that adds behavior without adding a test that would fail without it is incomplete.

_Add repo-specific rules here. Examples from other Arcane Labs repos:_

- _Forge: installed assets must never mutate GitHub resources (read-only invariant)._
- _Vael: every byte written to Drive is encrypted client-side._
- _Longeviti: past weeks are frozen; only current/future plans are mutable._
- _Shellcraft: `--plan` is the default; apply requires an explicit flag._

## Invariants that must not be broken

1. _List the contracts whose violation is a bug, not a taste disagreement. Be specific. "Tests pass" is not an invariant; "every file written to Drive has a `schema_version` field" is._
2. _..._
3. _..._

A PR that weakens an invariant without superseding the ADR that established it must be rejected.

## Where to find the contract

- **Code entry points:** _..._
- **Data contract / schemas:** _..._
- **ADRs:** [`docs/adr/`](./docs/adr/) — read before proposing structural changes
- **Security model:** [`SECURITY_MODEL.md`](./SECURITY_MODEL.md) — the architectural threat model
- **Security reporting:** [`SECURITY.md`](./SECURITY.md)
- **Contribution guide:** [`CONTRIBUTING.md`](./CONTRIBUTING.md)

## Onboarding order for a new contributor (human or agent)

1. This file — rules and invariants
2. `README.md` — what the repo does
3. `docs/adr/` — why the code looks the way it does
4. Entry points in the code

## Commands an agent will typically run

```bash
# {{LANGUAGE}}-specific setup
# ...

# Lint, test, build
# ...
```

_Replace the commands above with the real ones for this repo during setup._
