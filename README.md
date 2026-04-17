# Arcane Labs — Repository Template

> Starting point for new repos at **[Arcane Labs](https://github.com/arcanelabsio)**. Pre-wired with our conventions so a new repo is publishable, reviewable, and AI-legible from commit one.

## Use this template

Click **Use this template → Create a new repository** at the top of this page, or from the CLI:

```bash
gh repo create arcanelabsio/<new-repo-name> \
  --template arcanelabsio/repo-template \
  --public \
  --clone
cd <new-repo-name>
```

Then open [`SETUP.md`](./SETUP.md) and work through the post-clone checklist. It takes about 10 minutes.

## What's inside

| Path | Why it's here |
|---|---|
| [`AGENTS.md`](./AGENTS.md) | Authoritative guide for AI coding assistants. Cross-tool (Claude Code, Codex, Copilot, Gemini) source of truth. |
| [`CLAUDE.md`](./CLAUDE.md) | Thin pointer that imports `AGENTS.md` via `@AGENTS.md` so Claude Code auto-loads the rules. |
| [`CONTRIBUTING.md`](./CONTRIBUTING.md) | Contribution guide, Conventional Commits, PR checklist. |
| [`SECURITY.md`](./SECURITY.md) | Vulnerability reporting policy. Points at `apps@arcanelabs.info`. |
| [`SECURITY_MODEL.md`](./SECURITY_MODEL.md) | Threat × mitigation × responsibility table. Architectural, not procedural. |
| [`CODE_OF_CONDUCT.md`](./CODE_OF_CONDUCT.md) | Behavior expectations for contributors. |
| [`LICENSE`](./LICENSE) | MIT default; swap for AGPL if the repo's posture requires it. |
| [`docs/adr/`](./docs/adr/) | Architecture Decision Records. `0000-TEMPLATE.md` is the ADR template. |
| [`.github/ISSUE_TEMPLATE/`](./.github/ISSUE_TEMPLATE/) | Bug report and feature request forms. |
| [`.github/PULL_REQUEST_TEMPLATE.md`](./.github/PULL_REQUEST_TEMPLATE.md) | PR description scaffold with checklist. |
| [`.github/workflows/ci.yml`](./.github/workflows/ci.yml) | Minimal CI — markdown lint + link check. Add language-specific jobs during setup. |
| [`.gitignore`](./.gitignore) | Multi-language defaults. Trim during setup. |
| [`SETUP.md`](./SETUP.md) | Post-clone checklist. **Read this first.** |

## Org conventions this template encodes

- **`AGENTS.md` is authoritative.** Not `CLAUDE.md`, not `.cursorrules`, not per-tool files. One source, many readers.
- **ADRs live in `docs/adr/`.** Numbered, immutable after acceptance, supersede rather than edit.
- **`SECURITY.md` is the policy; `SECURITY_MODEL.md` is the architecture.** Two different documents, two different audiences.
- **Conventional Commits, no `Co-Authored-By:` trailers.** `feat|fix|chore|docs|refactor|test|ci(<scope>): <subject>`.

## Maintaining this template

This repo is the source of truth for org-level scaffolding. Changes here don't retroactively reach repos already created from the template — GitHub templates are copy-at-creation, not live-inherited. To update existing repos:

1. Land the change here with a clear commit message.
2. Open a tracking issue in each downstream repo naming the template change and what needs copying over.
3. Downstream repos pull the change opportunistically, not as a sync.

When adding a new convention, land the change here with a clear commit message and let downstream repos pull it in opportunistically.

## License

MIT — see [`LICENSE`](./LICENSE). This applies to the template itself; repos created from it are free to adopt a different license.
