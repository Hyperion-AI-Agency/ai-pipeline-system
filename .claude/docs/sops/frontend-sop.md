# Frontend SOP — React + TanStack Router + shadcn/ui

> Production-grade patterns for React SPAs. Copy-paste ready.

---

## 1. Project Structure

```
apps/react/
├── src/
│   ├── main.tsx                    # App entrypoint (QueryClient + Router)
│   ├── routeTree.gen.ts            # Auto-generated route tree
│   ├── routes/
│   │   ├── __root.tsx              # Root layout (Toaster, devtools)
│   │   ├── login.tsx               # Public route
│   │   ├── app.tsx                 # Auth layout (beforeLoad guard)
│   │   └── app/
│   │       ├── index.tsx           # Dashboard page
│   │       ├── videos/
│   │       │   ├── index.tsx       # Video list page
│   │       │   ├── $videoId.tsx    # Video detail page
│   │       │   └── _components/   # Route-specific components
│   │       │       ├── video-header.tsx
│   │       │       └── shots-table.tsx
│   │       └── settings.tsx
│   ├── components/
│   │   ├── ui/                     # shadcn/ui primitives
│   │   ├── layout/                 # Sidebar, PageHeader
│   │   └── dashboard/             # Shared feature components
│   ├── hooks/                      # Custom hooks
│   ├── lib/                        # Utilities, formatters
│   └── styles/
│       └── global.css              # Tailwind + @theme tokens + CSS variables
├── e2e/                            # Playwright tests
└── vite.config.ts
```

**File placement rules:**
- Route-specific components → `routes/{route}/_components/`
- Shared across routes → `src/components/{feature}/`
- Reusable UI primitives → `src/components/ui/`
- Custom hooks → `src/hooks/`
- Pure functions → `src/lib/`

---

## 2. App Entrypoint

```typescript
// main.tsx
import { QueryClientProvider } from "@tanstack/react-query";
import { RouterProvider, createRouter } from "@tanstack/react-router";
import { queryClient } from "@/lib/query-client";
import { routeTree } from "./routeTree.gen";

const router = createRouter({ routeTree });

declare module "@tanstack/react-router" {
  interface Register {
    router: typeof router;
  }
}

createRoot(document.getElementById("root")!).render(
  <StrictMode>
    <QueryClientProvider client={queryClient}>
      <RouterProvider router={router} />
    </QueryClientProvider>
  </StrictMode>,
);
```

### QueryClient

```typescript
// lib/query-client.ts
import { QueryClient } from "@tanstack/react-query";

export const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      retry: 3,
      staleTime: 30_000,
    },
  },
});
```

**Rule:** No auth logic in QueryClient. Auth handled by route `beforeLoad` guards only.

---

## 3. Root Layout

```typescript
// routes/__root.tsx
import { Outlet, createRootRoute } from "@tanstack/react-router";
import { Toaster } from "sonner";

export const Route = createRootRoute({
  component: RootLayout,
});

function RootLayout() {
  return (
    <>
      <Outlet />
      <Toaster position="bottom-right" richColors />
    </>
  );
}
```

**Rule:** Use `sonner` directly, not shadcn's toast wrapper (it imports `next-themes` which is unavailable in Vite).

---

## 4. Auth Guard Pattern

### Protected Layout (beforeLoad)

```typescript
// routes/app.tsx
import { Outlet, createFileRoute, redirect } from "@tanstack/react-router";
import { meApiV1AuthMeGet } from "@packages/api-client";

export const Route = createFileRoute("/app")({
  beforeLoad: async () => {
    try {
      await meApiV1AuthMeGet();
    } catch {
      throw redirect({ to: "/login" });
    }
  },
  component: AuthenticatedLayout,
});

function AuthenticatedLayout() {
  return (
    <SidebarProvider defaultOpen={useMediaQuery("(min-width: 768px)")}>
      <AppSidebar />
      <SidebarInset className="bg-content-bg">
        <div className="mx-auto w-full max-w-5xl px-8 py-8">
          <Outlet />
        </div>
      </SidebarInset>
    </SidebarProvider>
  );
}
```

