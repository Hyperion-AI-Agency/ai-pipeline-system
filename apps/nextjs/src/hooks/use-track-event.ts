"use client";

import { useCallback } from "react";
import { useAnalytics } from "@packages/analytics/client";
import { POSTHOG_EVENTS } from "@packages/analytics/constants";

type EventName = (typeof POSTHOG_EVENTS)[keyof typeof POSTHOG_EVENTS];

export function useTrackEvent() {
  const posthog = useAnalytics();

  const trackEvent = useCallback(
    (event: EventName, properties?: Record<string, unknown>) => {
      if (posthog) {
        posthog.capture(event, properties);
      }
    },
    [posthog]
  );

  return { trackEvent, POSTHOG_EVENTS };
}
