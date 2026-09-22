# Repository guidance

This workspace contains runnable evidence for KahWee.com articles. Keep each lab
self-contained and reproducible; it is not a general-purpose shared library.

## Workflow

- Use pnpm via Corepack and keep `pnpm-lock.yaml` committed.
- Check `git status --short --branch` before editing and preserve unrelated work.
- Run `corepack pnpm verify` for TypeScript or dependency changes.
- Use the narrow workspace filter while iterating, then run the root verification
  before committing.
- Do not publish, deploy, or regenerate benchmark results unless the task calls
  for it. A push is not authorization to publish an article.

## Structure and evidence

- Put explorable applications in `examples/` and measured experiments in
  `benchmarks/`.
- Commit benchmark scripts together with their raw JSON/CSV and derived summary.
  Do not hand-edit generated results or replace historical runs silently.
- Keep `packages/` empty until at least three real labs share maintained code.
- Preserve article backlinks and immutable evidence-tag guidance in lab READMEs.

## Greenkeeping

- Start with `corepack pnpm outdated` and `corepack pnpm audit`.
- Prefer focused compatible updates. Isolate major React, React Router, TanStack,
  Vite, Vitest, or TypeScript upgrades from unrelated lab changes.
- Keep the pnpm version in `package.json` and CI aligned.
- Dependency updates must pass `corepack pnpm verify`; rerun a benchmark only
  when its runtime behavior or measured dependency changed.
