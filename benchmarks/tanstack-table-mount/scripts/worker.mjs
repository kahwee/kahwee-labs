import { JSDOM } from 'jsdom';
import { createHash } from 'node:crypto';
const [variant, countText, warmupsText = '2', samplesText = '8'] = process.argv.slice(2);
if (!['v8', 'v9'].includes(variant)) throw new Error('Expected v8 or v9');
const count = Number(countText), warmups = Number(warmupsText), samples = Number(samplesText);
if (![count, samples].every(n => Number.isInteger(n) && n > 0) || !Number.isInteger(warmups) || warmups < 0) throw new Error('Invalid counts');
const dom = new JSDOM('<!doctype html><html><head></head><body></body></html>', { pretendToBeVisual: true, url: 'http://localhost' });
for (const key of ['window', 'document', 'navigator', 'HTMLElement', 'Node', 'MutationObserver']) Object.defineProperty(globalThis, key, { value: dom.window[key], configurable: true });
const { createElement: h } = await import('react');
const { createRoot } = await import('react-dom/client');
const { flushSync } = await import('react-dom');
const { Provider } = await import('styletron-react');
const { Client } = await import('styletron-engine-atomic');
const { BaseProvider, LightTheme } = await import('baseui/index.js');
const ui = await import('baseui/table-semantic/index.js');
const api = await import(`table-${variant}`);
const data = Array.from({ length: count }, (_, i) => ({ id: i, name: `Person ${i}`, age: 20 + i % 60, city: ['Singapore', 'Seattle', 'San Francisco'][i % 3] }));
const columns = ['id', 'name', 'age', 'city'].map(accessorKey => ({ accessorKey, header: accessorKey }));
function Table() {
  const table = variant === 'v8'
    ? api.useReactTable({ data, columns, getCoreRowModel: api.getCoreRowModel() })
    : api.useTable({ data, columns, features: api.stockFeatures });
  return h(ui.StyledTable, null,
    h(ui.StyledTableHead, null, table.getHeaderGroups().map(group => h(ui.StyledTableHeadRow, { key: group.id }, group.headers.map(header => h(ui.StyledTableHeadCell, { key: header.id }, api.flexRender(header.column.columnDef.header, header.getContext())))))),
    h(ui.StyledTableBody, null, table.getRowModel().rows.map(row => h(ui.StyledTableBodyRow, { key: row.id }, row.getVisibleCells().map(cell => h(ui.StyledTableBodyCell, { key: cell.id }, String(cell.getValue())))))));
}
const durations = [];
let digest;
for (let iteration = 0; iteration < warmups + samples; iteration++) {
  // Fresh DOM container and style cache for every mount; module/JIT warm-up is separate.
  const styleContainer = document.createElement('div');
  document.head.append(styleContainer);
  const engine = new Client({ container: styleContainer });
  const container = document.createElement('div');
  document.body.append(container);
  const root = createRoot(container);
  const tree = h(Provider, { value: engine }, h(BaseProvider, { theme: LightTheme }, h(Table)));
  const start = performance.now();
  flushSync(() => root.render(tree));
  const duration = performance.now() - start;
  const rows = container.querySelectorAll('tbody tr');
  const cells = [...container.querySelectorAll('tbody td')];
  if (rows.length !== count || cells.length !== count * columns.length) throw new Error('Incomplete render');
  const expected = data.flatMap(row => columns.map(column => String(row[column.accessorKey])));
  if (cells.some((cell, i) => cell.textContent !== expected[i])) throw new Error('Cell content mismatch');
  digest = createHash('sha256').update(JSON.stringify(cells.map(cell => cell.textContent))).digest('hex');
  if (iteration >= warmups) durations.push(duration);
  flushSync(() => root.unmount());
  container.remove(); styleContainer.remove();
  await new Promise(resolve => setImmediate(resolve));
}
dom.window.close();
console.log(JSON.stringify({ variant, rows: count, warmups, durations, digest }));
