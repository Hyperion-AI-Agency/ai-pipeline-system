"use client";

import Link from "next/link";
import { authClient } from "@/server/auth/auth-client";
import { ArrowRight, LayoutDashboard } from "lucide-react";

import { CTA_LINK } from "@/lib/constants";
import { NavLink } from "@/components/navbar/nav-link";

type NavLinkItem = {
  id: string;
  label: string;
  url: string;
  openInNewTab?: boolean;
  children?: NavLinkItem[];
};

interface NavbarMobileMenuProps {
  menuItems: NavLinkItem[];
  ctaButton?: {
    enabled: boolean;
    url: string;
    label: string;
    variant?: "default" | "outline" | "ghost";
  };
  isOpen: boolean;
  onClose: () => void;
  dashboardText?: string | null;
}

export function NavbarMobileMenu({
  menuItems,
  ctaButton,
  isOpen,
  onClose,
  dashboardText,
}: NavbarMobileMenuProps) {
  const { data: session } = authClient.useSession();
  const isAuthenticated = !!session?.user;

  if (!isOpen) return null;

  return (
    <div className="md:hidden">
      <div className="bg-background/50 container mx-auto flex flex-col gap-4 rounded-b-2xl border-t px-3 py-4 backdrop-blur-xl">
        {menuItems?.map(item => (
          <div key={item.id}>
            <NavLink
              href={item.url}
              label={item.label}
              openInNewTab={item.openInNewTab ?? undefined}
              className="hover:text-primary text-sm font-medium transition-colors"
              onClick={onClose}
            />
            {item.children && item.children.length > 0 && (
              <div className="mt-2 ml-4 flex flex-col gap-2">
                {item.children.map(child => (
                  <NavLink
                    key={child.id}
                    href={child.url}
                    label={child.label}
                    openInNewTab={child.openInNewTab ?? undefined}
                    className="hover:text-primary text-muted-foreground text-sm transition-colors"
                    onClick={onClose}
                  />
                ))}
              </div>
            )}
          </div>
        ))}
        <div className="border-t pt-4">
          {isAuthenticated ? (
            <Link
              href="/new"
              onClick={onClose}
              className="bg-primary text-primary-foreground hover:bg-primary/90 flex w-full items-center justify-center gap-2 rounded-full px-4 py-2 text-base font-semibold shadow-sm transition-all duration-200 hover:shadow-md"
            >
              <LayoutDashboard className="h-4 w-4" />
              {dashboardText ?? "Dashboard"}
            </Link>
          ) : (
            <Link
              href={(ctaButton?.url || CTA_LINK) as any}
              onClick={onClose}
              className="bg-primary text-primary-foreground hover:bg-primary/90 flex w-full items-center justify-center gap-2 rounded-full px-4 py-2 text-base font-semibold shadow-sm transition-all duration-200 hover:shadow-md"
            >
              {ctaButton?.label ?? "Get Started"}
              <ArrowRight size={18} />
            </Link>
          )}
        </div>
      </div>
    </div>
  );
}
