"use client";

import { env } from "@/env";
import { polarClient } from "@polar-sh/better-auth";
import { adminClient, jwtClient, organizationClient } from "better-auth/client/plugins";
import { createAuthClient } from "better-auth/react";

/** Single auth client export. Use authClient.useSession, authClient.signIn, authClient.token, etc. */
export const authClient = createAuthClient({
  baseURL: env.NEXT_PUBLIC_APP_URL,
  plugins: [adminClient(), organizationClient(), polarClient(), jwtClient()],
});
