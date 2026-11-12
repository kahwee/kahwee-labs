# Ten-pass benchmark audit — November 12, 2026

Ten sequential complete passes of the unchanged harness. 960 measured mounts, plus 240 excluded warm-ups. All fixture checks passed. No new samples discarded. Background desktop activity was uncontrolled.

| Pass | 100 rows: v9 change | 1,000 rows: v9 change | 5,000 rows: v9 change |
|---:|---:|---:|---:|
| 1 | +2.13% | -6.86% | -6.24% |
| 2 | -2.61% | -5.67% | -2.04% |
| 3 | +1.85% | -9.44% | -3.61% |
| 4 | +4.56% | -9.75% | -3.72% |
| 5 | -0.17% | -3.84% | -3.53% |
| 6 | -1.40% | -4.73% | -5.38% |
| 7 | -1.61% | -9.40% | -5.60% |
| 8 | -1.39% | -7.93% | -5.21% |
| 9 | +2.06% | -7.74% | -5.01% |
| 10 | -4.80% | -7.47% | -4.61% |

Negative means lower v9 mount time. Percentages compare medians within each pass.

| Rows | Passes with lower v9 median | Median of pass-level reductions | Reduction range |
|---:|---:|---:|---:|
| 100 | 6/10 | 0.78% | -4.56% to 4.80% |
| 1000 | 10/10 | 7.60% | 3.84% to 9.75% |
| 5000 | 10/10 | 4.81% | 2.04% to 6.24% |

Independent verification passed for all saved CSV records, JSON quantiles, percentage calculations, fixture digests and current source/lockfile hashes. The ten-pass manifest identifies the exact run folders; earlier runs remain separate and intact.

These ten passes support a modest, repeatable advantage at 1,000 and 5,000 rows in this fixture. Small-table differences are inconsistent. The 5,000-row results are compatible with the article’s selected 4.17% observation; they do not reproduce the historical 29% claim. Earlier variability and the near-tie remain relevant and are not erased by this batch.

This is production React mounting a simple four-column BaseUI table into jsdom, not the complete migrated component, browser paint, interactions or bundle size. Repeated samples within a process are related. No inference of a universal speedup or statistical independence is made.

The public article and immutable v1 tag are unchanged.
