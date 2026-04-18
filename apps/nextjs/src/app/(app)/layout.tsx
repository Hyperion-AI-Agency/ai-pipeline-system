import type { Metadata } from "next";
import { TRPCReactProvider } from "@/server/trpc/client";

import { Toaster } from "@/components/ui/sonner";
import { AnalyticsProvider } from "@/components/providers/posthog-provider";
import { ThemeProvider } from "@/components/providers/provider";

import "@/styles/globals.css";

export const dynamic = "force-dynamic";

export const metadata: Metadata = {
  title: "MatchedPro Steam Signals",
  description: "Betting signals dashboard",
};

type Props = {
  children: React.ReactNode;
};

export default function AppLayout({ children }: Readonly<Props>) {
  return (
    <html lang="en">
      <body>
        <ThemeProvider attribute="class" forcedTheme="light" disableTransitionOnChange>
          <AnalyticsProvider>
            <TRPCReactProvider>{children}</TRPCReactProvider>
          </AnalyticsProvider>
          <Toaster />
        </ThemeProvider>
      </body>
    </html>
  );
}
