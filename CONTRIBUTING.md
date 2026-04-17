# Contributing to {{REPO_NAME}}

Thanks for considering a contribution. This guide describes how changes land cleanly — so your PR is reviewable, reversible, and easy to approve.

## Before you start

1. **Read [`AGENTS.md`](./AGENTS.md).** Rules, invariants, and where the contract lives.
2. **Read the [`README`](./README.md).** High-level what and why.
3. **Skim [`docs/adr/`](./docs/adr/).** The ADRs explain why the current design is the way it is. Fighting an ADR without superseding it is a short road to a rejected PR.

## What kind of change are you making?

| Change type | Stakes | Where to work | Required |
|---|---|---|---|
| Typo or doc clarification | Low | Direct PR | — |
| Bug fix, small feature | Medium | PR; consider opening an issue first if the fix has alternatives | Test that would have caught it |
| Structural change (data flow, storage, trust boundary, scope) | **High** | **Open an issue first** | ADR in `docs/adr/` |
| Breaking change (behavior users depend on) | **Critical** | **Open an issue first** | ADR + migration notes |

When in doubt, open the issue first. The maintainer prefers five minutes of alignment over a large PR that needs reshaping.

## Development workflow

```bash
# Clone
git clone https://github.com/arcanelabsio/{{REPO_NAME}}
cd {{REPO_NAME}}

# Set up
# ... {{LANGUAGE}}-specific ...

# Verify the happy path
# ... test / lint / build ...
```

_Replace the above with the real commands during setup._

## Commit style

We use [Conventional Commits](https://www.conventionalcommits.org/):

```
feat(scope): what the feature does
fix(scope): what the fix does
docs(adr): clarify why X
refactor(module): why the new shape is better
```

Allowed types: `feat`, `fix`, `chore`, `docs`, `refactor`, `test`, `ci`.

Do **not** include `Co-Authored-By:` trailers. The commit history is the record of intent; artificial attribution muddies it.

Keep commits small and focused — one logical change per commit makes review faster and `git bisect` meaningful later.

## Pull request checklist

- [ ] PR description explains **what, why, and how it was validated**
- [ ] Tests added or updated for the behavior change
- [ ] Structural changes include an ADR in `docs/adr/`
- [ ] `README`, `AGENTS.md`, or other docs updated if the contract changed
- [ ] CI is green
- [ ] No secrets, API keys, or personal data in the diff

## Reporting bugs and proposing features

Use the issue templates under [`.github/ISSUE_TEMPLATE/`](./.github/ISSUE_TEMPLATE/). Good issues include:

- **What you were trying to do**
- **What happened instead**
- **Why it matters** — the use case, not just the symptom
- **Suggested direction** (optional)

## Security

See [`SECURITY.md`](./SECURITY.md). Do **not** open public issues for security reports.

## Code of Conduct

By participating you agree to uphold the [`Code of Conduct`](./CODE_OF_CONDUCT.md).

---

Maintained by **Arcane Labs** · apps@arcanelabs.info
