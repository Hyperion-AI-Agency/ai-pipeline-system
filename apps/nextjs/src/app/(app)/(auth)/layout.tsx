import { ReactNode } from "react";
import { headers } from "next/headers";
import { redirect } from "next/navigation";
import { auth } from "@/server/auth/auth";
import { getTranslations } from "next-intl/server";

import { AuthSidePanel } from "@/components/auth/auth-side-panel";
import { BackButton } from "@/components/navbar/back-button";
import LocaleSwitcher from "@/components/navbar/locale-switcher";

type Props = {
  children: ReactNode;
  params: Promise<{ locale: string }>;
};

export default async function AuthLayout({ children, params }: Props) {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "auth.signIn" });

  // Redirect authenticated users to dashboard
  const session = await auth.api.getSession({
    headers: await headers(),
  });

  if (session?.user?.id) {
    redirect("/new");
  }

  return (
    <div className="bg-background relative flex min-h-screen">
      {/* Side Panel - Desktop only */}
      <AuthSidePanel title={t("sidePanelTitle")} description={t("sidePanelDescription")} />

      {/* Main Content */}
      <div className="flex flex-1 flex-col">
        {/* Header */}
        <div className="flex items-center justify-between p-6">
          <BackButton />
          <LocaleSwitcher />
        </div>

        {/* Content */}
        <div className="flex flex-1 flex-col items-center justify-center px-6 py-12">
          {children}
        </div>
      </div>
    </div>
  );
}
