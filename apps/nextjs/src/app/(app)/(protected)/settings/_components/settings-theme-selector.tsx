"use client";

import { useEffect, useState } from "react";
import { Monitor, Moon, Sun } from "lucide-react";
import { useTranslations } from "next-intl";
import { useTheme } from "next-themes";

import { cn } from "@/lib/utils";

const themes = [
  { value: "light", icon: Sun },
  { value: "system", icon: Monitor },
  { value: "dark", icon: Moon },
] as const;

const labelKeys: Record<string, "light" | "auto" | "dark"> = {
  light: "light",
  system: "auto",
  dark: "dark",
};

export function SettingsThemeSelector() {
  const { theme, setTheme } = useTheme();
  const [mounted, setMounted] = useState(false);
  const t = useTranslations("dashboard.settings.general");

  useEffect(() => setMounted(true), []);

  if (!mounted) return null;

  return (
    <div>
      <h3 className="text-lg font-semibold">{t("appearance")}</h3>
      <p className="text-muted-foreground mb-4 text-sm">{t("colorMode")}</p>
      <div className="flex gap-3">
        {themes.map(({ value, icon: Icon }) => {
          const active = theme === value;
          return (
            <button
              key={value}
              type="button"
              onClick={() => setTheme(value)}
              className={cn(
                "flex w-28 flex-col items-center gap-2 rounded-lg border-2 p-3 transition-colors",
                active
                  ? "border-primary bg-primary/5"
                  : "border-border hover:border-muted-foreground/40"
              )}
            >
              <div
                className={cn(
                  "flex h-16 w-full items-center justify-center rounded-md",
                  value === "light" && "bg-[#f5f5f5]",
                  value === "system" && "bg-gradient-to-r from-[#f5f5f5] to-[#2a2a2a]",
                  value === "dark" && "bg-[#2a2a2a]"
                )}
              >
                <Icon
                  className={cn(
                    "h-6 w-6",
                    value === "light" && "text-[#4a4a4a]",
                    value === "system" && "text-[#888]",
                    value === "dark" && "text-[#ccc]"
                  )}
                />
              </div>
              <span className="text-sm font-medium">{t(labelKeys[value]!)}</span>
            </button>
          );
        })}
      </div>
    </div>
  );
}
