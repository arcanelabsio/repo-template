---
id: ADR-0005
title: Use lightweight signals for state; avoid heavy frameworks until justified
status: Accepted
date: 2026-05-03
---

## Context

State management is one of the most common over-engineering targets. The temptation is to reach for a global store framework (Redux, Riverpod, Zustand, MobX, Vuex) before the app has any state worth managing. The cost is: a 50KB dependency, devtools that you'll use twice, a mental model that future-you and AI agents have to learn, and a set of patterns (selectors, slices, middleware) that become load-bearing the moment you adopt them.

Most apps in this portfolio start with state local to a few features and a small handful of cross-cutting values (current user, theme, sync status). They don't need time-travel debugging, hydration, or middleware on day one — and may never need them.

We want a posture that:
- Starts cheap and stays cheap until evidence forces escalation.
- Doesn't lock the repo into a framework that becomes hard to remove.
- Plays nicely with the persistence model in ADR-0002.

## Options Considered

### Option A: Adopt a framework state lib upfront

Pick Redux / Riverpod / Zustand and wire it from day one.

- **Pro:** Patterns are well-known; devtools, time-travel, and middleware are free.
- **Con:** Large dependency; locks the repo's mental model to that lib forever.
- **Con:** Most features in early-stage apps don't need any of its features.
- **Con:** Removing it later is a multi-day refactor.

### Option B: Keep all state in a single global object

A plain object at module top: `const state = { user: null, theme: 'dark' }`. UI reads/writes directly.

- **Pro:** Trivial.
- **Con:** No reactivity — UI doesn't know when state changes.
- **Con:** No scoping — every consumer can read/write everything; testing is hard.

### Option C: Lightweight signal primitive + escalation rule (chosen)

A ~30-LOC `Signal<T>` primitive in `src/core/signal.*` with `get`, `set`, `subscribe`. Each feature owns its signals (`features/<f>/state.*`). Cross-feature shared state lives in `src/core/state.*` as a small set of named signals.

State management hierarchy (pick the lowest that works):
1. Function arguments — pass it down.
2. Module-scoped value — fine for caches, never for app-critical state.
3. Signal primitive — for UI reactivity.
4. Single store (one tree, immutable updates) — only when state is shared by 3+ features.
5. Framework state lib — only when the app demands feature parity (devtools, time travel, hydration).

Escalation only when there's a concrete reason: 3+ features genuinely share state, OR debugging needs time-travel, OR persistence needs structured middleware.

- **Pro:** Tiny, no dependencies, type-safe, framework-agnostic.
- **Pro:** Easy to escalate later — signals can be wrapped in a store, or replaced wholesale, with bounded effort.
- **Pro:** Pure logic stays pure; signals are an effects-zone primitive.
- **Con:** No devtools out of the box.
- **Con:** Patterns (persistence, middleware, derivations) we hand-write as we need them.

## Decision

**Option C.**

- `src/core/signal.*` exposes a minimal `Signal<T>` with `get`, `set`, `subscribe`.
- Each feature defines its own signals in `features/<f>/state.*`. Public surface only exposes what other features can read; internal signals stay private.
- Cross-feature shared state lives in `src/core/state.*` and is intentionally small. Reviews scrutinize additions here.
- **No framework state lib without a superseding ADR.** If we need one, the ADR documents (a) what concrete need we hit, (b) which lib we picked and why, (c) the migration plan from signals.

Anti-rules:
- Derived state is computed, never stored. Memoize only if profiling says so.
- Server / network response cache is *not* in the app store. Use a query layer or a file cache.
- Persistence is a projection of state, not a copy: `persist(state) -> bytes`, `hydrate(bytes) -> state`.

## Consequences

### Positive

- Onboarding for state in this repo is one short file; no external mental model.
- No state-lib version drama on dependency upgrades.
- Pure logic remains testable without a store harness.

### Negative

- Devtools-style debugging requires logging or hand-rolled tooling.
- Hydration / persistence patterns are hand-rolled per app.

### Risks

- **Signals proliferate.** Every feature ends up with 30 signals; coordination becomes accidental coupling. Mitigation: code review enforces that cross-feature reads go through `core/state.*`, and that file is intentionally short.
- **Reinventing a worse store.** When the app grows, devs pile features on signals that are starting to look like a half-broken store. Mitigation: the escalation rule is real — when 3+ features share state and middleware is wanted, supersede this ADR rather than hack around it.

## Related Decisions

- ADR-0003 (testing) — signals are trivially testable; pure derivations are the testing happy path.
- Future ADR (if escalating to a framework lib): superseding this one.
