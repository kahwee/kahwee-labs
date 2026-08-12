import { taskSchema, type Task, type TaskInput } from './schema';
let tasks: Task[] = [{ id: 1, title: 'Compare the GET path' }, { id: 2, title: 'Compare the POST path' }];
const wait = () => new Promise((resolve) => setTimeout(resolve, 120));
export async function getTasks() { await wait(); return structuredClone(tasks); }
export async function postTask(input: unknown) { await wait(); const parsed = taskSchema.safeParse(input); if (!parsed.success) throw parsed.error; const task: Task = { id: Math.max(0, ...tasks.map(({ id }) => id)) + 1, ...parsed.data }; tasks = [...tasks, task]; return task; }
export function resetTasks() { tasks = [{ id: 1, title: 'Compare the GET path' }, { id: 2, title: 'Compare the POST path' }]; }
export type { TaskInput };
