"use client";

import { useEffect, useState } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import { authClient } from "@/server/auth/auth-client";
import { useForm } from "@tanstack/react-form";
import { Eye, EyeOff } from "lucide-react";
import { useTranslations } from "next-intl";
import { toast } from "sonner";
import { z } from "zod";

import { Button } from "@/components/ui/button";
import { Field, FieldError, FieldGroup, FieldLabel } from "@/components/ui/field";
import { Input } from "@/components/ui/input";

import { AuthFormFooter } from "./auth-form-footer";
import { AuthFormHeader } from "./auth-form-header";
import { AuthLoadingState } from "./auth-loading-state";
import { AuthSuccessState } from "./auth-success-state";

export function ResetPasswordForm({ token: initialToken }: { token: string }) {
  const [loading, setLoading] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const [success, setSuccess] = useState(false);
  const searchParams = useSearchParams();
  const router = useRouter();
  const t = useTranslations("auth.resetPassword");

  useEffect(() => {
    const errorParam = searchParams.get("error");
    if (errorParam === "INVALID_TOKEN") {
      toast.error(t("invalidToken"));
      router.push("/reset-password");
      return;
    }
  }, [searchParams, router, t]);

  const resetSchema = z
    .object({
      password: z.string().min(8, t("passwordRequired")),
      confirmPassword: z.string().min(8, t("confirmPasswordRequired")),
    })
    .refine(data => data.password === data.confirmPassword, {
      message: t("passwordsDoNotMatch"),
      path: ["confirmPassword"],
    });

  const form = useForm({
    defaultValues: {
      password: "",
      confirmPassword: "",
    },
    validators: {
      onChange: resetSchema,
    },
    onSubmit: async ({ value }) => {
      setLoading(true);

      authClient
        .resetPassword({
          newPassword: value.password,
          token: initialToken,
        })
        .then(result => {
          if (result?.error) {
            toast.error(result.error.message || t("failedToReset"), {
              duration: 5000,
            });
            return;
          }

          setSuccess(true);
        })
        .catch((error: any) => {
          console.error("Password reset error:", error);
          toast.error(error?.message || t("failedToReset"), {
            duration: 5000,
          });
        })
        .finally(() => {
          setLoading(false);
        });
    },
  });

  if (loading) {
    return <AuthLoadingState message={t("resettingPassword")} />;
  }

  if (success) {
    return (
      <AuthSuccessState
        icon="check"
        title={t("successTitle")}
        description={t("successDescription")}
        buttonText={t("backToSignIn")}
        buttonHref="/sign-in"
      />
    );
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

      <FieldGroup>
        <form.Field name="password">
          {field => {
            const isInvalid = field.state.meta.isTouched && !field.state.meta.isValid;
            return (
              <Field data-invalid={isInvalid}>
                <FieldLabel htmlFor={field.name}>{t("newPassword")}</FieldLabel>
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

        <form.Field name="confirmPassword">
          {field => {
            const isInvalid = field.state.meta.isTouched && !field.state.meta.isValid;
            return (
              <Field data-invalid={isInvalid}>
                <FieldLabel htmlFor={field.name}>{t("confirmPassword")}</FieldLabel>
                <div className="relative">
                  <Input
                    id={field.name}
                    name={field.name}
                    type={showConfirmPassword ? "text" : "password"}
                    placeholder={t("confirmPasswordPlaceholder")}
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
                    onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                    className="text-muted-foreground hover:text-foreground absolute top-1/2 right-3 -translate-y-1/2"
                  >
                    {showConfirmPassword ? (
                      <EyeOff className="h-4 w-4" />
                    ) : (
                      <Eye className="h-4 w-4" />
                    )}
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
            {loading ? t("resetting") : t("resetPassword")}
          </Button>
        </Field>
      </FieldGroup>

      <AuthFormFooter
        text={t("rememberPassword")}
        linkText={t("backToSignIn")}
        linkHref="/sign-in"
      />
    </form>
  );
}
