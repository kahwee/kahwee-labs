import { describe, expect, it } from 'vitest';
import { runComparison } from '../scripts/model';

describe('request policy comparison', () => {
  it('makes policy differences explicit across repeated visits', async () => {
    const comparison = await runComparison(15);
    expect(comparison.results).toEqual([
      { strategy: 'loader', navigations: 15, requests: 15 },
      { strategy: 'query-fresh', navigations: 15, requests: 1 },
      { strategy: 'query-stale', navigations: 15, requests: 15 },
    ]);
  });
});
