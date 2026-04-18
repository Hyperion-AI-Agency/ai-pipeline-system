import { headers } from "next/headers";
import { auth } from "@/server/auth/auth";
import { getLocale, getTranslations } from "next-intl/server";

import { SettingsProfileForm } from "../_components/settings-profile-form";
import { SettingsThemeSelector } from "../_components/settings-theme-selector";

export default async function SettingsGeneralPage() {
  const headersList = await headers();
  const locale = await getLocale();
  const t = await getTranslations({ locale, namespace: "dashboard.settings.general" });

  const session = await auth.api.getSession({
    headers: headersList,
  });

  const user = {
    id: session?.user?.id || "",
    name: session?.user?.name || "",
    email: session?.user?.email || "",
    image: session?.user?.image || null,
  };

  return (
    <div className="flex flex-col">
      <section className="pb-10">
        <h2 className="mb-6 text-xl font-semibold">{t("profile")}</h2>
        <SettingsProfileForm user={user} />
      </section>
      <section className="pb-10">
        <SettingsThemeSelector />
      </section>
    </div>
  );
}
