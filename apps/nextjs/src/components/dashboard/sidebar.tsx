"use client";

import { useEffect, useState } from "react";
import type React from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { useTRPC } from "@/server/trpc/trpc";
import { useQuery } from "@tanstack/react-query";
import { AnimatePresence, motion } from "framer-motion";
import { ChevronLeft, Loader2, MessageSquare, Plus } from "lucide-react";
import { useTranslations } from "next-intl";

import { Button } from "@/components/ui/button";
import { Tooltip, TooltipContent, TooltipTrigger } from "@/components/ui/tooltip";

import { SidebarUserProfile } from "./sidebar-user-profile";

function NavTooltip({
  label,
  collapsed,
  children,
}: {
  label: string;
  collapsed: boolean;
  children: React.ReactNode;
}) {
  if (!collapsed) return <>{children}</>;
  return (
    <Tooltip>
      <TooltipTrigger asChild>{children}</TooltipTrigger>
      <TooltipContent side="right" sideOffset={8}>
        {label}
      </TooltipContent>
    </Tooltip>
  );
}

const RECENTS_LIMIT = 20;

const SIDEBAR_ACTIVE =
  "bg-primary text-primary-foreground dark:bg-primary-hover dark:text-primary-foreground";

function isNewChatPath(pathname: string): boolean {
  return pathname === "/new" || pathname.endsWith("/new");
}

function isRecentsPath(pathname: string): boolean {
  return pathname === "/recents" || pathname.endsWith("/recents");
}

function isThreadPath(pathname: string, threadId: string): boolean {
  const segments = pathname.replace(/^\/+/, "").split("/").filter(Boolean);
  return segments.length >= 2 && segments[segments.length - 1] === threadId;
}

