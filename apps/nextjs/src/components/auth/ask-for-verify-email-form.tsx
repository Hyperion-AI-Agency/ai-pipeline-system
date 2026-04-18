"use client";

import { useState } from "react";
import Link from "next/link";
import { authClient } from "@/server/auth/auth-client";
import { Loader2, Mail } from "lucide-react";
import { useTranslations } from "next-intl";
import { toast } from "sonner";

import { Button } from "@/components/ui/button";

import { AuthSuccessState } from "./auth-success-state";

export function AskForEmailVerificationForm({ email }: { email: string }) {
  const [loading, setLoading] = useState(false);
  const [emailSent, setEmailSent] = useState(false);
  const t = useTranslations("auth.emailVerification");
  const tAuth = useTranslations("auth");

  const handleResendEmail = async () => {
    try {
      setLoading(true);
      const result = await authClient.sendVerificationEmail({
        email: email,
        callbackURL: "/new",
      });

      if (result?.error) {
        toast.error(result?.error?.message || t("failedToSend"), {
          duration: 5000,
        });
        return;
      }

      setEmailSent(true);
      toast.success(t("emailSent"));
    } catch (error: any) {
      console.error("Verification email error:", error);
      toast.error(error?.message || t("failedToSend"), {
        duration: 5000,
      });
    } finally {
      setLoading(false);
    }
  };

  if (emailSent) {
    return (
      <AuthSuccessState
        icon="mail"
        title={t("title")}
        description={t("subtitle")}
        email={email}
        buttonText={tAuth("backToSignIn")}
        buttonHref="/sign-in"
      />
    );
  }

  return (
    <div className="w-full max-w-md">
      <div className="mb-8 text-center">
        <div className="bg-primary/10 mb-4 inline-flex h-16 w-16 items-center justify-center rounded-full">
          <Mail className="text-primary h-8 w-8" />
        </div>
        <h1 className="mb-2 text-2xl font-semibold">{t("title")}</h1>
        <p className="text-muted-foreground text-sm">{t("subtitle")}</p>
        {email && <p className="text-muted-foreground mt-2 text-sm font-medium">{email}</p>}
      </div>

      <div className="space-y-4">
        <Button
          type="button"
          variant="default"
          size="lg"
          className="w-full"
          onClick={handleResendEmail}
          disabled={loading}
        >
          {loading ? (
            <>
              <Loader2 className="mr-2 h-4 w-4 animate-spin" />
              {t("sending")}
            </>
          ) : (
            t("resendEmail")
          )}
        </Button>

        <div className="text-center">
          <Button variant="link" className="h-auto p-0" asChild>
            <Link href="/sign-in">{tAuth("backToSignIn")}</Link>
          </Button>
        </div>
      </div>
    </div>
  );
}
