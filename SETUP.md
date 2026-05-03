# Post-clone setup checklist

After clicking **Use this template** and cloning your new repo, work through this list. It takes about 10 minutes and leaves you with a repo that's publishable and ready for a first commit.

Tokens to replace:

| Token | Replace with |
|---|---|
| `{{REPO_NAME}}` | The new repo's short name (e.g. `forge`, `shellcraft`) |
| `{{REPO_PURPOSE}}` | One-sentence description of what the repo does |
| `{{LANGUAGE}}` | Primary language / stack (e.g. `Node 22`, `Flutter 3.x`, `Python 3.12`, `Bash`) |
| `{{ADR_DECISION_1}}`, `{{ADR_DECISION_2}}`, `{{ADR_DECISION_3}}` | First three ADRs you'll backfill |

## 1. Rename placeholders

From the repo root:

```bash
# macOS / BSD sed
grep -rl '{{REPO_NAME}}' --exclude-dir=.git . | xargs sed -i '' 's/{{REPO_NAME}}/your-repo-name/g'

# Linux / GNU sed
grep -rl '{{REPO_NAME}}' --exclude-dir=.git . | xargs sed -i 's/{{REPO_NAME}}/your-repo-name/g'
```

Repeat for each token in the table above. A final `grep -r '{{' --exclude-dir=.git .` should return nothing.

Then initialize the per-fork state file. `STATE.md` is gitignored on purpose — it tracks ephemeral progress and shouldn't travel with the repo's history; `STATE.template.md` ships in VCS as the skeleton.

```bash
cp STATE.template.md STATE.md
```

## 2. Pick a license

The template ships MIT. If your repo's posture requires AGPL (typically: an end-user app with strong copyleft intent, e.g. Vael) or a proprietary license (typically: a closed product), replace `LICENSE` now.

```bash
# Example: swap to AGPL-3.0
curl -sSL https://www.gnu.org/licenses/agpl-3.0.txt -o LICENSE
```

Update the year and copyright line to `Copyright (c) 2026 Ajit Gunturi / Arcane Labs`.

## 3. Write the real README

`README.md` currently documents the template, not your repo. Replace it. The opening 10 lines matter most — a visitor decides whether to keep reading there.

Recommended opening:

```markdown
# {{REPO_NAME}}

> Built at **[Arcane Labs](https://github.com/arcanelabsio)**.

**{{REPO_PURPOSE}}**

## Quick Start

...
```

## 4. Fill in `AGENTS.md`

The template ships with skeleton sections. For each one:

- **Purpose** — one paragraph, concrete. Not marketing.
- **Key Rules** — the rules a contributor (human or AI) must follow. Bias toward invariants, not style preferences.
- **Invariants that must not be broken** — numbered. These are the rules whose violation is a bug, not a taste disagreement.
- **Where to find the contract** — file paths to the code and docs that encode the above.

If your repo has a rich workflow (like Longeviti's `ELARA → ATLAS`), add a **Workflow Map** section after the rules.

## 5. Review inherited ADRs and add repo-specific ones

The template ships **5 starter ADRs** (0001–0005) covering the convention itself, filesystem-first persistence, behavior-over-implementation testing, `Result`-typed error handling, and lightweight signal-based state. Forks inherit these as `Accepted`.

For each, decide:

- **Keep** — the default fits this repo. No action.
- **Supersede** — your constraints conflict (e.g., this is a multi-tenant server, not single-user filesystem). Write a new ADR that supersedes the inherited one and set the old status to `Superseded`. Don't edit the inherited record — immutability is the point.
- **Extend** — the default is correct but needs repo-specific elaboration. Write a new ADR that cites the inherited one (e.g., "extends ADR-0002 by specifying iCloud Drive as the sync transport").

Then add 1–2 repo-specific ADRs for the decisions only this repo makes:

- *Why this language / framework?* (often a one-line answer; write it anyway)
- *Why this trust boundary / sync transport?* — if it specializes ADR-0002.
- *What's deliberately out of scope?* (e.g., Shellcraft's "no Linux support" is an ADR)

Use `docs/adr/0000-TEMPLATE.md` as the starting point. Number new ADRs sequentially from `0006`.

## 6. Prune the CI workflow

`.github/workflows/ci.yml` ships a language-agnostic check (markdown lint + link check). Add a language job — `npm test`, `flutter analyze && flutter test`, `pytest`, `shellcheck` — as the first PR after setup.

## 7. Configure branch protection

From the repo's **Settings → Branches**:

- Require a PR for pushes to `main`
- Require status checks to pass (the CI workflow above)
- Require signed commits (optional but recommended)

If you want these enforced across every Arcane Labs repo, consider an **org-level ruleset** instead (Settings → Organization → Rulesets).

## 8. Add topics

GitHub topics on the repo's About pane (right sidebar) are how discoverability works. Suggested minimum:

- `arcanelabs`
- `local-first`
- `byo-ai` (if applicable)
- Your primary language tag (`node`, `flutter`, `python`, `bash`)

## 9. Update the org profile

If this is a public repo, add it to the sibling list in the other Arcane Labs repo READMEs (`grep -rl 'Sibling projects' ...`), and add a one-line entry to the org profile at [`arcanelabsio/.github`](https://github.com/arcanelabsio/.github).

## 10. Delete this file

```bash
git rm SETUP.md
git commit -m "chore: remove template setup checklist"
```

`SETUP.md` exists for the first 10 minutes of a new repo's life. After that it's noise.
