import type { Metadata } from "next";
import { getLocale, getTranslations } from "next-intl/server";

import { pageMetadata } from "@/lib/seo/metadata";
import { SignUpForm } from "@/components/auth/sign-up-form";

export async function generateMetadata(): Promise<Metadata> {
  const locale = await getLocale();
  const t = await getTranslations({ locale, namespace: "metadata" });

  return pageMetadata({
    locale,
    title: t("signUpTitle"),
    description: t("signUpDescription"),
    internalPath: "/sign-up",
  });
}

export default function SignUpPage() {
  return <SignUpForm />;
}
