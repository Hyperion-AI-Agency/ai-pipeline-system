"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { authClient } from "@/server/auth/auth-client";
import { Loader2 } from "lucide-react";
import { useTranslations } from "next-intl";
import { toast } from "sonner";

import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuGroup,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuShortcut,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

interface UserProfileProps {
  mini?: boolean;
}

export default function UserProfile({ mini = false }: UserProfileProps) {
  const t = useTranslations("dashboard.userProfile");
  const tCommon = useTranslations("common");
  const { data: session, isPending } = authClient.useSession();
  const router = useRouter();

  const handleSignOut = async () => {
    try {
      await authClient.signOut({
        fetchOptions: {
          onSuccess: () => {
            router.push("/sign-in");
          },
        },
      });
    } catch (error) {
      console.error("Error signing out:", error);
      toast.error(t("signOutFailed"));
    }
  };

  const userName = session?.user?.name || t("user");
  const userInitial = userName.charAt(0).toUpperCase();
  const userImage = session?.user?.image;

  return (
    <DropdownMenu>
      <DropdownMenuTrigger asChild>
        <button
          className={`flex items-center gap-2 rounded transition-opacity hover:opacity-80 ${
            mini ? "justify-center" : "w-full justify-start px-4 pt-2 pb-3"
          }`}
        >
          <Avatar>
            {isPending ? (
              <div className="flex h-full w-full items-center justify-center">
                <Loader2 className="h-4 w-4 animate-spin" />
              </div>
            ) : (
              <>
                {userImage ? (
                  <AvatarImage src={userImage} alt="User Avatar" />
                ) : (
                  <AvatarFallback>{userInitial}</AvatarFallback>
                )}
              </>
            )}
          </Avatar>
          {!mini && (
            <div className="flex items-center gap-2">
              <p className="text-md font-medium">{isPending ? tCommon("loading") : userName}</p>
              {isPending && <Loader2 className="h-3 w-3 animate-spin" />}
            </div>
          )}
        </button>
      </DropdownMenuTrigger>
      <DropdownMenuContent className="w-56">
        <DropdownMenuLabel>{t("myAccount")}</DropdownMenuLabel>
        <DropdownMenuSeparator />
        <DropdownMenuGroup>
          <Link href="/settings">
            <DropdownMenuItem>
              {t("settings")}
              <DropdownMenuShortcut>⇧⌘S</DropdownMenuShortcut>
            </DropdownMenuItem>
          </Link>
        </DropdownMenuGroup>
        <DropdownMenuSeparator />
        <DropdownMenuItem onClick={handleSignOut}>
          {t("logOut")}
          <DropdownMenuShortcut>⇧⌘Q</DropdownMenuShortcut>
        </DropdownMenuItem>
      </DropdownMenuContent>
    </DropdownMenu>
  );
}
