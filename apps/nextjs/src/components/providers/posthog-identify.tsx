"use client";

import { useEffect } from "react";
import { authClient } from "@/server/auth/auth-client";
import { useAnalytics } from "@packages/analytics/client";

export function PostHogIdentify() {
  const { data: session } = authClient.useSession();
  const posthog = useAnalytics();

  useEffect(() => {
    if (!posthog) return;

    if (session?.user?.id) {
      posthog.identify(session.user.id);
    }
  }, [posthog, session?.user?.id]);

  return null;
}