### Login Page (redirect if already authed)

```typescript
// routes/login.tsx
export const Route = createFileRoute("/login")({
  beforeLoad: async () => {
    try {
      await meApiV1AuthMeGet();
      throw redirect({ to: "/app" });  // Already logged in
    } catch (e) {
      if (isRedirect(e)) throw e;      // Re-throw redirects
    }
  },
  component: LoginPage,
});
```

---

## 5. API Client — Orval Generated Hooks

### Orval Config

```javascript
// packages/api-client/orval.config.mjs
import { defineConfig } from "orval";

export default defineConfig({
  fastapi: {
    input: {
      target: `${process.env.APP_BACKEND_API_URL ?? "http://localhost:8000"}/openapi.json`,
    },
    output: {
      mode: "single",
      target: "src/generated.ts",
      schemas: "src/model",
      client: "react-query",
      httpClient: "axios",
      override: {
        mutator: {
          path: "src/custom-instance.ts",
          name: "customInstance",
        },
      },
    },
  },
});
```

### Custom Axios Instance

```typescript
// packages/api-client/src/custom-instance.ts
import Axios, { type AxiosError, type AxiosRequestConfig, type AxiosResponse } from "axios";

export const AXIOS_INSTANCE = Axios.create({
  baseURL: env.PUBLIC_API_URL,
  withCredentials: true,
  timeout: 30_000,
  paramsSerializer: {
    indexes: null,  // FastAPI expects ?id=a&id=b, not ?id[]=a&id[]=b
  },
});

// 401 interceptor — redirect to login
AXIOS_INSTANCE.interceptors.response.use(
  (response) => response,
  (error: AxiosError) => {
    if (error.response?.status === 401 && window.location.pathname !== "/login") {
      window.location.href = "/login";
      return new Promise(() => {});
    }
    return Promise.reject(error);
  },
);

export const customInstance = <T>(
  config: AxiosRequestConfig,
  options?: AxiosRequestConfig,
): Promise<T> => {
  return AXIOS_INSTANCE({ ...config, ...options }).then((res: AxiosResponse<T>) => res.data);
};

export type ErrorType<Error> = AxiosError<Error>;
export type BodyType<BodyData> = BodyData;
```

### Usage in Components

```typescript
// Queries — auto-generated hooks
const { data: videos, isLoading } = useListVideosApiV1VideosGet({ page_size: 50 });

// Mutations — with callbacks
const createBatch = useUploadBatchApiV1BatchesUploadPost({
  mutation: {
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: getListBatchesApiV1BatchesGetQueryKey() });
      toast.success("Batch created");
    },
    onError: () => toast.error("Failed to create batch"),
  },
});

// Polling for active items
const { data: video } = useGetVideoApiV1VideosVideoIdGet(videoId, {
  query: {
    refetchInterval: video?.status === "processing" ? 3000 : false,
  },
});
```

**Rule:** Never hardcode API URLs. Always use Orval-generated hooks. Regenerate with `pnpm run generate-api`.

---

## 6. SSE / Real-time Updates

```typescript
// hooks/use-event-source.ts
import { useEffect, useRef } from "react";
import { useQueryClient } from "@tanstack/react-query";

export function useEventSource(
  url: string,
  enabled: boolean,
  queryKeys: readonly (readonly unknown[])[],
) {
  const queryClient = useQueryClient();
  const stableKeys = useRef(queryKeys);
  stableKeys.current = queryKeys;

  useEffect(() => {
    if (!enabled) return;

    const es = new EventSource(url, { withCredentials: true });

    const invalidate = () => {
      for (const key of stableKeys.current) {
        queryClient.invalidateQueries({ queryKey: key });
      }
    };

    es.addEventListener("video_progress", invalidate);
    es.addEventListener("batch_progress", invalidate);
    es.onmessage = invalidate;

    return () => es.close();
  }, [url, enabled, queryClient]);
}
```

