"use client";

import { Suspense } from "react";
import { PostHogProvider } from "@packages/analytics/client";

import { PostHogIdentify } from "./posthog-identify";
import { PostHogPageview } from "./posthog-pageview";

export function AnalyticsProvider({ children }: { children: React.ReactNode }) {
  return (
    <PostHogProvider>
      <Suspense fallback={null}>
        <PostHogPageview />
      </Suspense>
      <PostHogIdentify />
      {children}
    </PostHogProvider>
  );
}
