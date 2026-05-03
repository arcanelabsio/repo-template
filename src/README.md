# src — {{REPO_NAME}}

Source code, organized by **vertical slice** (feature) over horizontal layer.

## Zones

```
src/
├── core/        # cross-cutting contracts; pure (no I/O); depends on nothing
├── features/    # feature folders; each owns its data, persistence, UI, tests
│   └── <feature>/
│       ├── index.<ext>     # the only public export of this feature
│       ├── repo.<ext>      # persistence (uses core/storage)
│       ├── logic.<ext>     # pure business logic
│       └── ui.<ext>        # if applicable
└── shell/       # entrypoint + wiring; the only place "the world" exists
    └── main.<ext>
```

## Rules

- **Features depend on `core/`. `core/` depends on nothing.** Inversion is non-negotiable.
- **No cross-feature imports.** Features talk through typed contracts in `core/`, never reach into another feature's internals.
- **One public surface per feature** (`index.*`). Everything else is internal.
- **`pure/` code has no `import fs`, no `import http`, no clock, no randomness.** Push I/O up to `effects/` (often inside the feature) or to `shell/`.

See [`../docs/adr/0002-filesystem-first-persistence.md`](../docs/adr/0002-filesystem-first-persistence.md) and [`../docs/adr/0004-error-handling-result-types.md`](../docs/adr/0004-error-handling-result-types.md).
