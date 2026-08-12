import { mkdir, writeFile } from 'node:fs/promises';
import { resolve } from 'node:path';
import { runComparison } from './model.ts';

const navigations = Number(process.env.NAVIGATIONS ?? 15);
if (!Number.isInteger(navigations) || navigations < 1) throw new Error('NAVIGATIONS must be a positive integer.');
const comparison = await runComparison(navigations);
const output = {
  generatedAt: new Date().toISOString(),
  versions: { '@tanstack/query-core': '5.101.4' },
  caveat: 'This is a deterministic request-policy model, not a wall-clock performance benchmark.',
  ...comparison,
};
const rawDirectory = resolve('results/raw');
await mkdir(rawDirectory, { recursive: true });
const target = resolve(rawDirectory, `${output.generatedAt.replaceAll(':', '-')}.json`);
await writeFile(target, `${JSON.stringify(output, null, 2)}\n`);
console.table(output.results);
console.log(`Raw result: ${target}`);
