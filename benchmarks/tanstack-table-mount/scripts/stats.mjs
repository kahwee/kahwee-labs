export function quantile(values, fraction) {
  const sorted = [...values].sort((a, b) => a - b);
  if (!sorted.length) throw new Error('No samples');
  const index = (sorted.length - 1) * fraction;
  const lower = Math.floor(index), upper = Math.ceil(index);
  return sorted[lower] + (sorted[upper] - sorted[lower]) * (index - lower);
}
export function summarize(values) {
  return Object.fromEntries([['p25', .25], ['median', .5], ['p75', .75], ['p95', .95]].map(([name, fraction]) => [name, quantile(values, fraction)]));
}
