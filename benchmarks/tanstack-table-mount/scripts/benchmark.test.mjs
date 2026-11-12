import { test } from 'node:test';
import assert from 'node:assert/strict';
import { execFileSync } from 'node:child_process';
import { quantile } from './stats.mjs';
test('quantiles interpolate without changing samples', () => {
  const values = [9, 1, 5, 3];
  assert.equal(quantile(values, .5), 4);
  assert.equal(quantile(values, .25), 2.5);
  assert.deepEqual(values, [9, 1, 5, 3]);
  assert.throws(() => quantile([], .5));
});
test('versions render the same complete fixture', () => {
  const run = variant => JSON.parse(execFileSync(process.execPath, ['scripts/worker.mjs', variant, '20', '0', '1'], { encoding: 'utf8', env: { ...process.env, NODE_ENV: 'production' } }));
  const a = run('v8'), b = run('v9');
  assert.equal(a.digest, b.digest);
  assert.ok(a.durations[0] > 0 && b.durations[0] > 0);
});
