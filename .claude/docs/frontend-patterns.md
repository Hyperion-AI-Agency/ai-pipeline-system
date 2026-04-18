# Frontend Code Patterns

## File Organization

- **Route-specific components** → `routes/app/videos/_components/shots-table.tsx`
- **Shared components** → `src/components/dashboard/`, `src/components/ui/`, `src/components/layout/`
- **Utility functions** → `src/lib/format.ts` (formatDuration, formatCurrency, formatSeconds, formatFileSize)
- **Hooks** → `src/hooks/` (use-download, use-event-source, use-delete-batch)

## API Calls

- All API calls use **Orval-generated hooks** from `@packages/api-client`. Never hardcode URLs.
- Axios instance in `packages/api-client/src/custom-instance.ts` — has 30s timeout, 401 interceptor (redirects to `/login` unless already there).

## Code Splitting

- Heavy dialog components (`CreateBatchDialog`, `CreateVideoDialog`) are lazy-loaded:
  ```tsx
  const CreateBatchDialog = lazy(() =>
    import("@/components/dashboard/create-batch-dialog").then(m => ({ default: m.CreateBatchDialog }))
  );
  // Wrap usage in <Suspense>
  ```

## SSE / Real-time

- `useEventSource(url, enabled, queryKeys)` — subscribes to SSE, invalidates React Query keys on events.
- `queryKeys` uses `useRef` to avoid re-creating the EventSource on every render.

## Page Transitions

- `AnimatedOutlet` uses framer-motion `AnimatePresence` with `mode="popLayout"` — old page removed instantly, new page fades in (300ms). No exit animation to avoid content flash.

## Styling

- UI mimics Claude.ai: dark sage sidebar + warm cream content area. No generic blue/gray.
- Never use custom SVGs — always use lucide-react icons and recharts.
- Accessibility: drop zones have `role="button"`, `tabIndex`, `onKeyDown`. Stage dots have `aria-label`.
