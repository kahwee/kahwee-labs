# Repository guidance

This workspace contains runnable evidence for KahWee.com articles. Keep each lab
self-contained and reproducible; it is not a general-purpose shared library.

- Use the pnpm version in `package.json` and commit `pnpm-lock.yaml` with
  dependency changes. Run `pnpm verify` for TypeScript or dependency changes.
- A benchmark run changes evidence. Regenerate results only when the task calls
  for it or the measured behavior changes; keep prior runs intact.

## Structure and evidence

- Put explorable applications in `examples/` and measured experiments in
  `benchmarks/`.
- Commit benchmark scripts together with their raw JSON/CSV and derived summary.
  Do not hand-edit generated results or replace historical runs silently.
- Keep `packages/` empty until at least three real labs share maintained code.
- Preserve article backlinks and immutable evidence-tag guidance in lab READMEs.
