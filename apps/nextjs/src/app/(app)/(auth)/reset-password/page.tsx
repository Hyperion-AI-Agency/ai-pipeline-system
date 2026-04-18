import type { Metadata } from "next";
import { redirect } from "next/navigation";
import { getLocale, getTranslations } from "next-intl/server";

import { pageMetadata } from "@/lib/seo/metadata";
import { RequestPasswordResetForm } from "@/components/auth/request-password-reset-form";
import { ResetPasswordForm } from "@/components/auth/reset-password-form";

export async function generateMetadata(): Promise<Metadata> {
  const locale = await getLocale();
  const t = await getTranslations({ locale, namespace: "metadata" });

  return pageMetadata({
    locale,
    title: t("resetPasswordTitle"),
    description: t("resetPasswordDescription"),
    internalPath: "/reset-password",
  });
}

interface ResetPasswordPageProps {
  searchParams: Promise<{ token?: string; error?: string }>;
}

export default async function ResetPasswordPage({ searchParams }: ResetPasswordPageProps) {
  const params = await searchParams;
  const token = params.token || null;
  const error = params.error;

  if (error === "INVALID_TOKEN") {
    redirect("/reset-password");
  }

  if (!token) {
    return <RequestPasswordResetForm />;
  }

  return <ResetPasswordForm token={token} />;
}
