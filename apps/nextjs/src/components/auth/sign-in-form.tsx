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
import { Checkbox } from "@/components/ui/checkbox";
import { Field, FieldError, FieldGroup, FieldLabel } from "@/components/ui/field";
import { Input } from "@/components/ui/input";

import { AuthDivider } from "./auth-divider";
import { AuthFormFooter } from "./auth-form-footer";
import { AuthFormHeader } from "./auth-form-header";
import { AuthLoadingState } from "./auth-loading-state";
import { AuthSocialButton } from "./auth-social-button";

export function SignInForm({ callbackURL = "/new" }: { callbackURL?: string }) {
  const [loading, setLoading] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [rememberMe, setRememberMe] = useState(true);
  const router = useRouter();
  const t = useTranslations("auth.signIn");
  const { trackEvent, POSTHOG_EVENTS } = useTrackEvent();

  const signInSchema = z.object({
    email: z.string().min(1, t("emailRequired")).email(t("emailInvalid")),
    password: z.string().min(1, t("passwordRequired")),
  });

  const form = useForm({
    defaultValues: {
      email: "",
      password: "",
    },
    validators: {
      onChange: signInSchema,
    },
    onSubmit: async ({ value }) => {
      setLoading(true);

      authClient.signIn
        .email({
          email: value.email,
          password: value.password,
          rememberMe,
          callbackURL: callbackURL,
        })
        .then(result => {
          if (result?.error) {
            toast.error(result.error.message || t("failedToSignIn"), {
              duration: 5000,
            });

            if (
              env.NEXT_PUBLIC_REQUIRE_EMAIL_VERIFICATION &&
              result.error.code === "EMAIL_NOT_VERIFIED"
            ) {
              router.push(`/verify-email?email=${encodeURIComponent(value.email)}`);
              setLoading(false);
              return;
            }
            setLoading(false);
            return;
          }
          trackEvent(POSTHOG_EVENTS.USER_SIGNED_IN, { method: "email" });
        })
        .catch((error: any) => {
          console.error("Authentication error:", error);
          toast.error(error?.message || t("failedToSignIn"), {
            duration: 5000,
          });

          if (env.NEXT_PUBLIC_REQUIRE_EMAIL_VERIFICATION && error.code === "EMAIL_NOT_VERIFIED") {
            router.push(`/verify-email?email=${encodeURIComponent(value.email)}`);
            setLoading(false);
            return;
          }
          setLoading(false);
        });
    },
  });

  if (loading) {
    return <AuthLoadingState message={t("signingIn")} />;
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
      <div className="mb-6 grid gap-3">
        <AuthSocialButton
          provider="google"
          label={t("google")}
          disabled={loading}
          onLoadingChange={setLoading}
          onError={error => toast.error(error || t("failedToSignIn"))}
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
                <div className="flex w-full items-center justify-between">
                  <FieldLabel htmlFor={field.name}>{t("password")}</FieldLabel>
                  <Button
                    type="button"
                    variant="link"
                    size="sm"
                    className="h-auto p-0 text-xs"
                    onClick={() => router.push("/reset-password")}
                  >
                    {t("forgotPassword")}
                  </Button>
                </div>
                <div className="relative w-full">
                  <Input
                    id={field.name}
                    name={field.name}
                    type={showPassword ? "text" : "password"}
                    placeholder={t("passwordPlaceholder")}
                    value={field.state.value}
                    onChange={e => field.handleChange(e.target.value)}
                    onBlur={field.handleBlur}
                    disabled={loading}
                    autoComplete="current-password"
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

        <div className="flex items-center gap-2">
          <Checkbox
            id="remember-me"
            checked={rememberMe}
            onCheckedChange={checked => setRememberMe(checked === true)}
          />
          <label htmlFor="remember-me" className="text-muted-foreground text-sm select-none">
            {t("rememberMe")}
          </label>
        </div>

        <Field orientation="horizontal">
          <Button
            type="submit"
            variant="default"
            size="lg"
            className="w-full"
            disabled={loading || !form.state.isValid}
          >
            {loading ? t("signingIn") : t("logIn")}
          </Button>
        </Field>
      </FieldGroup>

      <AuthFormFooter
        text={t("newToPlatform")}
        linkText={t("signUpForAccount")}
        linkHref="/sign-up"
      />
    </form>
  );
}
