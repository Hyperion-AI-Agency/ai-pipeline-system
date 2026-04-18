import { env } from "@/env";
import { resend } from "@/server/resend";

import { PasswordResetTemplate } from "@/components/emails/password-reset";

export async function sendPasswordResetEmail({
  to,
  url,
  callbackURL,
}: {
  to: string;
  url: string;
  callbackURL: string;
}) {
  // url contains only the path, so we need to prepend the base URL
  const fullUrl = new URL(url, env.NEXT_PUBLIC_APP_URL);
  fullUrl.searchParams.set("callbackURL", callbackURL);

  const { data, error } = await resend.emails.send({
    from: env.RESEND_FROM,
    to: [to],
    subject: "Reset your password",
    react: PasswordResetTemplate({ resetUrl: fullUrl.toString() }),
  });

  if (error) {
    console.error("Failed to send password reset email:", error);
    throw error;
  }

  return data;
}
