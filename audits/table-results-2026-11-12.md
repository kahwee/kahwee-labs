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

## Interpretation

The three 17:02 UTC reruns used the unmodified published harness, sequentially, without a concurrent repository build/test from this task. Background desktop activity, CPU temperature and power conditions were not controlled. Each rerun contains 96 measured mounts; all 288 additional mounts passed cell-content validation.

The selected 16:12 run's values also exactly match the local article chart. Installed package versions match the recorded pins. The 16:11 development run remains excluded from the article because it overlapped verification. No samples were discarded from the three new runs.

At 5,000 rows the new run-level changes are -22.32%, -8.44%, and -0.02%. One individual process block reverses the direction (+3.40%). At 100 rows the final rerun favors v8 (+6.89% v9 duration). At 1,000 rows all three new pooled medians favor v9, but one block reverses direction. This is evidence of variability, not a reliable universal speedup. No significance test treating the 16 related mounts as independent observations is justified here.

The old reported 3,007.87/2,147.38 ms measurements and bundle sizes cannot be validated without their original harness and build recipe. These reconstructed timings use production React, a new dataset and renderer, and jsdom directly rather than the missing Vitest setup. Their absolute scale differs markedly; comparing their percentages is not a controlled replication.

The fixture uses BaseUI styled semantic elements and direct cell values, not the complete baseui-data-table component, custom cell renderers, interactions, virtualization or a production browser. Output equality checks body cells, not complete styling/accessibility/interaction equivalence. Two warm-up mounts do not demonstrate JIT convergence; two process blocks offer weak protection from environmental drift. The timer includes several layers and cannot attribute any difference specifically to TanStack internals. Sample-range overlap alone is not a statistical significance test.

Recommendation: describe the result as similar mounting costs with unstable differences in this fixture. Keep every run. Before recommending migration for speed, measure a representative component in a real browser, include interactions, randomize paired process order over more independent blocks, record power/load conditions, and define the comparison before running it. The bundle-size claim needs its own fixed build recipe.

No article edits or publication were performed by this audit. New samples and this audit are local and uncommitted; the existing evidence tag is unchanged.
