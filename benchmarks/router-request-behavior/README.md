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

This is a deterministic request-policy model, not a browser or wall-clock performance benchmark. It does not yet cover React Router `shouldRevalidate`, mutations, polling, focus, reconnect, rendering time, server CPU, or transferred bytes. The reviewed summary is committed as `results/request-policy-summary.json`.

## Evidence links

- Article: [I Default to React Router Loaders Until Caching Hurts](https://kahwee.com/2025/react-router-v7-loaders-vs-react-query/)
- Topic hub: [Frontend writing](https://kahwee.com/writing/)
- Author: [About KahWee](https://kahwee.com/about/)

Raw runs under `results/raw/` are committed alongside the reviewed summary so results can be traced back to machine-readable output.