**Usage:**

```typescript
const videoQueryKey = getGetVideoApiV1VideosVideoIdGetQueryKey(videoId);
const isActive = video?.status === "processing";
useEventSource(videoEventsUrl(videoId), isActive, [videoQueryKey]);
```

**Rule:** Use polling (`refetchInterval: 3000`) for simple cases. SSE for real-time updates when the backend supports it. Never WebSockets for this use case — video gen takes minutes, 3s polling isn't wasteful.

---

## 7. Page Component Pattern

```typescript
// routes/app/index.tsx
export const Route = createFileRoute("/app/")({
  component: DashboardPage,
});

function DashboardPage() {
  const { data: dashboard, isLoading } = useGetDashboardStatsApiV1DashboardStatsGet();

  if (isLoading) {
    return (
      <div className="space-y-6">
        <PageHeader title="Dashboard" description="Overview" />
        <Skeleton className="h-[300px] w-full rounded-xl bg-border" />
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <PageHeader title="Dashboard" description="Overview" />
      {dashboard?.daily && <DailyChart data={dashboard.daily} />}
      {dashboard?.stats && <StatsCards stats={dashboard.stats} />}
    </div>
  );
}
```

### Page Header

```typescript
// components/layout/page-header.tsx
interface PageHeaderProps {
  title: string;
  description: string;
  actions?: React.ReactNode;
}

export function PageHeader({ title, description, actions }: PageHeaderProps) {
  return (
    <div className="mb-6 flex items-start justify-between gap-4">
      <div>
        <h1 className="text-2xl font-semibold tracking-tight text-text-primary">{title}</h1>
        <p className="mt-1 text-sm text-text-secondary">{description}</p>
      </div>
      {actions && <div className="flex items-center gap-2 pt-1">{actions}</div>}
    </div>
  );
}
```

---

## 8. Multi-step Dialog Pattern

```typescript
type Step = "upload" | "map" | "review";

const STEPS: { key: Step; label: string }[] = [
  { key: "upload", label: "Upload" },
  { key: "map", label: "Map Columns" },
  { key: "review", label: "Review" },
];

const STEP_DESCRIPTIONS: Record<Step, string> = {
  upload: "Upload an Excel or CSV file.",
  map: "Map your spreadsheet columns.",
  review: "Review before creating.",
};

export function CreateBatchDialog({ onCreated }: Props) {
  const [open, setOpen] = useState(false);
  const [step, setStep] = useState<Step>("upload");
  const [parsedFile, setParsedFile] = useState<ParsedFile | null>(null);
  const [mapping, setMapping] = useState<ColumnMapping | null>(null);

  const reset = () => {
    setStep("upload");
    setParsedFile(null);
    setMapping(null);
  };

  return (
    <Dialog open={open} onOpenChange={(v) => { setOpen(v); if (!v) reset(); }}>
      <DialogTrigger asChild>
        <Button className="bg-brand text-white">
          <Plus size={16} className="mr-0.5" /> Add New
        </Button>
      </DialogTrigger>
      <DialogContent className="bg-card-bg border-border sm:max-w-2xl">
        <DialogHeader>
          <DialogTitle className="text-text-primary">Create Batch</DialogTitle>
          <p className="text-sm text-text-muted">{STEP_DESCRIPTIONS[step]}</p>
          <Stepper steps={STEPS} current={step} />
        </DialogHeader>

        {step === "upload" && (
          <FileUpload onFileParsed={(data) => { setParsedFile(data); setStep("map"); }} />
        )}
        {step === "map" && parsedFile && (
          <ColumnMapper onMapped={(m) => { setMapping(m); setStep("review"); }} />
        )}
        {step === "review" && parsedFile && mapping && (
          <ReviewStep onConfirm={() => { /* submit */ setOpen(false); reset(); }} />
        )}
      </DialogContent>
    </Dialog>
  );
}
```

### Stepper Component

