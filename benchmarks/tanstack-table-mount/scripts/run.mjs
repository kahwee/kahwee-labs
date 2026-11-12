import { execFileSync } from 'node:child_process';
import { mkdirSync, writeFileSync, readFileSync } from 'node:fs';
import { cpus, platform, release, arch, totalmem } from 'node:os';
import { createHash } from 'node:crypto';
import { fileURLToPath } from 'node:url';
import { summarize } from './stats.mjs';
const cwd = fileURLToPath(new URL('../', import.meta.url));
process.chdir(cwd);
const runs = [];
// Two isolated processes per variant/size, reversing order in the second block.
for (let block = 0; block < 2; block++) {
  for (const rows of [100, 1000, 5000]) {
    for (const variant of block === 0 ? ['v8', 'v9'] : ['v9', 'v8']) {
      process.stderr.write(`Block ${block + 1}: ${variant}, ${rows} rows\n`);
      const output = execFileSync(process.execPath, ['scripts/worker.mjs', variant, String(rows), '2', '8'], { encoding: 'utf8', env: { ...process.env, NODE_ENV: 'production' }, maxBuffer: 1024 * 1024 });
      runs.push({ block, ...JSON.parse(output.trim()) });
    }
  }
}
const summary = [100, 1000, 5000].map(rows => {
  const matching = runs.filter(run => run.rows === rows);
  if (new Set(matching.map(run => run.digest)).size !== 1) throw new Error('Variant output differs');
  const v8 = summarize(matching.filter(run => run.variant === 'v8').flatMap(run => run.durations));
  const v9 = summarize(matching.filter(run => run.variant === 'v9').flatMap(run => run.durations));
  return { rows, v8, v9, medianChangePercent: (v9.median / v8.median - 1) * 100 };
});
const generatedAt = new Date().toISOString();
const git = (...args) => execFileSync('git', args, { encoding: 'utf8' }).trim();
const hashes = Object.fromEntries(['scripts/worker.mjs', 'scripts/run.mjs', 'scripts/stats.mjs', '../../pnpm-lock.yaml'].map(path => [path, createHash('sha256').update(readFileSync(path)).digest('hex')]));
const result = { generatedAt, environment: { node: process.version, platform: platform(), release: release(), arch: arch(), cpu: cpus()[0].model, logicalCpus: cpus().length, memoryBytes: totalmem(), nodeEnv: 'production', baseCommit: git('rev-parse', 'HEAD'), workingTree: git('status', '--short'), dependencies: JSON.parse(readFileSync('package.json')).dependencies, hashes }, methodology: { warmupsPerProcess: 2, samplesPerProcess: 8, processesPerVariantAndSize: 2, timer: 'performance.now around flushSync(root.render)', quantiles: 'linear interpolation at (n-1)*p', forcedGC: false }, runs, summary };
const folder = `results/${generatedAt.replaceAll(':', '-')}`;
mkdirSync(folder, { recursive: true });
writeFileSync(`${folder}/raw.json`, JSON.stringify(result, null, 2) + '\n');
writeFileSync(`${folder}/samples.csv`, 'block,variant,rows,sample,milliseconds\n' + runs.flatMap(run => run.durations.map((ms, i) => `${run.block},${run.variant},${run.rows},${i},${ms}`)).join('\n') + '\n');
writeFileSync(`${folder}/summary.md`, '# Table mount results\n\n' + `Measured ${generatedAt}. Milliseconds; 16 measured mounts per cell, after warm-ups.\n\n` + '| Rows | v8 median (p25–p75) | v9 median (p25–p75) | Median change |\n|---:|---:|---:|---:|\n' + summary.map(r => `| ${r.rows} | ${r.v8.median.toFixed(2)} (${r.v8.p25.toFixed(2)}–${r.v8.p75.toFixed(2)}) | ${r.v9.median.toFixed(2)} (${r.v9.p25.toFixed(2)}–${r.v9.p75.toFixed(2)}) | ${r.medianChangePercent.toFixed(1)}% |`).join('\n') + '\n');
console.log(JSON.stringify({ folder, summary }, null, 2));
