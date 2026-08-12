# React Router loaders vs TanStack Query

Runnable evidence for [I Default to React Router Loaders Until Caching Hurts](https://kahwee.com/2025/react-router-v7-loaders-vs-react-query/).

Also see [Frontend writing](https://kahwee.com/writing/) and [About KahWee](https://kahwee.com/about/).

## Question

When should route data use loaders, TanStack Query, or both?

## Scenarios

- Loader-owned initial data and automatic revalidation after a route action.
- Query-owned GET, mutation, and explicit cache invalidation.
- Loader-seeded Query data with a five-minute freshness window.
- Validated POST with Zod at the data boundary.
- React Hook Form integration in all three ownership models.

Only domain types, deterministic mock data, validation, and endpoint behavior are shared. The competing orchestration code remains separate under `src/scenarios/`.

## Tested with

- Node: 24.16.0
- React: 19.2.8
- React Router: 8.3.0
- TanStack Query: 5.101.4
- React Hook Form: 7.62.0
- Last verified: 2026-08-12

## Run

```bash
corepack pnpm install
corepack pnpm --filter @kahwee-labs/react-router-loaders-vs-react-query dev
```

Open `http://localhost:5173`, then move among `/loaders`, `/query`, and `/hybrid`.

[Run in StackBlitz](https://stackblitz.com/github/kahwee/kahwee-labs/tree/main/examples/react-router-loaders-vs-react-query)

## Expected results

- Loaders/actions express page-owned CRUD with the least cache coordination.
- Query makes cache identity, freshness, mutation callbacks, and invalidation explicit.
- The hybrid gives route-critical initial data to the loader and longer-lived ownership to Query.
- React Hook Form needs a small submission adapter when React Router’s `<Form>` also participates.

## Limitations

This is a client-rendered comparison using a deterministic in-memory endpoint. It does not prove SSR performance, database behavior, bundle-size differences, server CPU, or a universal default. Measured request-policy work lives in `benchmarks/router-request-behavior/`.
