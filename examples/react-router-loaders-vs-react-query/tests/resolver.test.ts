import { zodResolver } from '@hookform/resolvers/zod';
import { expect, it } from 'vitest';
import { taskSchema } from '../src/shared/schema';

it('preserves valid and invalid form validation through the resolver', async () => {
  const resolve = zodResolver(taskSchema);
  const options = { criteriaMode: 'firstError' as const, fields: {}, shouldUseNativeValidation: false };
  const valid = await resolve({ title: '  Valid task  ' }, undefined, options);
  expect(valid.values).toEqual({ title: 'Valid task' });
  expect(valid.errors).toEqual({});
  const invalid = await resolve({ title: 'x' }, undefined, options);
  expect(invalid.values).toEqual({});
  expect(invalid.errors.title?.message).toBe('Use at least three characters');
});
