import { beforeEach, describe, expect, it } from 'vitest';
import { getTasks, postTask, resetTasks } from '../src/shared/api';
beforeEach(resetTasks);
describe('shared API', () => { it('supports GET and validated POST', async () => { expect(await getTasks()).toHaveLength(2); await expect(postTask({ title: 'x' })).rejects.toBeTruthy(); await postTask({ title: 'Valid task' }); expect(await getTasks()).toHaveLength(3); }); });
