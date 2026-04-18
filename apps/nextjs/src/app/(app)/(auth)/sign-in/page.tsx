import type { Metadata } from "next";
import { getLocale, getTranslations } from "next-intl/server";

import { pageMetadata } from "@/lib/seo/metadata";
import { SignInForm } from "@/components/auth/sign-in-form";

export async function generateMetadata(): Promise<Metadata> {
  const locale = await getLocale();
  const t = await getTranslations({ locale, namespace: "metadata" });

  return pageMetadata({
    locale,
    title: t("signInTitle"),
    description: t("signInDescription"),
    internalPath: "/sign-in",
  });
}

export default function SignInPage() {
  return <SignInForm />;
}