```typescript
interface StepperProps {
  steps: { key: string; label: string }[];
  current: string;
}

export function Stepper({ steps, current }: StepperProps) {
  const currentIdx = steps.findIndex((s) => s.key === current);

  return (
    <div className="flex w-full items-start">
      {steps.map((s, i) => {
        const isCompleted = i < currentIdx;
        const isCurrent = i === currentIdx;

        return (
          <div key={s.key} className="flex flex-1 flex-col items-center gap-1.5">
            <div className="flex w-full items-center">
              {i > 0 && (
                <div className={cn("h-px flex-1", i <= currentIdx ? "bg-brand" : "bg-border")} />
              )}
              <div className={cn(
                "flex h-7 w-7 shrink-0 items-center justify-center rounded-full text-xs font-medium",
                isCompleted && "bg-brand text-white",
                isCurrent && "border-[1.5px] border-brand bg-transparent text-brand",
                !isCompleted && !isCurrent && "border border-border text-text-muted",
              )}>
                {isCompleted ? <Check size={12} /> : i + 1}
              </div>
              {i < steps.length - 1 && (
                <div className={cn("h-px flex-1", i < currentIdx ? "bg-brand" : "bg-border")} />
              )}
            </div>
            <span className="text-xs font-medium">{s.label}</span>
          </div>
        );
      })}
    </div>
  );
}
```

---

## 9. Data Table Pattern (TanStack Table)

```typescript
import {
  useReactTable,
  getCoreRowModel,
  getSortedRowModel,
  getFilteredRowModel,
  flexRender,
  createColumnHelper,
  type SortingState,
  type RowSelectionState,
} from "@tanstack/react-table";

interface DataTableProps<T> {
  data: T[];
  columns: ColumnDef<T, unknown>[];
  searchPlaceholder?: string;
  toolbar?: React.ReactNode;
  pagination?: PaginationProps;
  onSelectionChange?: (selected: T[]) => void;
  onRowClick?: (row: T) => void;
}

export function DataTable<T>({ data, columns, onSelectionChange, onRowClick, ...props }: DataTableProps<T>) {
  const [sorting, setSorting] = useState<SortingState>([]);
  const [rowSelection, setRowSelection] = useState<RowSelectionState>({});
  const [globalFilter, setGlobalFilter] = useState("");

  const table = useReactTable({
    data,
    columns,
    state: { sorting, rowSelection, globalFilter },
    onSortingChange: setSorting,
    onGlobalFilterChange: setGlobalFilter,
    onRowSelectionChange: (updater) => {
      const next = typeof updater === "function" ? updater(rowSelection) : updater;
      setRowSelection(next);
      if (onSelectionChange) {
        const selected = Object.keys(next)
          .filter((k) => next[k])
          .map((k) => data[Number(k)])
          .filter((item): item is T => item !== undefined);
        onSelectionChange(selected);
      }
    },
    getCoreRowModel: getCoreRowModel(),
    getSortedRowModel: getSortedRowModel(),
    getFilteredRowModel: getFilteredRowModel(),
    enableRowSelection: !!onSelectionChange,
  });

  return (
    <div>
      {/* Search bar */}
      <div className="mb-3 flex items-center justify-between gap-3">
        <div className="relative">
          <Search size={15} className="absolute left-3 top-1/2 -translate-y-1/2 text-text-muted" />
          <input
            value={globalFilter}
            onChange={(e) => setGlobalFilter(e.target.value)}
            placeholder={props.searchPlaceholder ?? "Search..."}
            className="h-9 w-64 rounded-lg border pl-9 pr-3 text-sm outline-none border-border bg-card-bg text-text-primary"
          />
        </div>
        {props.toolbar}
      </div>

      {/* Table */}
      <div className="overflow-hidden rounded-xl border border-border bg-card-bg">
        <Table>
          <TableHeader>
            {table.getHeaderGroups().map((hg) => (
              <TableRow key={hg.id} className="border-border bg-content-bg">
                {hg.headers.map((h) => (
                  <TableHead key={h.id} onClick={h.column.getToggleSortingHandler()}>
                    {flexRender(h.column.columnDef.header, h.getContext())}
                  </TableHead>
                ))}
              </TableRow>
            ))}
          </TableHeader>
          <TableBody>
            {table.getRowModel().rows.map((row) => (
              <TableRow key={row.id} onClick={() => onRowClick?.(row.original)} className="cursor-pointer">
                {row.getVisibleCells().map((cell) => (
                  <TableCell key={cell.id}>
                    {flexRender(cell.column.columnDef.cell, cell.getContext())}
                  </TableCell>
                ))}
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </div>
    </div>
  );
}
```

