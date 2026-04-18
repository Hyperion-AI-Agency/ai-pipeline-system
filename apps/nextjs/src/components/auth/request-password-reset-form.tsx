"use client";

import { useState } from "react";
import { authClient } from "@/server/auth/auth-client";
import { useForm } from "@tanstack/react-form";
import { useTranslations } from "next-intl";
import { toast } from "sonner";
import { z } from "zod";

import { Button } from "@/components/ui/button";
import { Field, FieldError, FieldGroup, FieldLabel } from "@/components/ui/field";
import { Input } from "@/components/ui/input";

import { AuthFormFooter } from "./auth-form-footer";
import { AuthFormHeader } from "./auth-form-header";
import { AuthSuccessState } from "./auth-success-state";

export function RequestPasswordResetForm() {
  const [loading, setLoading] = useState(false);
  const [emailSent, setEmailSent] = useState(false);

  const t = useTranslations("auth.passwordReset");

  const resetSchema = z.object({
    email: z.string().min(1, t("emailRequired")).email(t("emailInvalid")),
  });

  const form = useForm({
    defaultValues: {
      email: "",
    },
    validators: {
      onChange: resetSchema,
    },
    onSubmit: async ({ value }) => {
      try {
        setLoading(true);
        const result = await authClient.forgetPassword({
          email: value.email,
        });

        if (result?.error) {
          toast.error(result?.error?.message || t("failedToSendEmail"), {
            duration: 5000,
          });
          return;
        }

        setEmailSent(true);
      } catch (error: any) {
        console.error("Password reset error:", error);
        toast.error(error?.message || t("failedToSendEmail"), {
          duration: 5000,
        });
      } finally {
        setLoading(false);
      }
    },
  });

  if (emailSent) {
    return (
      <AuthSuccessState
        icon="mail"
        title={t("emailSentTitle")}
        description={t("emailSentDescription")}
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

        <Field orientation="horizontal">
          <Button
            type="submit"
            variant="default"
            size="lg"
            className="w-full"
            disabled={loading || !form.state.isValid}
          >
            {loading ? t("sending") : t("sendResetLink")}
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
