import { beforeEach, describe, expect, it } from 'vitest';
import { getTasks, postTask, resetTasks } from '../src/shared/api';
beforeEach(resetTasks);
it('does not expose stored tasks through POST responses', async () => {
  const response = await postTask({ title: 'Original title' });
  response.title = 'Changed by the caller';
  expect((await getTasks()).find(({ id }) => id === response.id)?.title).toBe('Original title');
});
describe('shared API', () => { it('supports GET and validated POST', async () => { expect(await getTasks()).toHaveLength(2); await expect(postTask({ title: 'x' })).rejects.toBeTruthy(); await postTask({ title: 'Valid task' }); expect(await getTasks()).toHaveLength(3); }); });
