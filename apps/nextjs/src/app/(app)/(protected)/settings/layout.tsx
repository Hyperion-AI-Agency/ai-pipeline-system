import { ReactNode } from "react";
import { getLocale, getTranslations } from "next-intl/server";

import { SettingsNav } from "./_components/settings-nav";

type Props = {
  children: ReactNode;
};

export default async function SettingsLayout({ children }: Props) {
  const locale = await getLocale();
  const t = await getTranslations({ locale, namespace: "dashboard.settings" });

  return (
    <div className="flex flex-1 overflow-auto px-8 py-8">
      <div className="flex w-52 shrink-0 flex-col">
        <h1 className="mb-5 px-4 text-2xl font-semibold tracking-tight">{t("title")}</h1>
        <SettingsNav />
      </div>
      <div className="ml-28 min-w-0 flex-1">{children}</div>
    </div>
  );
}
