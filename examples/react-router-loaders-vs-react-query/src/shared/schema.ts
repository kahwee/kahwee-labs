import { z } from 'zod';
export const taskSchema = z.object({ title: z.string().trim().min(3, 'Use at least three characters').max(80) });
export type TaskInput = z.infer<typeof taskSchema>;
export type Task = TaskInput & { id: number };
