import type { Metadata } from "next";
import { headers } from "next/headers";
import { redirect } from "next/navigation";
import { env } from "@/env";
import { auth } from "@/server/auth/auth";
import { getLocale, getTranslations } from "next-intl/server";
import z from "zod";

import { pageMetadata } from "@/lib/seo/metadata";
import { AskForEmailVerificationForm } from "@/components/auth/ask-for-verify-email-form";

export async function generateMetadata(): Promise<Metadata> {
  const locale = await getLocale();
  const t = await getTranslations({ locale, namespace: "metadata" });

  return pageMetadata({
    locale,
    title: t("verifyEmailTitle"),
    description: t("verifyEmailDescription"),
    internalPath: "/verify-email",
  });
}

interface VerifyEmailPageProps {
  searchParams: Promise<{ email?: string; locale?: string; [key: string]: string | undefined }>;
}

export default async function VerifyEmailPage({ searchParams }: VerifyEmailPageProps) {
  const params = await searchParams;
  const locale = params.locale ?? "en";

  if (!env.REQUIRE_EMAIL_VERIFICATION) {
    redirect("/new");
  }

  const session = await auth.api.getSession({ headers: await headers() });
  if (session?.user?.emailVerified) {
    redirect("/new");
  }

  if (!params.email || !z.string().email().safeParse(params.email).success) {
    redirect("/sign-in");
  }

  return <AskForEmailVerificationForm email={decodeURIComponent(params.email!)} />;
}