export default function DashboardSideBar() {
  const [collapsed, setCollapsed] = useState(
    () => typeof window !== "undefined" && localStorage.getItem("sidebar-collapsed") === "true"
  );

  const toggleCollapsed = () =>
    setCollapsed(prev => {
      const next = !prev;
      localStorage.setItem("sidebar-collapsed", String(next));
      return next;
    });

  const pathname = usePathname();
  const t = useTranslations("dashboard.chat");
  const tSidebar = useTranslations("dashboard.sidebar");
  const tMeta = useTranslations("metadata");
  const trpc = useTRPC();
  const { data: threads = [], isLoading } = useQuery(
    trpc.threads.list.queryOptions({ limit: RECENTS_LIMIT, cursor: 0 })
  );

  const ease = [0.4, 0, 0.2, 1] as const;

  return (
    <motion.aside
      initial={{ width: 280 }}
      animate={{ width: collapsed ? 56 : 280 }}
      transition={{ duration: 0.25, ease }}
      className="dark:border-border dark:bg-background border-border bg-secondary flex shrink-0 flex-col overflow-hidden border-r"
    >
      {/* Header */}
      <div className="flex h-[52px] items-center px-2">
        <AnimatePresence>
          {!collapsed && (
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              transition={{ duration: 0.15 }}
              className="flex-1 overflow-hidden px-2"
            >
              <Link
                href="/new"
                className="dark:text-foreground text-lg font-semibold whitespace-nowrap text-[#4A4A4A] transition-opacity hover:opacity-80"
              >
                {tMeta("name")}
              </Link>
            </motion.div>
          )}
        </AnimatePresence>
        <Tooltip>
          <TooltipTrigger asChild>
            <button
              type="button"
              onClick={toggleCollapsed}
              className="dark:text-foreground flex h-8 w-8 shrink-0 items-center justify-center rounded-md text-[#4A4A4A] transition-colors hover:bg-black/10 dark:hover:bg-white/10"
            >
              <motion.div
                animate={{ rotate: collapsed ? 180 : 0 }}
                transition={{ duration: 0.25, ease }}
              >
                <ChevronLeft className="h-4 w-4" />
              </motion.div>
            </button>
          </TooltipTrigger>
          <TooltipContent side="right" sideOffset={8}>
            {collapsed ? tSidebar("expandSidebar") : tSidebar("collapseSidebar")}
          </TooltipContent>
        </Tooltip>
      </div>

      {/* Primary nav */}
      <div className="dark:border-border space-y-0.5 border-b border-[#D4D4D4] px-2 py-2">
        <NavTooltip label={t("newChat")} collapsed={collapsed}>
          <Button
            variant="ghost"
            size="sm"
            className={`group dark:text-foreground w-full rounded-sm text-sm text-[#4A4A4A] ${collapsed ? "justify-center px-0" : "justify-start gap-2"} ${isNewChatPath(pathname) ? SIDEBAR_ACTIVE : "dark:hover:text-foreground hover:bg-black/10 hover:text-[#4A4A4A] dark:hover:bg-white/10"}`}
            asChild
          >
            <Link href="/new">
              <motion.span
                className="inline-flex items-center justify-center rounded p-0.5 transition-colors duration-150 group-hover:bg-black/10 dark:group-hover:bg-white/10"
                whileHover={{ scale: 1.18 }}
                transition={{ type: "spring", stiffness: 400, damping: 18 }}
              >
                <Plus className="h-4 w-4" />
              </motion.span>
              <AnimatePresence>
                {!collapsed && (
                  <motion.span
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    exit={{ opacity: 0 }}
                    transition={{ duration: 0.15 }}
                    className="whitespace-nowrap"
                  >
                    {t("newChat")}
                  </motion.span>
                )}
              </AnimatePresence>
            </Link>
          </Button>
        </NavTooltip>

        <NavTooltip label={t("allChats")} collapsed={collapsed}>
          <Button
            variant="ghost"
            size="sm"
            className={`group dark:text-foreground w-full rounded-sm text-sm text-[#4A4A4A] ${collapsed ? "justify-center px-0" : "justify-start gap-2"} ${isRecentsPath(pathname) ? SIDEBAR_ACTIVE : "dark:hover:text-foreground hover:bg-black/10 hover:text-[#4A4A4A] dark:hover:bg-white/10"}`}
            asChild
          >
            <Link href="/recents">
              <motion.span
                className="inline-flex items-center justify-center rounded p-0.5 transition-colors duration-150 group-hover:bg-black/10 dark:group-hover:bg-white/10"
                whileHover={{ scale: 1.18 }}
                transition={{ type: "spring", stiffness: 400, damping: 18 }}
              >
                <MessageSquare className="h-4 w-4" />
              </motion.span>
              <AnimatePresence>
                {!collapsed && (
                  <motion.span
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    exit={{ opacity: 0 }}
                    transition={{ duration: 0.15 }}
                    className="whitespace-nowrap"
                  >
                    {t("allChats")}
                  </motion.span>
                )}
              </AnimatePresence>
            </Link>
          </Button>
        </NavTooltip>
      </div>

      {/* Recents */}
      <AnimatePresence>
        {!collapsed && (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 0.15 }}
            className="flex-1 overflow-y-auto bg-black/[0.03] dark:bg-white/[0.02]"
          >
            <p className="px-4 pt-3 pb-1 text-xs font-medium tracking-wide text-[#5c5c5c] uppercase dark:text-[#b0b0b0]">
              {t("recentChats")}
            </p>
            <div className="space-y-0.5 p-2">
              {isLoading && (
                <div className="flex items-center justify-center gap-2 py-4">
                  <Loader2 className="text-muted-foreground h-4 w-4 animate-spin" />
                </div>
              )}
              {!isLoading && threads.length === 0 && (
                <p className="text-muted-foreground px-2 py-1.5 text-xs">{t("noThreadsYet")}</p>
              )}
              {!isLoading &&
                threads.map(thread => {
                  const active = isThreadPath(pathname, thread.id);
                  return (
                    <Link
                      key={thread.id}
                      href={`/chat/${thread.id}`}
                      className={`block truncate rounded-sm px-2 py-1.5 pl-3 text-left text-sm transition-colors ${
                        active
                          ? `${SIDEBAR_ACTIVE} border-l-primary border-l-2`
                          : "dark:text-foreground dark:hover:text-foreground border-l-2 border-l-transparent text-[#4A4A4A] hover:bg-black/10 hover:text-[#4A4A4A] dark:hover:bg-white/10"
                      }`}
                    >
                      {thread.subject}
                    </Link>
                  );
                })}
            </div>
          </motion.div>
        )}
      </AnimatePresence>

      {collapsed && <div className="flex-1" />}

      {/* User profile */}
      <div className="dark:border-border border-t border-[#D4D4D4] p-3">
        <SidebarUserProfile collapsed={collapsed} />
      </div>
    </motion.aside>
  );
}
