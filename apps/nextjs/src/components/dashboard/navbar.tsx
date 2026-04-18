"use client";

import { ReactNode } from "react";
import Link from "next/link";
import { useTranslations } from "next-intl";

import { Button } from "@/components/ui/button";
import { Dialog, DialogClose } from "@/components/ui/dialog";
import { SheetContent, SheetHeader, SheetTrigger } from "@/components/ui/sheet";

export function SidebarProvider({ children }: { children: ReactNode }) {
  return <>{children}</>;
}

export default function DashboardTopNav({
  children,
  logo,
}: {
  children: ReactNode;
  logo: ReactNode;
}) {
  const t = useTranslations("dashboard.sidebar");

  return (
    <div className="flex h-full flex-col">
      <header className="bg-muted/50 flex h-14 shrink-0 items-center gap-4 px-3 lg:h-[52px]">
        <Dialog>
          <SheetTrigger asChild>
            <Button
              variant="ghost"
              size="icon"
              className="h-8 w-8 min-[1024px]:hidden"
              aria-label={t("showSidebar")}
            >
              <span className="sr-only">{t("home")}</span>
            </Button>
          </SheetTrigger>
          <SheetContent side="left">
            <SheetHeader>{logo}</SheetHeader>
            <div className="mt-[1rem] flex flex-col space-y-3">
              <DialogClose asChild>
                <Link prefetch={true} href="/new">
                  <Button variant="outline" className="w-full">
                    {t("agent")}
                  </Button>
                </Link>
              </DialogClose>
            </div>
          </SheetContent>
        </Dialog>
      </header>
      <div className="bg-muted/50 flex-1 overflow-y-auto">{children}</div>
    </div>
  );
}
