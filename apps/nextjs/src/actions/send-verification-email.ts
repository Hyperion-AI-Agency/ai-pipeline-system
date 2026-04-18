import { env } from "@/env";
import { resend } from "@/server/resend";

import { EmailVerificationTemplate } from "@/components/emails/email-verification";

export async function sendVerificationEmail({
  to,
  url,
  callbackURL,
}: {
  to: string;
  url: string;
  callbackURL?: string;
}) {
  // url contains only the path, so we need to prepend the base URL
  const fullUrl = new URL(url, env.NEXT_PUBLIC_APP_URL);
  if (callbackURL) {
    fullUrl.searchParams.set("callbackURL", callbackURL);
  }

  const { data, error } = await resend.emails.send({
    from: env.RESEND_FROM,
    to: [to],
    subject: "Verify your email address",
    react: EmailVerificationTemplate({ verificationUrl: fullUrl.toString() }),
  });

  if (error) {
    console.error("Failed to send verification email:", error);
    throw error;
  }

  return data;
}
