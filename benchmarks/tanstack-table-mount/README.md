# TanStack Table v8 / v9 DOM mounts

A reconstructed benchmark for [Evaluating a TanStack Table v9 Upgrade](https://kahwee.com/2026/migrating-tanstack-table-v8-to-v9/). This is a new experiment, not the missing original Vitest harness.

## Reproduce

From the repository root, with its pinned pnpm version and Node 26.13.0:

```sh
pnpm install --frozen-lockfile
pnpm verify
pnpm --filter @kahwee-labs/tanstack-table-mount benchmark
```

Run the benchmark after verification finishes, without another build or benchmark running. Each invocation writes a new timestamped directory containing raw JSON, individual CSV samples and a generated Markdown summary. Keep earlier directories intact. The JSON captures package pins, operating system, CPU, runtime, source/lockfile hashes and checkout state.

## What is timed

- Table v8.21.3's `useReactTable` and core row model versus v9.1.0's `useTable` with `stockFeatures`.
- Identical deterministic 100, 1,000 and 5,000-row datasets, four columns, BaseUI semantic table elements, Styletron and production React 19.3.1.
- `performance.now()` around synchronous React rendering into jsdom 31.0.0. Root creation, provider element construction, imports, data generation, correctness checks and unmounting are outside the timer. Table construction, row-model work, element rendering, style generation and DOM commit are inside it.
- Two fresh processes per version/size, with v8 first in block one and v9 first in block two. Each process excludes two warm-ups, then retains eight mounts: 16 measured samples per version/size. Every mount gets a fresh DOM container and style cache; modules and JIT state remain warm within a process. Garbage collection is automatic, not forced.
- Every cell is checked against the fixture after every mount. Content hashes must match across versions. Quantiles use linear interpolation at `(n - 1) * p`.

This measures this renderer's DOM mounting, not browser layout, paint, scrolling or interaction. No virtualization, sorting or selection action is exercised. The full stock feature path is intentional; this does not evaluate minimal-feature bundle size. Samples within a process are related, and two processes are not enough for a broad performance claim. Compare the distributions, not just the median.

BaseUI's dependency tree includes older React peer ranges in unused virtualization packages. The semantic table path passes the parity test on the pinned React version. The unused core-js install script is explicitly disabled in workspace configuration.

## Evidence

The initial reconstruction is pinned by `tanstack-table-mount-v1`. The complete follow-up evidence is pinned by `tanstack-table-mount-v2`; neither tag should be moved. See the [ten-pass summary](../../audits/ten-pass-summary-2026-11-12.md), [exact run manifest](../../audits/ten-pass-manifest-2026-11-12.json), and timestamped result directories. The earlier three-pass and two-pass audits remain alongside them, including the near-tie and noisier runs.

The ten-pass batch contains 960 measured mounts. V9 had lower medians in all ten passes at 1,000 and 5,000 rows. The median of pass-level reductions was 7.60% and 4.81%, respectively; 100-row results were mixed. These results support a modest advantage in this fixture, not a fixed speedup across applications. Run `python3 audits/verify-table-results.py` from the repository root to independently check all saved samples and calculations against the unchanged harness.

The first development run, `2026-11-12T16-11-55.968Z`, overlapped repository verification at its start. It is retained for transparency and excluded from the article. The subsequent run was made after verification completed; ordinary desktop activity was not controlled.

Original article observations were 334.13/253.74 ms (100 rows), 864.45/613.98 ms (1,000), and 3007.87/2147.38 ms (5,000), v8/v9 respectively. It also reported 38.0/14.1 kB minified. The original harness, raw samples and bundle recipe were not recovered. Those values are historical reports, not results reproduced by this lab.

More: [Blog](https://kahwee.com/writing/) · [About KahWee](https://kahwee.com/about/).
