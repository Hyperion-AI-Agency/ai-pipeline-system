# Next.js Code Patterns

> Source: [Next.js 16 Docs](https://nextjs.org/docs) — App Router

## Project Structure

```
apps/nextjs/src/
├── app/                    # App Router
│   └── (app)/
│       ├── layout.tsx      # Root layout (html, body, providers)
│       ├── (auth)/         # Auth pages (sign-in, sign-up)
│       ├── (protected)/    # Authenticated pages (dashboard)
│       ├── (public)/       # Public pages (landing)
│       └── api/            # API routes
│           ├── auth/       # Auth endpoints
│           ├── health/     # Health check
│           └── trpc/       # tRPC handler
├── components/
│   ├── ui/                 # shadcn/ui primitives
│   ├── auth/               # Auth forms
│   ├── dashboard/          # Dashboard layout
│   └── providers/          # Context providers
├── server/
│   ├── auth/               # Better Auth config
│   ├── db/                 # Drizzle ORM
│   └── trpc/               # tRPC client + routers
├── actions/                # Server actions
├── hooks/                  # Custom hooks
└── lib/                    # Utilities, constants
```

## Routing Conventions

| File | Purpose |
|------|---------|
| `layout.tsx` | Shared UI wrapper (persists across navigations) |
| `page.tsx` | Unique page content (makes route publicly accessible) |
| `loading.tsx` | Loading skeleton (auto-wrapped in Suspense) |
| `error.tsx` | Error boundary |
| `not-found.tsx` | 404 UI |
| `route.ts` | API endpoint (GET, POST, etc.) |

### Route Groups

Parenthesized folders `(group)` organize code without affecting URLs:

```
app/(app)/(protected)/dashboard/page.tsx  → /dashboard
app/(app)/(auth)/sign-in/page.tsx         → /sign-in
app/(app)/(public)/page.tsx               → /
```

### Private Folders

Prefix with `_` to exclude from routing: `_components/`, `_lib/`

## Data Fetching

### Server Components (default)

Fetch directly — no hooks, no loading states needed at component level:

```tsx
// app/(app)/(protected)/signals/page.tsx
export default async function SignalsPage() {
  const signals = await db.select().from(signalsTable)
  return <SignalsList signals={signals} />
}
```

### Streaming with Suspense

Wrap slow data in Suspense to show the page immediately:

```tsx
import { Suspense } from "react"

export default function DashboardPage() {
  return (
    <div>
      <h1>Dashboard</h1>
      <Suspense fallback={<SignalsSkeleton />}>
        <ActiveSignals />
      </Suspense>
    </div>
  )
}
```

### Client Components

Use `"use client"` only when you need interactivity (event handlers, state, effects):

```tsx
"use client"
import useSWR from "swr"

export function LiveOdds({ eventId }: { eventId: string }) {
  const { data } = useSWR(`/api/odds/${eventId}`, fetcher)
  return <span>{data?.odds}</span>
}
```

### Parallel Data Fetching

Start all requests simultaneously, await together:

```tsx
export default async function Page() {
  const signalsData = getActiveSignals()
  const statsData = getDailyStats()
  const [signals, stats] = await Promise.all([signalsData, statsData])
  return <Dashboard signals={signals} stats={stats} />
}
```

## Server Actions

Use `"use server"` for mutations from client components:

```tsx
// actions/update-signal.ts
"use server"
export async function updateSignal(id: string, status: string) {
  await db.update(signals).set({ status }).where(eq(signals.id, id))
  revalidatePath("/dashboard")
}
```

## Environment Variables

- Use `.env` (not `.env.local`)
- Validated at build time via `@t3-oss/env-nextjs` in `src/env.ts`
- `NEXT_PUBLIC_` prefix for client-side vars
- Server-only vars are never exposed to the browser

## Component Rules

- **Server Components by default** — only add `"use client"` when needed
- **No `useEffect` for data fetching** — fetch in server components or use SWR/React Query in client
- **Suspense for loading states** — not manual `isLoading` flags
- **Icons from `lucide-react`** — no inline SVGs
