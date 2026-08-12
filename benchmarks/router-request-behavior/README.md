# Router request behavior benchmark

This first benchmark models a deliberately narrow question: how many requests result from 15 sequential visits to the same resource in one application session?

```bash
corepack pnpm --filter @kahwee-labs/router-request-behavior benchmark
```

| Strategy | Freshness policy | Requests for 15 visits |
| --- | --- | ---: |
| React Router loader model | Re-fetch on each visit | 15 |
| TanStack Query | `staleTime: 300_000` | 1 |
| TanStack Query | `staleTime: 0` | 15 |

The useful result is not “Query is faster.” It is that Query only changes request count when the application declares a freshness window. Its default stale policy does not provide the reduction.

This is a deterministic request-policy model, not a browser or wall-clock performance benchmark. It does not yet cover React Router `shouldRevalidate`, mutations, polling, focus, reconnect, rendering time, server CPU, or transferred bytes. Ad hoc runs go into ignored `results/raw/`; the reviewed summary is committed as `results/request-policy-summary.json`.
