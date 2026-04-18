"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { authClient } from "@/server/auth/auth-client";
import { Check, Copy, MoreHorizontal } from "lucide-react";
import { useTranslations } from "next-intl";
import { toast } from "sonner";
import { useAnalytics } from "@packages/analytics/client";
import { POSTHOG_EVENTS } from "@packages/analytics/constants";

import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
  AlertDialogTrigger,
} from "@/components/ui/alert-dialog";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

type Session = {
  id: string;
  token: string;
  userId: string;
  userAgent?: string | null;
  ipAddress?: string | null;
  createdAt: Date;
  updatedAt: Date;
};

function parseDeviceName(userAgent: string | null | undefined): string {
  if (!userAgent) return "Unknown device";

  let os = "";
  if (/Windows NT/.test(userAgent)) os = "Windows";
  else if (/Android/.test(userAgent)) os = "Android";
  else if (/iPhone|iPad/.test(userAgent)) os = "iOS";
  else if (/Mac OS X/.test(userAgent)) os = "Mac OS X";
  else if (/Linux/.test(userAgent)) os = "Linux";

  let browser = "";
  if (/CriOS/.test(userAgent)) browser = "Chrome";
  else if (/Edg\//.test(userAgent)) browser = "Edge";
  else if (/OPR|Opera/.test(userAgent)) browser = "Opera";
  else if (/Chrome\//.test(userAgent)) browser = "Chrome";
  else if (/Firefox\//.test(userAgent)) browser = "Firefox";
  else if (/Safari\//.test(userAgent)) browser = "Safari";

  if (browser && os) return `${browser} (${os})`;
  if (browser) return browser;
  if (os) return os;
  return "Unknown device";
}

function formatDate(date: Date | string): string {
  return new Intl.DateTimeFormat(undefined, {
    year: "numeric",
    month: "short",
    day: "numeric",
    hour: "numeric",
    minute: "2-digit",
  }).format(new Date(date));
}

interface SettingsAccountProps {
  userId: string;
}

export function SettingsAccount({ userId }: SettingsAccountProps) {
  const t = useTranslations("dashboard.settings.account");
  const router = useRouter();
  const { data: currentSession } = authClient.useSession();

  const [sessions, setSessions] = useState<Session[]>([]);
  const [sessionsLoading, setSessionsLoading] = useState(true);
  const [copied, setCopied] = useState(false);
  const [isLogoutAllLoading, setIsLogoutAllLoading] = useState(false);
  const [isDeleteLoading, setIsDeleteLoading] = useState(false);
  const [revokingSession, setRevokingSession] = useState<string | null>(null);
  const posthog = useAnalytics();

  useEffect(() => {
    authClient.listSessions().then(({ data }) => {
      if (data) setSessions(data as Session[]);
      setSessionsLoading(false);
    });
  }, []);

  const handleCopyUserId = () => {
    void navigator.clipboard.writeText(userId);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  };

  const handleLogoutAll = async () => {
    setIsLogoutAllLoading(true);
    const { error } = await authClient.revokeSessions();
    if (error) {
      toast.error(t("logoutAllError"));
    } else {
      posthog?.capture(POSTHOG_EVENTS.USER_SIGNED_OUT);
      posthog?.reset();
      router.push("/sign-in");
    }
    setIsLogoutAllLoading(false);
  };

  const handleDeleteAccount = async () => {
    setIsDeleteLoading(true);
    const { error } = await authClient.deleteUser();
    if (error) {
      toast.error(t("deleteError"));
    } else {
      router.push("/sign-in");
    }
    setIsDeleteLoading(false);
  };

  const handleRevokeSession = async (token: string) => {
    setRevokingSession(token);
    const { error } = await authClient.revokeSession({ token });
    if (error) {
      toast.error(t("signOutSessionError"));
    } else {
      setSessions(prev => prev.filter(s => s.token !== token));
    }
    setRevokingSession(null);
  };

  const currentToken = currentSession?.session?.token;

  return (
    <div className="divide-border divide-y">
      {/* Account section */}
      <div className="pb-6">
        <h2 className="mb-4 text-base font-semibold">{t("title")}</h2>

        <div className="space-y-0">
          {/* Log out of all devices */}
          <div className="flex items-center justify-between gap-4 py-3">
            <span className="text-sm">{t("logoutAllDevices")}</span>
            <AlertDialog>
              <AlertDialogTrigger asChild>
                <Button variant="outline" size="sm" disabled={isLogoutAllLoading}>
                  {isLogoutAllLoading ? t("loggingOut") : t("logoutButton")}
                </Button>
              </AlertDialogTrigger>
              <AlertDialogContent>
                <AlertDialogHeader>
                  <AlertDialogTitle>{t("confirmLogout")}</AlertDialogTitle>
                  <AlertDialogDescription>{t("confirmLogoutDescription")}</AlertDialogDescription>
                </AlertDialogHeader>
                <AlertDialogFooter>
                  <AlertDialogCancel>{t("cancel")}</AlertDialogCancel>
                  <AlertDialogAction onClick={handleLogoutAll}>{t("confirm")}</AlertDialogAction>
                </AlertDialogFooter>
              </AlertDialogContent>
            </AlertDialog>
          </div>

          {/* User ID */}
          <div className="flex items-center justify-between gap-4 py-3">
            <span className="text-sm">{t("userId")}</span>
            <div className="bg-muted flex items-center gap-2 rounded-md px-3 py-1.5">
              <span className="text-muted-foreground font-mono text-sm">{userId}</span>
              <button
                type="button"
                onClick={handleCopyUserId}
                className="text-muted-foreground hover:text-foreground transition-colors"
                aria-label={t("copyId")}
              >
                {copied ? <Check className="h-4 w-4" /> : <Copy className="h-4 w-4" />}
              </button>
            </div>
          </div>

          {/* Delete account */}
          <div className="pt-3">
            <AlertDialog>
              <AlertDialogTrigger asChild>
                <Button
                  variant="outline"
                  size="sm"
                  disabled={isDeleteLoading}
                  className="text-destructive border-destructive/30 hover:bg-destructive/5 hover:text-destructive"
                >
                  {isDeleteLoading ? t("deleting") : t("deleteButton")}
                </Button>
              </AlertDialogTrigger>
              <AlertDialogContent>
                <AlertDialogHeader>
                  <AlertDialogTitle>{t("confirmDelete")}</AlertDialogTitle>
                  <AlertDialogDescription>{t("confirmDeleteDescription")}</AlertDialogDescription>
                </AlertDialogHeader>
                <AlertDialogFooter>
                  <AlertDialogCancel>{t("cancel")}</AlertDialogCancel>
                  <AlertDialogAction
                    onClick={handleDeleteAccount}
                    className="bg-destructive text-destructive-foreground hover:bg-destructive/90"
                  >
                    {t("deleteButton")}
                  </AlertDialogAction>
                </AlertDialogFooter>
              </AlertDialogContent>
            </AlertDialog>
          </div>
        </div>
      </div>

      {/* Active sessions */}
      <div className="pt-6">
        <h2 className="mb-4 text-base font-semibold">{t("activeSessions")}</h2>

        {sessionsLoading ? (
          <div className="space-y-3">
            {[1, 2].map(i => (
              <div
                key={i}
                className="h-5 w-full animate-pulse rounded bg-gray-100 dark:bg-gray-800"
              />
            ))}
          </div>
        ) : (
          <table className="w-full text-sm">
            <thead>
              <tr className="text-muted-foreground border-b text-left">
                <th className="pb-2 font-normal">{t("device")}</th>
                <th className="pb-2 font-normal">{t("location")}</th>
                <th className="pb-2 font-normal">{t("created")}</th>
                <th className="pb-2 font-normal">{t("updated")}</th>
                <th className="pb-2" />
              </tr>
            </thead>
            <tbody className="divide-border divide-y">
              {sessions.map(session => {
                const isCurrent = session.token === currentToken;
                return (
                  <tr key={session.id}>
                    <td className="py-3">
                      <div className="flex items-center gap-2">
                        <span>{parseDeviceName(session.userAgent)}</span>
                        {isCurrent && (
                          <span className="text-muted-foreground rounded border px-1.5 py-0.5 text-[10px] font-medium">
                            {t("current")}
                          </span>
                        )}
                      </div>
                    </td>
                    <td className="text-muted-foreground py-3">{session.ipAddress ?? "—"}</td>
                    <td className="text-muted-foreground py-3">{formatDate(session.createdAt)}</td>
                    <td className="text-muted-foreground py-3">{formatDate(session.updatedAt)}</td>
                    <td className="py-3 text-right">
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                          <button
                            type="button"
                            className="text-muted-foreground hover:text-foreground transition-colors"
                            aria-label={t("sessionOptions")}
                          >
                            <MoreHorizontal className="h-4 w-4" />
                          </button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end">
                          <DropdownMenuItem
                            onClick={() => handleRevokeSession(session.token)}
                            disabled={revokingSession === session.token}
                          >
                            {t("signOutSession")}
                          </DropdownMenuItem>
                        </DropdownMenuContent>
                      </DropdownMenu>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        )}
      </div>
    </div>
  );
}
