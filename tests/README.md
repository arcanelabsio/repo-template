# tests — {{REPO_NAME}}

## Layout

```
tests/
├── unit/         # fast, isolated; one assertion per test
├── integration/  # exercise features end-to-end through their public surface
└── fixtures/     # static input files used by integration tests
```

## Coverage targets

| Layer | Target | Why |
|---|---|---|
| `src/core/` (pure) | 90%+ | Cheap to test; broken `core` breaks everything |
| `src/features/<f>/repo` (effects) | 100% of paths | Persistence is unforgiving |
| `src/features/<f>/logic` (pure) | 80%+ | |
| `src/shell/` | smoke only | One golden-path E2E test |

## Rules

- **Test names describe behavior, not function names.** `it_returns_empty_when_input_is_empty`, not `testSearch`.
- **One assertion per test.** Multiple paths → multiple tests.
- **No mocks unless I/O.** If you're mocking a pure function, the test is wrong.
- **Bug fixes ship with regression tests.** No exceptions.
- **No `.skip` / `.only`.** A skipped test is a lie.

See [`../docs/adr/0003-testing-philosophy.md`](../docs/adr/0003-testing-philosophy.md).
