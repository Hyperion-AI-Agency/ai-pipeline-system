import { ReactNode } from "react";
import { headers } from "next/headers";
import { redirect } from "next/navigation";
import { env } from "@/env";
import { auth } from "@/server/auth/auth";
import { CustomerStateSubscription } from "@polar-sh/sdk/models/components/customerstatesubscription.js";

import AppUnderDevelopment from "@/components/dashboard/app-under-development";
import DashboardSideBar from "@/components/dashboard/sidebar";
import { SubscriptionGuard } from "@/components/dashboard/subscription-guard";

// Force dynamic rendering - protected route with auth check
export const dynamic = "force-dynamic";

type Props = {
  children: ReactNode;
  params: Promise<{ locale: string }>;
};

export default async function ProtectedLayout({ children, params }: Props) {
  const { locale } = await params;

  // CHECK IF AUTHENTICATED
  const session = await auth.api.getSession({
    headers: await headers(),
  });

  if (!session?.user.id) {
    redirect("/sign-in");
  }

  // TODO: make this better
  // CHECK IF ACTIVE SUBSCRIPTION EXISTS
  let activeSubscription: CustomerStateSubscription | undefined;

  try {
    const state = await auth.api.state({
      headers: await headers(),
    });
    activeSubscription = state.activeSubscriptions[0];
  } catch (error) {
    console.warn("Failed to fetch customer state, treating as no active subscription:", error);
  }

  // Show under development message if app is still being developed
  if (env.NEXT_PUBLIC_APP_UNDER_DEVELOPMENT) {
    return <AppUnderDevelopment />;
  }

  const paywallEnabled = env.NEXT_PUBLIC_PAYWALL_ENABLED;

  return (
    <div className="flex h-screen w-full overflow-hidden bg-[#F7F7F7] font-medium dark:bg-[#1c1c1c]">
      <DashboardSideBar />
      <main className="dark:bg-background flex-1 overflow-hidden bg-[#F7F7F7]">
        {paywallEnabled ? (
          <SubscriptionGuard hasSubscription={!!activeSubscription}>{children}</SubscriptionGuard>
        ) : (
          children
        )}
      </main>
    </div>
  );
}
