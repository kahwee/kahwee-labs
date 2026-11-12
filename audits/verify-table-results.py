"""Independent evidence audit; run from the repository root with Python 3."""
import csv
import hashlib
import json
import math
import statistics
from pathlib import Path

base = Path('benchmarks/tanstack-table-mount')
selected = '2026-11-12T16-12-23.536Z'
rows = []
blocks = []
for path in sorted((base / 'results').glob('*/raw.json')):
    data = json.loads(path.read_text())
    samples = list(csv.DictReader((path.parent / 'samples.csv').open()))
    expected = [(str(r['block']), r['variant'], str(r['rows']), str(i), value)
                for r in data['runs'] for i, value in enumerate(r['durations'])]
    actual = [(r['block'], r['variant'], r['rows'], r['sample'], float(r['milliseconds'])) for r in samples]
    assert actual == expected, path
    for name, digest in data['environment']['hashes'].items():
        assert hashlib.sha256((base / name).read_bytes()).hexdigest() == digest, name
    for summary in data['summary']:
        count = summary['rows']
        matching = [r for r in data['runs'] if r['rows'] == count]
        assert len(set(r['digest'] for r in matching)) == 1
        for variant in ['v8', 'v9']:
            values = sorted(v for r in matching if r['variant'] == variant for v in r['durations'])
            assert len(values) == 16 and all(math.isfinite(v) and v > 0 for v in values)
            for name, fraction in [('p25', .25), ('median', .5), ('p75', .75), ('p95', .95)]:
                index = (len(values) - 1) * fraction
                low, high = math.floor(index), math.ceil(index)
                result = values[low] + (values[high] - values[low]) * (index - low)
                assert math.isclose(result, summary[variant][name], abs_tol=1e-10)
        change = (summary['v9']['median'] / summary['v8']['median'] - 1) * 100
        assert math.isclose(change, summary['medianChangePercent'], abs_tol=1e-10)
        rows.append(f"| {path.parent.name} | {count} | {summary['v8']['median']:.2f} | {summary['v9']['median']:.2f} | {change:+.2f}% |")
        for block in [0, 1]:
            medians = {r['variant']: statistics.median(r['durations']) for r in matching if r['block'] == block}
            change = (medians['v9'] / medians['v8'] - 1) * 100
            blocks.append(f'| {path.parent.name} | {count} | {block} | {change:+.2f}% |')
print('# Independent table benchmark checks\n\nPASS: all saved CSV rows, JSON quantiles, percentage calculations, fixture digests and current source/lockfile hashes agree.\n')
print('| Run (UTC) | Rows | v8 median ms | v9 median ms | v9 change |\n|---|---:|---:|---:|---:|')
print('\n'.join(rows))
print('\n## Process-level comparison\n\n| Run | Rows | Block | v9 median change |\n|---|---:|---:|---:|')
print('\n'.join(blocks))
