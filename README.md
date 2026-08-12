# KahWee Labs

Reproducible companion code for investigations published on kahwee.com. Examples explain API shape and integration tradeoffs; benchmarks isolate measurements and retain raw results.

```bash
corepack pnpm install
corepack pnpm verify
```

Run the current benchmark with:

```bash
corepack pnpm --filter @kahwee-labs/router-request-behavior benchmark
```

## Current investigations

- `examples/react-router-loaders-vs-react-query`: the same GET, validated POST, and React Hook Form integration implemented with route loaders/actions and TanStack Query.
- `benchmarks/router-request-behavior`: request-behavior experiments derived from the comparison, intentionally separated from explanatory UI code.
