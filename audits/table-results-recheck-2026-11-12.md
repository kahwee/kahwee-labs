# Independent table benchmark checks

PASS: all saved CSV rows, JSON quantiles, percentage calculations, fixture digests and current source/lockfile hashes agree.

| Run (UTC) | Rows | v8 median ms | v9 median ms | v9 change |
|---|---:|---:|---:|---:|
| 2026-11-12T16-11-55.968Z | 100 | 5.97 | 6.46 | +8.25% |
| 2026-11-12T16-11-55.968Z | 1000 | 55.09 | 57.75 | +4.84% |
| 2026-11-12T16-11-55.968Z | 5000 | 259.98 | 236.85 | -8.90% |
| 2026-11-12T16-12-23.536Z | 100 | 6.28 | 6.17 | -1.75% |
| 2026-11-12T16-12-23.536Z | 1000 | 50.26 | 47.07 | -6.35% |
| 2026-11-12T16-12-23.536Z | 5000 | 243.96 | 233.79 | -4.17% |
| 2026-11-12T17-02-17.886Z | 100 | 7.97 | 6.81 | -14.51% |
| 2026-11-12T17-02-17.886Z | 1000 | 57.02 | 56.04 | -1.72% |
| 2026-11-12T17-02-17.886Z | 5000 | 339.94 | 264.06 | -22.32% |
| 2026-11-12T17-02-39.755Z | 100 | 6.70 | 6.46 | -3.51% |
| 2026-11-12T17-02-39.755Z | 1000 | 63.09 | 50.14 | -20.53% |
| 2026-11-12T17-02-39.755Z | 5000 | 265.87 | 243.42 | -8.44% |
| 2026-11-12T17-02-59.842Z | 100 | 6.10 | 6.52 | +6.89% |
| 2026-11-12T17-02-59.842Z | 1000 | 50.92 | 47.22 | -7.27% |
| 2026-11-12T17-02-59.842Z | 5000 | 247.66 | 247.61 | -0.02% |
| 2026-11-12T17-58-27.298Z | 100 | 6.06 | 6.02 | -0.73% |
| 2026-11-12T17-58-27.298Z | 1000 | 48.75 | 45.43 | -6.82% |
| 2026-11-12T17-58-27.298Z | 5000 | 238.50 | 225.38 | -5.50% |
| 2026-11-12T17-58-45.922Z | 100 | 6.33 | 6.18 | -2.29% |
| 2026-11-12T17-58-45.922Z | 1000 | 50.79 | 46.91 | -7.64% |
| 2026-11-12T17-58-45.922Z | 5000 | 242.13 | 227.37 | -6.10% |

## Process-level comparison

| Run | Rows | Block | v9 median change |
|---|---:|---:|---:|
| 2026-11-12T16-11-55.968Z | 100 | 0 | +4.17% |
| 2026-11-12T16-11-55.968Z | 100 | 1 | +19.40% |
| 2026-11-12T16-11-55.968Z | 1000 | 0 | +12.40% |
| 2026-11-12T16-11-55.968Z | 1000 | 1 | -14.69% |
| 2026-11-12T16-11-55.968Z | 5000 | 0 | -8.32% |
| 2026-11-12T16-11-55.968Z | 5000 | 1 | -5.57% |
| 2026-11-12T16-12-23.536Z | 100 | 0 | -0.02% |
| 2026-11-12T16-12-23.536Z | 100 | 1 | -0.87% |
| 2026-11-12T16-12-23.536Z | 1000 | 0 | -7.11% |
| 2026-11-12T16-12-23.536Z | 1000 | 1 | -5.31% |
| 2026-11-12T16-12-23.536Z | 5000 | 0 | -3.47% |
| 2026-11-12T16-12-23.536Z | 5000 | 1 | -4.45% |
| 2026-11-12T17-02-17.886Z | 100 | 0 | -0.95% |
| 2026-11-12T17-02-17.886Z | 100 | 1 | -18.64% |
| 2026-11-12T17-02-17.886Z | 1000 | 0 | -5.22% |
| 2026-11-12T17-02-17.886Z | 1000 | 1 | +9.97% |
| 2026-11-12T17-02-17.886Z | 5000 | 0 | -8.60% |
| 2026-11-12T17-02-17.886Z | 5000 | 1 | -42.47% |
| 2026-11-12T17-02-39.755Z | 100 | 0 | -6.22% |
| 2026-11-12T17-02-39.755Z | 100 | 1 | +8.34% |
| 2026-11-12T17-02-39.755Z | 1000 | 0 | -20.06% |
| 2026-11-12T17-02-39.755Z | 1000 | 1 | -20.97% |
| 2026-11-12T17-02-39.755Z | 5000 | 0 | -19.61% |
| 2026-11-12T17-02-39.755Z | 5000 | 1 | -2.85% |
| 2026-11-12T17-02-59.842Z | 100 | 0 | +14.43% |
| 2026-11-12T17-02-59.842Z | 100 | 1 | -0.21% |
| 2026-11-12T17-02-59.842Z | 1000 | 0 | -9.53% |
| 2026-11-12T17-02-59.842Z | 1000 | 1 | -4.83% |
| 2026-11-12T17-02-59.842Z | 5000 | 0 | -6.33% |
| 2026-11-12T17-02-59.842Z | 5000 | 1 | +3.37% |
| 2026-11-12T17-58-27.298Z | 100 | 0 | -0.73% |
| 2026-11-12T17-58-27.298Z | 100 | 1 | +0.37% |
| 2026-11-12T17-58-27.298Z | 1000 | 0 | -5.68% |
| 2026-11-12T17-58-27.298Z | 1000 | 1 | -8.93% |
| 2026-11-12T17-58-27.298Z | 5000 | 0 | -3.93% |
| 2026-11-12T17-58-27.298Z | 5000 | 1 | -5.79% |
| 2026-11-12T17-58-45.922Z | 100 | 0 | -0.54% |
| 2026-11-12T17-58-45.922Z | 100 | 1 | -3.50% |
| 2026-11-12T17-58-45.922Z | 1000 | 0 | -9.17% |
| 2026-11-12T17-58-45.922Z | 1000 | 1 | -8.30% |
| 2026-11-12T17-58-45.922Z | 5000 | 0 | -5.50% |
| 2026-11-12T17-58-45.922Z | 5000 | 1 | -6.13% |

## Follow-up interpretation

Two further sequential runs of the unchanged harness at 17:58 UTC added 192 measured mounts; every mount passed fixture validation. At 5,000 rows, medians were 238.49625/225.37550 ms and 242.13340/227.36700 ms for v8/v9: reductions of 5.50% and 6.10%. Both independent process blocks favored v9 at 1,000 and 5,000 rows. The 100-row result remained small and one block favored v8.

Independent verification again passed for all saved CSV rows, JSON summaries, percentages, output digests and source/lockfile hashes. The article chart exactly matches its selected original run. The existing quantile and cross-version fixture tests passed after timings finished. No benchmark code or dependency changes, concurrent build/test from this task, or discarded new samples. Background machine activity was not controlled.

These two runs support a modest advantage in this fixture and are close to the published 4.17% observation. They do not erase the prior near-tie or broad variability. The article's chart is numerically accurate but should identify itself as one run and include the repeated-run variability before implying a dependable improvement. The original roughly 29% claim and bundle savings remain unverified. The official migration guide was reread: https://tanstack.com/table/latest/docs/framework/react/guide/migrating . Its broader performance claims concern additional workloads and do not validate this mount fixture.

No public article, evidence tag or repository publication changed during this follow-up. Results remain local.