### Column Definitions

```typescript
const col = createColumnHelper<BatchRead>();

const batchColumns = [
  col.accessor("name", {
    header: "Name",
    cell: ({ getValue }) => <span className="font-medium">{getValue()}</span>,
  }),
  col.display({
    id: "status",
    header: "Status",
    cell: ({ row }) => <StatusBadge status={row.original.status} />,
  }),
  col.display({
    id: "actions",
    header: "",
    cell: ({ row }) => (
      <div onClick={(e) => e.stopPropagation()}>
        <DropdownActions item={row.original} />
      </div>
    ),
  }),
];
```

---

## 10. Status Badge

```typescript
const STATUS_CONFIG: Record<string, { label: string; bg: string; text: string; dot: string }> = {
  queued:      { label: "Queued",      bg: "bg-status-info-light",    text: "text-status-info",    dot: "bg-status-info" },
  processing:  { label: "Processing",  bg: "bg-status-warning-light", text: "text-brand",          dot: "bg-brand" },
  finished:    { label: "Finished",    bg: "bg-status-success-light", text: "text-status-success", dot: "bg-status-success" },
  failed:      { label: "Failed",      bg: "bg-status-error-light",   text: "text-status-error",   dot: "bg-status-error" },
};

export function StatusBadge({ status }: { status: string }) {
  const config = STATUS_CONFIG[status] ?? STATUS_CONFIG.processing;
  return (
    <span className={cn("inline-flex items-center gap-1.5 rounded-full px-2.5 py-0.5 text-xs font-medium", config.bg, config.text)}>
      <span className={cn("h-1.5 w-1.5 rounded-full", config.dot, status === "processing" && "animate-pulse")} />
      {config.label}
    </span>
  );
}
```

---

## 11. Confirm Delete Dialog

```typescript
export function ConfirmDeleteDialog({
  title = "Delete?",
  description = "This action cannot be undone.",
  onConfirm,
  children,
}: {
  title?: string;
  description?: string;
  onConfirm: () => void;
  children: React.ReactNode;
}) {
  return (
    <AlertDialog>
      <AlertDialogTrigger asChild>{children}</AlertDialogTrigger>
      <AlertDialogContent>
        <AlertDialogHeader>
          <AlertDialogTitle>{title}</AlertDialogTitle>
          <AlertDialogDescription>{description}</AlertDialogDescription>
        </AlertDialogHeader>
        <AlertDialogFooter>
          <AlertDialogCancel>Cancel</AlertDialogCancel>
          <AlertDialogAction onClick={onConfirm} className="bg-status-error text-white">
            Delete
          </AlertDialogAction>
        </AlertDialogFooter>
      </AlertDialogContent>
    </AlertDialog>
  );
}
```

---

## 12. Async Button

```typescript
export function AsyncButton({
  onClick,
  icon,
  label,
  loadingLabel,
  disabled = false,
  className,
}: {
  onClick: () => Promise<void> | void;
  icon?: React.ReactNode;
  label: string;
  loadingLabel?: string;
  disabled?: boolean;
  className?: string;
}) {
  const [loading, setLoading] = useState(false);

  const handleClick = async () => {
    setLoading(true);
    try { await onClick(); } finally { setLoading(false); }
  };

  return (
    <button
      className={cn(
        "inline-flex h-9 items-center gap-2 rounded-lg border border-border bg-card-bg px-3 text-sm font-medium text-text-secondary transition-colors hover:bg-content-bg disabled:opacity-50",
        className,
      )}
      onClick={handleClick}
      disabled={disabled || loading}
    >
      {loading ? <Loader2 size={15} className="animate-spin" /> : icon}
      {loading ? (loadingLabel ?? label) : label}
    </button>
  );
}
```

