"use server";

import { headers } from "next/headers";
import { auth } from "@/server/auth/auth";

export async function requestPasswordReset(email: string) {
  try {
    const headersList = await headers();
    await auth.api.forgetPassword({
      body: {
        email,
      },
      headers: headersList,
    });

    return { success: true };
  } catch (error: any) {
    console.error("Password reset request failed:", error);
    throw new Error(error?.message || "Failed to send password reset email");
  }
}
