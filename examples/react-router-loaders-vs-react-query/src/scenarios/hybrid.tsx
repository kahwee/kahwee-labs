import { zodResolver } from '@hookform/resolvers/zod';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { useForm } from 'react-hook-form';
import { useLoaderData } from 'react-router';
import { getTasks, postTask, type TaskInput } from '../shared/api';
import { taskSchema } from '../shared/schema';
import { tasksLoader } from './loaders';

export function HybridScenario() {
  const { tasks: initialTasks } = useLoaderData<typeof tasksLoader>();
  const client = useQueryClient();
  const query = useQuery({ queryKey: ['hybrid-tasks'], queryFn: getTasks, initialData: initialTasks, staleTime: 300_000 });
  const form = useForm<TaskInput>({ resolver: zodResolver(taskSchema), defaultValues: { title: '' } });
  const mutation = useMutation({ mutationFn: postTask, onSuccess: async () => { form.reset(); await client.invalidateQueries({ queryKey: ['hybrid-tasks'] }); } });
  return <section><h1>Hybrid</h1><form onSubmit={form.handleSubmit((value) => mutation.mutate(value))}><input aria-label="Task title" {...form.register('title')} /><button disabled={mutation.isPending}>Add task</button>{form.formState.errors.title && <small>{form.formState.errors.title.message}</small>}</form><ul>{query.data.map((task) => <li key={task.id}>{task.title}</li>)}</ul><pre>{`loader() → initial route data\nuseQuery({ initialData, staleTime }) → long-lived cache\nuseMutation() → invalidation`}</pre></section>;
}
