# KahWee Labs

Runnable evidence supporting [KahWee.com](https://kahwee.com/). This is a collection of self-contained article labs—not a library and not a dumping ground.

Use `examples/` for applications a reader can explore. Use `benchmarks/` for measured output, with the generating script and raw JSON or CSV committed together. `packages/` stays empty until at least three labs genuinely need the same maintained code.

```bash
corepack pnpm install
corepack pnpm verify
```

Run the current benchmark with:

```bash
corepack pnpm --filter @kahwee-labs/router-request-behavior benchmark
```

## Current investigations

- `examples/react-router-loaders-vs-react-query`: loader-only, Query-only, and hybrid approaches to GET, validated POST, and React Hook Form integration.
- `benchmarks/router-request-behavior`: request-behavior experiments derived from the comparison, intentionally separated from explanatory UI code.

Each published article should link to the current lab and an immutable evidence tag. Each lab links back to the article, the writing hub, and [KahWee’s About page](https://kahwee.com/about/).
