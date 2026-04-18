"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { ArrowLeft } from "lucide-react";
import { useTranslations } from "next-intl";

export default function NotFound() {
  const t = useTranslations("common");
  const pathname = usePathname();
  const locale = pathname?.split("/")[1] || "lt";

  return (
    <div className="fixed inset-0 flex flex-col items-center justify-center overflow-hidden bg-white px-4 text-center">
      <p className="text-foreground text-[8rem] leading-none font-black sm:text-[12rem]">404</p>
      <h1 className="text-foreground mt-2 text-2xl font-semibold sm:text-3xl">
        {t("pageNotFound")}
      </h1>
      <p className="text-muted-foreground mt-3 max-w-md">{t("pageNotFoundDescription")}</p>
      <Link
        href={`/${locale}`}
        className="bg-primary text-primary-foreground hover:bg-primary/90 mt-8 inline-flex items-center gap-2 rounded-lg px-6 py-3 text-sm font-medium transition-colors"
      >
        <ArrowLeft className="h-4 w-4" />
        {t("goHome")}
      </Link>
    </div>
  );
}
