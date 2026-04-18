"use client";

import { usePathname, useRouter } from "next/navigation";
import { authClient } from "@/server/auth/auth-client";
import { Check, ChevronDown, Globe, LogOut, Settings } from "lucide-react";
import { useLocale, useTranslations } from "next-intl";
import { useAnalytics } from "@packages/analytics/client";
import { POSTHOG_EVENTS } from "@packages/analytics/constants";

import { localesConfig } from "@/lib/i18n/routing";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuSub,
  DropdownMenuSubContent,
  DropdownMenuSubTrigger,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

export function SidebarUserProfile({ collapsed = false }: { collapsed?: boolean }) {
  const { data: session } = authClient.useSession();
  const router = useRouter();
  const pathname = usePathname();
  const t = useTranslations("dashboard.userProfile");
  const locale = useLocale();

  const posthog = useAnalytics();

  const handleSignOut = async () => {
    posthog?.capture(POSTHOG_EVENTS.USER_SIGNED_OUT);
    await authClient.signOut();
    posthog?.reset();
    router.push("/sign-in");
  };

  if (!session?.user) return null;

  const initials =
    session.user.name
      ?.split(" ")
      .map(n => n[0])
      .join("")
      .toUpperCase() || "U";

  const avatar = (
    <Avatar className="h-8 w-8 shrink-0">
      <AvatarImage src={session.user.image || undefined} />
      <AvatarFallback className="dark:bg-primary/10 dark:text-foreground bg-[#4A4A4A] text-xs text-white">
        {initials}
      </AvatarFallback>
    </Avatar>
  );

  return (
    <DropdownMenu>
      <DropdownMenuTrigger className="w-full outline-none">
        {collapsed ? (
          <div className="dark:hover:bg-accent flex w-full justify-center rounded-lg p-1 transition-colors hover:bg-[#E0E0E0]">
            {avatar}
          </div>
        ) : (
          <div className="dark:hover:bg-accent hover:bg-secondary flex w-full items-center gap-2 rounded-lg p-2 transition-colors">
            {avatar}
            <div className="min-w-0 flex-1 truncate text-left">
              <div className="dark:text-foreground truncate text-sm font-medium text-[#4A4A4A]">
                {session.user.name || session.user.email}
              </div>
              <div className="dark:text-muted-foreground truncate text-xs text-[#9E9E9E]">
                {session.user.email}
              </div>
            </div>
            <ChevronDown className="dark:text-muted-foreground h-4 w-4 shrink-0 text-[#9E9E9E]" />
          </div>
        )}
      </DropdownMenuTrigger>
      <DropdownMenuContent
        side={collapsed ? "right" : "top"}
        align="end"
        sideOffset={8}
        className="w-64"
      >
        <DropdownMenuLabel className="text-muted-foreground px-2 py-1.5 text-sm font-normal">
          {session.user.email}
        </DropdownMenuLabel>
        <DropdownMenuItem onClick={() => router.push("/settings/general")}>
          <Settings className="h-4 w-4" />
          {t("settings")}
        </DropdownMenuItem>
        <DropdownMenuSub>
          <DropdownMenuSubTrigger className="gap-2">
            <Globe className="h-4 w-4" />
            {t("language")}
          </DropdownMenuSubTrigger>
          <DropdownMenuSubContent className="w-48">
            {Object.entries(localesConfig).map(([code, { name, flag }]) => (
              <DropdownMenuItem
                key={code}
                onClick={() => {
                  document.cookie = `NEXT_LOCALE=${code}; path=/; SameSite=lax`;
                  const segments = pathname.split("/");
                  segments[1] = code;
                  router.push(segments.join("/"));
                }}
              >
                <span className="text-base leading-none">{flag}</span>
                {name}
                {locale === code && <Check className="ml-auto h-4 w-4" />}
              </DropdownMenuItem>
            ))}
          </DropdownMenuSubContent>
        </DropdownMenuSub>
        <DropdownMenuSeparator />
        <DropdownMenuItem onClick={handleSignOut}>
          <LogOut className="h-4 w-4" />
          {t("logOut")}
        </DropdownMenuItem>
      </DropdownMenuContent>
    </DropdownMenu>
  );
}
