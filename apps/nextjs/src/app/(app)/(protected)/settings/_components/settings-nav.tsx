"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { useTranslations } from "next-intl";

const items = [
  { href: "/settings/general", key: "general" },
  { href: "/settings/account", key: "account" },
  { href: "/settings/privacy", key: "privacy" },
  { href: "/settings/billing", key: "billing" },
] as const;

export function SettingsNav() {
  const pathname = usePathname();
  const t = useTranslations("dashboard.settings.nav");

  return (
    <nav className="flex flex-col gap-0.5">
      {items.map(({ href, key }) => {
        const isActive = pathname === href || pathname?.startsWith(`${href}/`);
        return (
          <Link
            key={key}
            href={href}
            className={`w-full rounded-lg px-4 py-2.5 text-base transition-colors ${
              isActive
                ? "bg-muted text-foreground font-semibold"
                : "text-foreground/60 hover:bg-muted/70 hover:text-foreground"
            }`}
          >
            {t(key)}
          </Link>
        );
      })}
    </nav>
  );
}
