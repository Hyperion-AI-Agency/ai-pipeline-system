import { headers } from "next/headers";
import { auth } from "@/server/auth/auth";

import { SettingsAccount } from "../_components/settings-account";

export default async function SettingsAccountPage() {
  const headersList = await headers();
  const session = await auth.api.getSession({ headers: headersList });
  const userId = session?.user?.id ?? "";

  return <SettingsAccount userId={userId} />;
}
