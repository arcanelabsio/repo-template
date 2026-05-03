---
id: ADR-0001
title: Record architecture decisions in this repo
status: Accepted
date: 2026-05-03
---

## Context

This repo will accumulate architectural decisions whose rationale outlives the PRs that introduced them: storage formats, trust boundaries, scope decisions, dependency adoptions. Without a durable record, future maintainers (and AI agents) re-litigate settled questions, and the *why* behind the code becomes folklore.

We are at the start of the project, when establishing process is cheap. Retrofitting ADRs onto a year of undocumented decisions is expensive and lossy.

## Options Considered

### Option A: No formal record

Decisions live in commit messages, PR descriptions, and team memory.

- **Pro:** Zero ceremony.
- **Pro:** Nothing to maintain.
- **Con:** Rationale erodes within months. PRs are not searchable as decision archives.
- **Con:** AI agents working in this repo cannot reconstruct *why* the code is shaped the way it is, and start proposing changes that violate prior decisions.

### Option B: Design docs in a wiki

Long-form architecture docs in Confluence / Notion / GitHub Wiki, separate from the code.

- **Pro:** Rich formatting, comments, organization.
- **Con:** Drifts from the code; nobody updates the wiki when the code changes.
- **Con:** Off-repo means out of sight during PR review.
- **Con:** Lock-in to a tool we may not use in 3 years.

### Option C: Lightweight ADRs in `docs/adr/` (chosen)

Numbered, immutable Markdown files in the repo. Each ADR captures Context, Options Considered, Decision, Consequences. Status of `Proposed` while the PR is open, `Accepted` on merge, `Superseded` if replaced.

- **Pro:** Lives next to the code; reviewable in the same PR.
- **Pro:** Plain Markdown; no tool lock-in; outlives any platform.
- **Pro:** AI agents can ingest the full decision history with no integration.
- **Pro:** Immutability + supersession captures *evolution* of thinking, not just current state.
- **Con:** Process discipline required — devs must remember to write them.
- **Con:** Light enough to skip; needs a clear "when to write one" rule.

## Decision

**Option C.** ADRs land in `docs/adr/` as numbered Markdown files using the template at `0000-TEMPLATE.md`. ADRs are immutable after acceptance; changes happen by superseding. The `docs/adr/README.md` index lists all ADRs, kept in order.

When to write one:
- Changing a trust boundary (who holds what data, who writes what).
- Picking or swapping a storage model.
- Defining repo scope (what we will and won't support).
- Removing something non-trivial.
- Any decision whose rationale won't fit in a commit message.

## Consequences

### Positive

- Future maintainers and AI agents can reconstruct the *why* of the codebase from a single directory.
- Reviews of structural changes anchor on the ADR, not on diff aesthetics.
- Decisions are versioned and dated; outdated ones are explicitly superseded, not silently overwritten.

### Negative

- Small process tax on every structural change.
- ADRs that are written but not read are dead weight.

### Risks

- **ADR rot.** ADRs go stale when code evolves and nobody supersedes the old record. Mitigation: every PR that violates an ADR's spirit must either supersede the ADR or document the deviation in a new one. Reviewers enforce.
- **ADR theatre.** ADRs written to satisfy process, not capture real decisions. Mitigation: keep the bar at "wouldn't fit in a commit message" — if it fits, it shouldn't be an ADR.

## Related Decisions

- (none — this is the meta-decision)
