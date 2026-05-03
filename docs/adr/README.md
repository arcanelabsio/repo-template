# Architecture Decision Records — {{REPO_NAME}}

Numbered records of architectural decisions in this repo. Each ADR captures the context, the options considered, and the decision taken, so future-us remember why the code looks the way it does.

## Conventions

- Numbering is sequential, zero-padded to 4 digits (`ADR-0001`, `ADR-0002`). The `0000-TEMPLATE.md` file is not itself an ADR — copy it when authoring a new one.
- Status is one of `Proposed`, `Accepted`, `Superseded`, `Deprecated`.
- **ADRs are immutable after acceptance.** If the decision changes, supersede the old ADR with a new one and set the old to `Superseded`. Do not edit the record of the past.

## When to write one

- You're changing a **trust boundary** (who holds what data, who writes what).
- You're picking a **storage model** or swapping one out (database, cloud, encryption posture).
- You're defining **scope** — what the repo will and won't support.
- You're **removing** something non-trivial and want the reason to survive.
- A reviewer asks "why did we do it this way?" more than once.

If the decision fits in a commit message, a commit message is fine. ADRs are for decisions whose rationale is too long for a message and too load-bearing to lose.

## Authoring

Copy `0000-TEMPLATE.md` to the next number, fill in each section, and open a PR. The ADR lands with the code change it describes.

## Index

<!-- Update this index as ADRs land. -->

| ID | Title | Status | File |
|---|---|---|---|
| ADR-0001 | Record architecture decisions in this repo | Accepted | [`0001-record-architecture-decisions.md`](./0001-record-architecture-decisions.md) |
| ADR-0002 | Persist data on the filesystem, not in a database server | Accepted | [`0002-filesystem-first-persistence.md`](./0002-filesystem-first-persistence.md) |
| ADR-0003 | Test behavior at boundaries, not implementation details | Accepted | [`0003-testing-philosophy.md`](./0003-testing-philosophy.md) |
| ADR-0004 | Use Result types for expected errors; throw for bugs | Accepted | [`0004-error-handling-result-types.md`](./0004-error-handling-result-types.md) |
| ADR-0005 | Use lightweight signals for state; avoid heavy frameworks until justified | Accepted | [`0005-state-management-signals.md`](./0005-state-management-signals.md) |

> **ADRs 0001–0005 are inherited from `repo-template`.** Each new repo starts with these as accepted defaults. If a repo's constraints contradict one (e.g., it's a multi-tenant server, not single-user filesystem-first), supersede the ADR with a new one — don't edit the inherited record. See [SETUP.md](../../SETUP.md) for the per-repo review pass.
