# Security Policy

Arcane Labs takes security reports seriously. This document describes how to report a vulnerability and what to expect in response.

For the **architectural threat model** (what the repo defends against and how), see [`SECURITY_MODEL.md`](./SECURITY_MODEL.md). This file is the **process** — how to tell us about an issue you've found.

## Supported versions

| Component | Supported version | Notes |
|---|---|---|
| `main` | Latest | Fixes applied here |
| Tagged releases | Latest major | Backported fixes considered case-by-case |

Older releases are not patched. Open a tracking issue with the reason if you need a fix on an older version.

## Reporting a vulnerability

**Do not open a public GitHub issue for security reports.**

Email **apps@arcanelabs.info** with:

- A short description of the issue
- The file, module, or component affected
- Steps to reproduce (or a proof-of-concept, if available)
- The impact as you understand it (data exposure, privilege escalation, bypass, etc.)
- Your preferred credit line if you'd like acknowledgment

We'll acknowledge receipt within **3 business days** and aim to triage and respond with a plan within **7 business days**. If confirmed valid, we'll coordinate a fix timeline with you and publish a security advisory once the fix has shipped.

## Scope

**In scope:**

- Remote exploits against the codebase as shipped
- Privilege escalation, confused-deputy, or trust-boundary bypasses
- Supply-chain issues in declared dependencies where this repo's usage makes a user materially more exposed
- Data-exposure bugs — anywhere the code may leak data the architecture claims to protect

**Out of scope:**

- Issues that require the attacker to already have full local filesystem access
- Social-engineering attacks against maintainers
- Vulnerabilities in third-party services the repo consumes (report those upstream)
- Theoretical issues with no practical exploit path

## Disclosure posture

Arcane Labs prefers **coordinated disclosure**. If your disclosure timeline differs, say so in your initial email and we'll work something out. We will **not** pursue legal action against researchers who act in good faith and follow this policy.

## Privacy of your report

We treat your report as confidential until a fix ships and you're credited (or you've asked to stay anonymous). We do not share reporter details with third parties.

---

Maintained by **Arcane Labs** · apps@arcanelabs.info
