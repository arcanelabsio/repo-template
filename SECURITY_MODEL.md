# {{REPO_NAME}} — Security Model

This document is the **architectural threat model**: what the repo defends against, how, and who is responsible for keeping each mitigation in force. For the **reporting process** (how to tell us about a bug you found), see [`SECURITY.md`](./SECURITY.md).

## Threat model at a glance

_State the repo's core security claim in one sentence — the thing that is structurally true, not just aspirational._

_Example (Longeviti): "Personal health data lives exclusively in the user's own Google Drive, never in the repo, never on an Arcane Labs server, never touched by a third party."_

_Example (Vael): "Every byte of family financial data that leaves the device is encrypted client-side with a family-derived key; Google Drive stores ciphertext that is indistinguishable from random."_

_Example (Forge): "Installed assistant assets perform only read-only GitHub operations via the user's own `gh` CLI; Forge ships no runtime and has no mutation path."_

## Threat × Mitigation × Responsibility

| Threat | Mitigation | Responsibility |
|---|---|---|
| _e.g. Sensitive data leaks into git_ | _Data lives outside the repo; `.gitignore` is defense-in-depth, not primary control_ | _Repo (enforces at code review); user (follows setup docs)_ |
| _..._ | _..._ | _..._ |
| _..._ | _..._ | _..._ |

Aim for 6–10 rows. Each row should name a real failure mode, not a theoretical class. If every row reads "we use secure coding practices," the model is too abstract to be useful.

## What this model does *not* claim

_Be explicit about what's out of scope. Trust is easier to maintain when the limits are stated._

- _Does not claim the user's local machine is secure._
- _Does not claim upstream services (GitHub, Google Drive, Claude Code) are secure._
- _..._

## How to evaluate this posture

_List 3–5 specific questions a security-conscious user / auditor / fork should be able to ask and verify by reading the code._

1. _..._
2. _..._
3. _..._

If any of these answers change, a new entry in the threat table is required.
