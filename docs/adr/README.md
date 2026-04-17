# Architecture Decision Records — {{REPO_NAME}}

Numbered records of architectural decisions in this repo. Each ADR captures the context, the options considered, and the decision taken, so future-us remember why the code looks the way it does.

## Conventions

- Numbering is sequential, zero-padded to 4 digits (`ADR-0001`, `ADR-0002`). The `0000-TEMPLATE.md` file is not itself an ADR — copy it when authoring a new one.
- Status is one of `Proposed`, `Accepted`, `Superseded`, `Deprecated`.
- When an org-level pattern applies, set `applies_pattern: PTRN-NNN` in the frontmatter — see the [arcanelabsio-patterns registry](https://github.com/arcanelabsio/arcanelabsio-patterns).
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

- _No ADRs yet. Backfill 2–3 as part of [`SETUP.md`](../../SETUP.md) step 5._
