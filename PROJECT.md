# Project — {{REPO_NAME}}

> The "why" of this repo. `STATE.md` is for what's happening *now*; this file is for what we're building and why.

## Why this exists
<2 sentences. The problem. Why existing solutions don't fit.>

## Who it's for
<concrete persona — not "developers" but "solo Flutter devs shipping personal apps">

## Non-goals
<things we explicitly will NOT do — these protect scope>
- ...
- ...

## North-star metric
<single number we're moving — qualitative goals dilute focus>

## Architectural phase
<bootstrap | feature-build | hardening | maintenance>
- **Bootstrap:** scaffolding, no users, breaking changes free
- **Feature-build:** users exist, breaking changes need migration
- **Hardening:** behavior frozen, optimizing for reliability
- **Maintenance:** stable, only bug fixes and security

## Constraints
<the things that bound design choices — pick from this template's defaults and add repo-specific>
- Filesystem-first persistence (see ADR-0002)
- No backend unless mandatory
- Single-user data model (or: multi-user — declare it)
- Offline-first
- <repo-specific...>

## Stakeholders
- **Owner:** <name / email>
- **Reviewers:** <names>
- **Users (current):** <count or list>

## Key links
- [README.md](./README.md) — install + run
- [AGENTS.md](./AGENTS.md) — rules for AI agents
- [docs/adr/](./docs/adr/) — architectural decisions
- [STATE.md](./STATE.md) — current task
