"use server";

import { headers } from "next/headers";
import { redirect } from "next/navigation";
import { env } from "@/env";
import { auth } from "@/server/auth/auth";

export async function signIn(email: string, password: string) {
  const headersList = await headers();
  const result = await auth.api.signInEmail({
    body: {
      email,
      password,
    },
    headers: headersList,
  });

  if (env.REQUIRE_EMAIL_VERIFICATION && !result.user.emailVerified) {
    redirect(`/verify-email?email=${encodeURIComponent(email)}`);
  }
  redirect("/new");
}