---

## 13. Custom Hooks

### useMediaQuery

```typescript
export function useMediaQuery(query: string): boolean {
  const [matches, setMatches] = useState(() => window.matchMedia(query).matches);

  useEffect(() => {
    const mql = window.matchMedia(query);
    const handler = (e: MediaQueryListEvent) => setMatches(e.matches);
    mql.addEventListener("change", handler);
    return () => mql.removeEventListener("change", handler);
  }, [query]);

  return matches;
}
```

### Mutation Hook with Toast

```typescript
export function useDeleteBatch(options?: { onSuccess?: () => void }) {
  const queryClient = useQueryClient();
  return useDeleteBatchApiV1BatchesBatchIdDelete({
    mutation: {
      onSuccess: () => {
        queryClient.invalidateQueries({ queryKey: getListBatchesApiV1BatchesGetQueryKey() });
        toast.success("Batch deleted");
        options?.onSuccess?.();
      },
      onError: () => toast.error("Failed to delete batch"),
    },
  });
}
```

---

## 14. File Upload Component

```typescript
export function FileUpload({ onFileParsed }: { onFileParsed: (data: ParsedFile) => void }) {
  const [isDragging, setIsDragging] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const inputRef = useRef<HTMLInputElement>(null);

  const parseFile = useCallback((file: File) => {
    setError(null);
    const reader = new FileReader();
    reader.onload = (e) => {
      try {
        const data = new Uint8Array(e.target?.result as ArrayBuffer);
        const workbook = XLSX.read(data, { type: "array" });
        const sheet = workbook.Sheets[workbook.SheetNames[0]];
        const json: string[][] = XLSX.utils.sheet_to_json(sheet, { header: 1, defval: "" });
        onFileParsed({
          fileName: file.name,
          headers: json[0].map(String),
          rows: json.slice(1).filter((row) => row.some((cell) => cell !== "")),
          file,
        });
      } catch {
        setError("Failed to parse file");
      }
    };
    reader.readAsArrayBuffer(file);
  }, [onFileParsed]);

  return (
    <div className="space-y-3">
      <div
        role="button"
        className={cn(
          "flex cursor-pointer flex-col items-center justify-center rounded-xl border-2 border-dashed p-10 transition-colors",
          isDragging ? "border-brand bg-brand-muted" : "border-border bg-content-bg",
        )}
        onDragOver={(e) => { e.preventDefault(); setIsDragging(true); }}
        onDragLeave={() => setIsDragging(false)}
        onDrop={(e) => { e.preventDefault(); const f = e.dataTransfer.files[0]; if (f) parseFile(f); }}
        onClick={() => inputRef.current?.click()}
      >
        <Upload size={40} strokeWidth={1.5} className="text-text-muted" />
        <p className="text-sm font-medium text-text-primary">Drop your file here</p>
        <p className="text-xs text-text-muted">or click to browse</p>
        <input ref={inputRef} type="file" accept=".xlsx,.xls,.csv" hidden
          onChange={(e) => { const f = e.target.files?.[0]; if (f) parseFile(f); }}
        />
      </div>
      {error && <p className="text-sm text-status-error">{error}</p>}
    </div>
  );
}
```

---

## 15. Theme — CSS Variables + @theme Tokens

