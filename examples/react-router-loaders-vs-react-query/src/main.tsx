import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { createRoot } from 'react-dom/client';
import { createBrowserRouter, Link, Outlet, RouterProvider } from 'react-router';
import { LoadersScenario, tasksAction, tasksLoader } from './scenarios/loaders';
import { QueryScenario } from './scenarios/query';
import './style.css';

function Layout() { return <main><nav><Link to="/loaders">Loaders/actions</Link><Link to="/query">TanStack Query</Link></nav><Outlet /></main>; }
const router = createBrowserRouter([{ Component: Layout, children: [{ index: true, loader: () => { location.replace('/loaders'); return null; } }, { path: 'loaders', loader: tasksLoader, action: tasksAction, Component: LoadersScenario }, { path: 'query', Component: QueryScenario }] }]);
const client = new QueryClient();
createRoot(document.getElementById('root')!).render(<QueryClientProvider client={client}><RouterProvider router={router} /></QueryClientProvider>);
