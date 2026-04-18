"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { env } from "@/env";
import { authClient } from "@/server/auth/auth-client";
import { useForm } from "@tanstack/react-form";
import { Eye, EyeOff } from "lucide-react";
import { useTranslations } from "next-intl";
import { toast } from "sonner";
import { z } from "zod";

import { useTrackEvent } from "@/hooks/use-track-event";
import { Button } from "@/components/ui/button";
import { Field, FieldError, FieldGroup, FieldLabel } from "@/components/ui/field";
import { Input } from "@/components/ui/input";
import { LocaleLink } from "@/components/locale-link";

import { AuthDivider } from "./auth-divider";
import { AuthFormFooter } from "./auth-form-footer";
import { AuthFormHeader } from "./auth-form-header";
import { AuthLoadingState } from "./auth-loading-state";
import { AuthSocialButton } from "./auth-social-button";
import { SignUpDisabled } from "./sign-up-disabled";

export function SignUpForm() {
  const [loading, setLoading] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const router = useRouter();
  const t = useTranslations("auth.signUp");
  const { trackEvent, POSTHOG_EVENTS } = useTrackEvent();

  const signUpSchema = z.object({
    email: z.string().min(1, t("emailRequired")).email(t("emailInvalid")),
    password: z.string().min(8, t("passwordRequired")),
  });

  const form = useForm({
    defaultValues: {
      email: "",
      password: "",
    },
    validators: {
      onChange: signUpSchema,
    },
    onSubmit: async ({ value }) => {
      // Extract name from email (part before @) as Better Auth requires name
      const nameFromEmail = value.email.split("@")[0] || value.email;

      setLoading(true);

      authClient.signUp
        .email({
          email: value.email,
          password: value.password,
          name: nameFromEmail,
          callbackURL: "/sign-in",
        })
        .then(result => {
          if (result?.error) {
            setLoading(false);
            toast.error(result.error.message || t("failedToSignUp"), {
              duration: 5000,
            });
            return;
          }

          trackEvent(POSTHOG_EVENTS.USER_SIGNED_UP, { method: "email" });

          if (env.NEXT_PUBLIC_REQUIRE_EMAIL_VERIFICATION && !result?.data?.user?.emailVerified) {
            router.push(`/verify-email?email=${encodeURIComponent(value.email)}`);
            return;
          }
        })
        .catch((error: any) => {
          console.error("Authentication error:", error);
          toast.error(error?.message || t("failedToSignUp"), {
            duration: 5000,
          });
          setLoading(false);
        });
    },
  });

  if (!env.NEXT_PUBLIC_SIGNUP_ENABLED) {
    return <SignUpDisabled />;
  }

  if (loading) {
    return <AuthLoadingState message={t("signingUp")} />;
  }

  return (
    <form
      className="w-full max-w-md"
      onSubmit={e => {
        e.preventDefault();
        e.stopPropagation();
        form.handleSubmit();
      }}
    >
      <AuthFormHeader title={t("title")} subtitle={t("subtitle")} />

      {/* OAuth Provider Buttons */}
      <div className="mb-6 flex flex-wrap gap-3">
        <AuthSocialButton
          provider="google"
          label={t("google")}
          disabled={loading}
          onLoadingChange={setLoading}
          onError={error => toast.error(error || t("failedToSignUp"))}
        />
      </div>

      <AuthDivider text={t("divider")} />

      {/* Email/Password Form */}
      <FieldGroup>
        <form.Field name="email">
          {field => {
            const isInvalid = field.state.meta.isTouched && !field.state.meta.isValid;
            return (
              <Field data-invalid={isInvalid}>
                <FieldLabel htmlFor={field.name}>{t("email")}</FieldLabel>
                <Input
                  id={field.name}
                  name={field.name}
                  type="email"
                  placeholder={t("emailPlaceholder")}
                  value={field.state.value}
                  onChange={e => field.handleChange(e.target.value)}
                  onBlur={field.handleBlur}
                  disabled={loading}
                  autoComplete="email"
                  aria-invalid={isInvalid}
                />
                {isInvalid && <FieldError errors={field.state.meta.errors} />}
              </Field>
            );
          }}
        </form.Field>

        <form.Field name="password">
          {field => {
            const isInvalid = field.state.meta.isTouched && !field.state.meta.isValid;
            return (
              <Field data-invalid={isInvalid}>
                <FieldLabel htmlFor={field.name}>{t("password")}</FieldLabel>
                <div className="relative">
                  <Input
                    id={field.name}
                    name={field.name}
                    type={showPassword ? "text" : "password"}
                    placeholder={t("passwordPlaceholder")}
                    value={field.state.value}
                    onChange={e => field.handleChange(e.target.value)}
                    onBlur={field.handleBlur}
                    disabled={loading}
                    autoComplete="new-password"
                    className="pr-10"
                    aria-invalid={isInvalid}
                  />
                  <button
                    type="button"
                    onClick={() => setShowPassword(!showPassword)}
                    className="text-muted-foreground hover:text-foreground absolute top-1/2 right-3 -translate-y-1/2"
                  >
                    {showPassword ? <EyeOff className="h-4 w-4" /> : <Eye className="h-4 w-4" />}
                  </button>
                </div>
                {isInvalid && <FieldError errors={field.state.meta.errors} />}
              </Field>
            );
          }}
        </form.Field>

        <Field orientation="horizontal">
          <Button
            type="submit"
            variant="default"
            size="lg"
            className="w-full"
            disabled={loading || !form.state.isValid}
          >
            {loading ? t("creatingAccount") : t("continue")}
          </Button>
        </Field>

        {/* Terms */}
        <div className="text-muted-foreground text-xs leading-relaxed">
          {t("termsPrefix")}{" "}
          <LocaleLink
            href="/terms-of-service"
            className="hover:text-foreground underline"
            target="_blank"
            rel="noreferrer"
          >
            {t("termsOfService")}
          </LocaleLink>{" "}
          {t("termsAnd")}{" "}
          <LocaleLink
            href="/privacy-policy"
            className="hover:text-foreground underline"
            target="_blank"
            rel="noreferrer"
          >
            {t("privacyPolicy")}
          </LocaleLink>
          . {t("termsSuffix")}
        </div>
      </FieldGroup>

      <AuthFormFooter text={t("alreadyHaveAccount")} linkText={t("logIn")} linkHref="/sign-in" />
    </form>
  );
}