```css
/* styles/global.css */
@import "tailwindcss";

@theme {
  /* Sidebar + content areas */
  --color-sidebar-bg: var(--sidebar-bg);
  --color-content-bg: var(--content-bg);
  --color-card-bg: var(--card-bg);

  /* Text hierarchy */
  --color-text-primary: var(--text-primary);
  --color-text-secondary: var(--text-secondary);
  --color-text-muted: var(--text-muted);

  /* Brand accent */
  --color-brand: var(--brand);
  --color-brand-hover: var(--brand-hover);

  /* Status colors */
  --color-status-success: var(--color-success);
  --color-status-error: var(--color-error);
  --color-status-warning: var(--color-warning);
  --color-status-info: var(--color-info);

  /* Borders */
  --color-border: var(--border-color);
}

@layer base {
  :root {
    --sidebar-bg: #F5F1ED;
    --content-bg: #FAF8F5;
    --card-bg: #FFFDF9;
    --text-primary: #1A1612;
    --text-secondary: #6B5E52;
    --text-muted: #A89A8C;
    --brand: #A87B50;
    --brand-hover: #946A42;
    --border-color: #E8E2DA;
    --color-success: #22c55e;
    --color-error: #ef4444;
    --color-warning: #f59e0b;
    --color-info: #3b82f6;
  }
}
```

**Usage:** `className="bg-content-bg text-text-primary border-border"`

**Rules:**
- All styling via Tailwind utility classes — no inline `style={{}}`
- Theme tokens via `@theme` + CSS variables
- Icons: `lucide-react` only — never custom SVGs
- Charts: `recharts` only — never custom SVG charts

---

## 16. Sidebar Navigation

```typescript
export function AppSidebar() {
  const matchRoute = useMatchRoute();
  const isActive = (to: string, fuzzy = true) => !!matchRoute({ to, fuzzy });

  return (
    <Sidebar collapsible="icon" className="border-r-0">
      <SidebarHeader>{/* Logo */}</SidebarHeader>
      <SidebarContent>
        <SidebarGroup>
          <SidebarGroupLabel>Navigation</SidebarGroupLabel>
          <SidebarGroupContent>
            <SidebarMenu>
              <SidebarMenuItem>
                <SidebarMenuButton asChild isActive={isActive("/app", false)}>
                  <Link to="/app">
                    <LayoutDashboard size={16} />
                    <span>Dashboard</span>
                  </Link>
                </SidebarMenuButton>
              </SidebarMenuItem>
              {/* More items */}
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>
      </SidebarContent>
      <SidebarFooter>{/* Settings, logout */}</SidebarFooter>
    </Sidebar>
  );
}
```

---

## 17. Utility Functions

```typescript
// lib/format.ts
export function formatDuration(ms: number): string {
  const seconds = Math.floor(ms / 1000);
  if (seconds < 60) return `${seconds}s`;
  const minutes = Math.floor(seconds / 60);
  return `${minutes}m ${seconds % 60}s`;
}

export function formatDate(iso: string): string {
  return new Date(iso).toLocaleDateString("en-US", {
    month: "short", day: "numeric", hour: "2-digit", minute: "2-digit",
  });
}

export function formatCurrency(usd: number): string {
  return `$${usd.toFixed(2)}`;
}

export function formatFileSize(bytes: number): string {
  if (bytes === 0) return "\u2014";
  const mb = bytes / (1024 * 1024);
  return mb >= 1 ? `${mb.toFixed(1)} MB` : `${(bytes / 1024).toFixed(0)} KB`;
}
```

---

## 18. Vite Config

```typescript
import { resolve } from "node:path";
import { TanStackRouterVite } from "@tanstack/router-plugin/vite";
import react from "@vitejs/plugin-react-swc";
import tailwindcss from "@tailwindcss/vite";
import { defineConfig } from "vite";

export default defineConfig({
  envPrefix: ["VITE_", "PUBLIC_"],
  plugins: [TanStackRouterVite(), react(), tailwindcss()],
  resolve: {
    alias: { "@": resolve(__dirname, "./src") },
  },
  test: {
    globals: true,
    environment: "jsdom",
    setupFiles: ["./src/test/setup.ts"],
    include: ["src/**/*.test.{ts,tsx}"],
    css: false,
  },
});
```
