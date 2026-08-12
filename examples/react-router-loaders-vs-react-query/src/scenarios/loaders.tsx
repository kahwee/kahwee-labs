import { zodResolver } from '@hookform/resolvers/zod';
import { useForm } from 'react-hook-form';
import { data, Form, redirect, useLoaderData, useNavigation, useSubmit } from 'react-router';
import { getTasks, postTask, type TaskInput } from '../shared/api';
import { taskSchema } from '../shared/schema';

export async function tasksLoader() { return { tasks: await getTasks() }; }
export async function tasksAction({ request }: { request: Request }) { const parsed = taskSchema.safeParse(Object.fromEntries(await request.formData())); if (!parsed.success) return data({ errors: parsed.error.flatten().fieldErrors }, { status: 400 }); await postTask(parsed.data); return redirect('/loaders'); }
export function LoadersScenario() {
  const { tasks } = useLoaderData<typeof tasksLoader>();
  const navigation = useNavigation();
  const submit = useSubmit();
  const form = useForm<TaskInput>({ resolver: zodResolver(taskSchema), defaultValues: { title: '' } });
  return <section><h1>React Router loaders</h1><Form method="post" onSubmit={form.handleSubmit((value) => submit(value, { method: 'post' }))}><input aria-label="Task title" {...form.register('title')} /><button disabled={navigation.state !== 'idle'}>Add task</button>{form.formState.errors.title && <small>{form.formState.errors.title.message}</small>}</Form><ul>{tasks.map((task) => <li key={task.id}>{task.title}</li>)}</ul><pre>{`loader() → GET\naction() → POST → automatic loader revalidation`}</pre></section>;
}
