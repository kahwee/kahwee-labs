import { QueryClient } from '@tanstack/query-core';

export type RunResult = {
  strategy: 'loader' | 'query-fresh' | 'query-stale';
  navigations: number;
  requests: number;
};

const createRequestCounter = () => {
  let requests = 0;
  return {
    request: async () => { requests += 1; return { tasks: [] }; },
    count: () => requests,
  };
};

export async function runLoaderScenario(navigations: number): Promise<RunResult> {
  const api = createRequestCounter();
  for (let index = 0; index < navigations; index += 1) await api.request();
  return { strategy: 'loader', navigations, requests: api.count() };
}

export async function runQueryScenario(navigations: number, staleTime: number): Promise<RunResult> {
  const api = createRequestCounter();
  const queryClient = new QueryClient({ defaultOptions: { queries: { staleTime, retry: false } } });
  for (let index = 0; index < navigations; index += 1) {
    await queryClient.fetchQuery({ queryKey: ['tasks'], queryFn: api.request });
  }
  return { strategy: staleTime > 0 ? 'query-fresh' : 'query-stale', navigations, requests: api.count() };
}

export async function runComparison(navigations = 15) {
  return {
    methodology: 'Sequential visits to the same task resource in one application session.',
    navigations,
    results: [
      await runLoaderScenario(navigations),
      await runQueryScenario(navigations, 300_000),
      await runQueryScenario(navigations, 0),
    ],
  };
}
