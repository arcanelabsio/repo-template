---
id: ADR-0002
title: Persist data on the filesystem, not in a database server
status: Accepted
date: 2026-05-03
---

## Context

This repo is a single-user (or small-team) app where data is user-authored and the user expects to own and inspect their files. Provisioning a database server for one user creates ops overhead disproportionate to the value: backups become a service problem, migrations become a downtime problem, and "delete my account" becomes a multi-system grep.

The constraints that matter:
- One primary user per data store.
- Data must survive uninstalls (export-friendly) and survive the project (no proprietary lock).
- The app must work fully offline.
- The user should be able to back up the data with `cp -r` if they want.

## Options Considered

### Option A: SQLite-only

A single SQLite file per app. Schema migrations via embedded migration runner.

- **Pro:** ACID, indexes, queries; one file the user can copy.
- **Pro:** Mature ecosystem; bindings everywhere.
- **Con:** User can't open it in a text editor or diff it in Git.
- **Con:** Schema migrations on a binary file are higher-stakes than on JSON.

### Option B: Hosted database (Postgres / Firebase / Supabase)

Server-backed, multi-tenant.

- **Pro:** Multi-device "free."
- **Con:** Requires auth, network, ops, billing. Disproportionate for a single-user app.
- **Con:** User doesn't own the data; "export" is a feature we have to build and they have to trust.
- **Con:** Goes against the offline-first constraint.

### Option C: Filesystem-first (chosen)

Mixed-format on the user's filesystem under a per-app root (`~/<App>/`):

- Config and small structured data: TOML or JSON
- Append-only event logs: JSONL (one JSON object per line, atomic append)
- Queryable structured records: SQLite
- Large blobs: content-addressed files in `attachments/aa/bb/<sha256>`
- User documents: native format (Markdown, plaintext) — never wrapped

All writes go through atomic write helpers (write to `.tmp`, fsync, rename). Every persisted file carries a `version` field. Migrations are pure functions: `migrate(v: int, data) -> data`.

- **Pro:** Zero infra. Works offline. User owns and can inspect data.
- **Pro:** Each format used where it fits — JSON for diffability, JSONL for crash-safe append, SQLite for queries, raw files for blobs.
- **Pro:** Backups are `cp -r`. Restore is `cp -r`. Debugging is `cat` and `jq`.
- **Pro:** Easy to integrate with iCloud / Drive sync as a transport (encrypt first; see PTRN-001 / PTRN-007).
- **Con:** Multi-device sync becomes our problem (acceptable; design forces explicit handling).
- **Con:** Cross-format consistency (e.g., a JSONL append + a SQLite update) needs care; we keep them rare.

## Decision

**Option C.** Per-app data root at `~/<App>/` with the format-per-use-case split above. All writes atomic. All persisted files versioned. Migrations as pure functions. Multi-device sync, if needed, is a separate concern (see PTRN-001) and treats the cloud as an *encrypted blob transport*, never as the source of truth.

## Consequences

### Positive

- Onboarding for new devs / AI agents is `ls ~/<App>/` and they understand the data model in 5 minutes.
- Backup, restore, and "uninstall cleanly" are trivial.
- The user's data is portable forever, regardless of what the app does in 5 years.

### Negative

- We don't get database features for free: indexes, joins, query planner. We use SQLite where that matters and hand-write where it doesn't.
- Every persistence concern (atomicity, schema versioning, migration) is our code, not a library's.

### Risks

- **Concurrent writers corrupt files.** Mitigation: every file has exactly one writer function in the codebase; multiple producers funnel through it. Atomic rename prevents partial writes.
- **iCloud / Drive sync folders are hostile.** Files appear, disappear, partially sync. Mitigation: never write final results into a sync folder; use a stable shadow directory and copy in.
- **Schema migrations.** A bug in `migrate(v1 -> v2)` corrupts data permanently. Mitigation: backup-on-first-write-of-session before any migration runs.

## Related Decisions

- ADR-0004 (error handling) — `Result` types for expected I/O failures (file missing, locked, corrupt).
- Forthcoming: an ADR for sync if/when this repo adopts multi-device sync.
