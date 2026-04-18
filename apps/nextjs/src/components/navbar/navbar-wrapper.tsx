import { getLocale, getTranslations } from "next-intl/server";

import { CTA_LINK } from "@/lib/constants";

import { Navbar } from "./navbar";

type NavLinkItem = {
  id: string;
  label: string;
  url: string;
  openInNewTab?: boolean;
  children?: NavLinkItem[];
};

interface NavbarWrapperProps {
  forceBlackText?: boolean;
  ctaComponent?: React.ReactNode;
  links?: {
    label?: string | null;
    url?: string | null;
    openInNewTab?: boolean | null;
    id?: string | null;
  }[];
  ctaLabel?: string | null;
  ctaUrl?: string | null;
}

export async function NavbarWrapper({
  forceBlackText,
  ctaComponent,
  links,
  ctaLabel,
  ctaUrl,
}: NavbarWrapperProps) {
  const locale = await getLocale();
  const t = await getTranslations({ locale, namespace: "common" });

  const navItems: NavLinkItem[] =
    Array.isArray(links) && links.length > 0
      ? links.map((link, i) => ({
          id: link.id ?? `nav-${i}`,
          label: link.label ?? "",
          url: link.url ?? "",
          openInNewTab: link.openInNewTab ?? false,
        }))
      : [
          { id: "nav-0", label: t("howItWorks"), url: "/#mechanism" },
          { id: "nav-1", label: t("plans"), url: "/#pricing" },
          { id: "nav-2", label: t("blog"), url: "/blog" },
        ];

  const ctaButton = {
    enabled: true,
    url: ctaUrl ?? CTA_LINK,
    label: ctaLabel ?? t("getStarted"),
    variant: "outline" as const,
  };

  return (
    <Navbar
      navItems={navItems}
      ctaButton={ctaButton}
      forceBlackText={forceBlackText}
      ctaComponent={ctaComponent}
      appName="App"
      dashboardText={t("dashboard")}
      dashboardLink="/new"
    />
  );
}
