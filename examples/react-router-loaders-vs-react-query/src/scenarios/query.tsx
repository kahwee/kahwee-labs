import { zodResolver } from '@hookform/resolvers/zod';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { useForm } from 'react-hook-form';
import { getTasks, postTask, type TaskInput } from '../shared/api';
import { taskSchema } from '../shared/schema';

export function QueryScenario() {
  const client = useQueryClient();
  const query = useQuery({ queryKey: ['tasks'], queryFn: getTasks });
  const form = useForm<TaskInput>({ resolver: zodResolver(taskSchema), defaultValues: { title: '' } });
  const mutation = useMutation({ mutationFn: postTask, onSuccess: async () => { form.reset(); await client.invalidateQueries({ queryKey: ['tasks'] }); } });
  return <Scenario title="TanStack Query"><form onSubmit={form.handleSubmit((value) => mutation.mutate(value))}><input aria-label="Task title" {...form.register('title')} /><button disabled={mutation.isPending}>Add task</button>{form.formState.errors.title && <small>{form.formState.errors.title.message}</small>}</form>{query.isPending ? <p>Loading…</p> : <ul>{query.data?.map((task) => <li key={task.id}>{task.title}</li>)}</ul>}<pre>{`useQuery({ queryKey, queryFn })\nuseMutation({ mutationFn, onSuccess: invalidateQueries })`}</pre></Scenario>;
}
function Scenario({ title, children }: { title: string; children: React.ReactNode }) { return <section><h1>{title}</h1>{children}</section>; }
