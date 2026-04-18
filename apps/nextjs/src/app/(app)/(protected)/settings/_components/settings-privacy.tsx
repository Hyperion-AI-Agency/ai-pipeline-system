"use client";

import { useEffect, useState } from "react";
import { ShieldCheck } from "lucide-react";
import { useTranslations } from "next-intl";
import { useAnalytics } from "@packages/analytics/client";

import { Switch } from "@/components/ui/switch";

export function SettingsPrivacy() {
  const t = useTranslations("dashboard.settings.privacy");
  const posthog = useAnalytics();
  const [helpImprove, setHelpImprove] = useState(true);

  useEffect(() => {
    if (posthog) {
      setHelpImprove(!posthog.has_opted_out_capturing());
    }
  }, [posthog]);

  const handleHelpImproveChange = (checked: boolean) => {
    setHelpImprove(checked);
    if (posthog) {
      if (checked) {
        posthog.opt_in_capturing();
      } else {
        posthog.opt_out_capturing();
      }
    }
  };

  return (
    <div className="max-w-2xl">
      {/* Header */}
      <div className="mb-6 flex items-start gap-4">
        <div className="bg-muted flex h-12 w-12 shrink-0 items-center justify-center rounded-lg border">
          <ShieldCheck className="text-muted-foreground h-6 w-6" />
        </div>
        <div>
          <h2 className="text-xl font-semibold">{t("title")}</h2>
          <p className="text-muted-foreground mt-0.5 text-sm">{t("subtitle")}</p>
        </div>
      </div>

      <p className="text-muted-foreground mb-6 text-sm">{t("description")}</p>

      {/* Help improve toggle — wired to PostHog opt-out */}
      <div className="divide-y">
        <div className="flex items-start justify-between gap-6 py-4">
          <div className="space-y-1">
            <p className="text-sm font-medium">{t("helpImproveTitle")}</p>
            <p className="text-muted-foreground text-sm">{t("helpImproveDescription")}</p>
          </div>
          <Switch
            checked={helpImprove}
            onCheckedChange={handleHelpImproveChange}
            className="mt-0.5 shrink-0"
          />
        </div>
      </div>
    </div>
  );
}
