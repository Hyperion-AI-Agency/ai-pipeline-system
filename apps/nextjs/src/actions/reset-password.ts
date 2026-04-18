"use server";

import { headers } from "next/headers";
import { redirect } from "next/navigation";
import { auth } from "@/server/auth/auth";

export async function resetPassword(newPassword: string, token: string) {
  const headersList = await headers();
  await auth.api.resetPassword({
    body: {
      newPassword,
      token,
    },
    headers: headersList,
  });

  // Redirect to sign-in page after successful password reset
  redirect("/sign-in");
}
