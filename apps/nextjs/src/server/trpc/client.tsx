"use client";

import { useState } from "react";
import { env } from "@/env";
import { type AppRouter } from "@/server/api/root";
import { QueryClientProvider, type QueryClient } from "@tanstack/react-query";
import { createTRPCClient, httpBatchStreamLink, loggerLink } from "@trpc/client";
import superjson from "superjson";

import { createQueryClient } from "./query-client";
import { TRPCProvider } from "./trpc";

let browserQueryClient: QueryClient | undefined = undefined;

function getBrowserQueryClient(): QueryClient {
  if (typeof window === "undefined") {
    return createQueryClient();
  }
  if (!browserQueryClient) {
    browserQueryClient = createQueryClient();
  }
  return browserQueryClient;
}

interface TRPCReactProviderProps {
  children: React.ReactNode;
}

export function TRPCReactProvider({ children }: TRPCReactProviderProps) {
  const client = getBrowserQueryClient();
  const [trpcClient] = useState(() =>
    createTRPCClient<AppRouter>({
      links: [
        loggerLink({
          enabled: op =>
            process.env.NODE_ENV === "development" ||
            (op.direction === "down" && op.result instanceof Error),
        }),
        httpBatchStreamLink({
          transformer: superjson,
          url: env.NEXT_PUBLIC_APP_URL + "/api/trpc",
          headers: () => {
            const headers = new Headers();
            headers.set("x-trpc-source", "nextjs-react");
            return headers;
          },
        }),
      ],
    })
  );

  return (
    <QueryClientProvider client={client}>
      <TRPCProvider trpcClient={trpcClient} queryClient={client}>
        {children}
      </TRPCProvider>
    </QueryClientProvider>
  );
}
