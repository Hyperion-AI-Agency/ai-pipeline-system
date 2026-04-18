"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { authClient } from "@/server/auth/auth-client";
import { ChevronDown, LayoutDashboard, Menu, X } from "lucide-react";

import { Button } from "@/components/ui/button";
import LocaleSwitcher from "@/components/navbar/locale-switcher";
import { NavLink } from "@/components/navbar/nav-link";
import { NavbarMobileMenu } from "@/components/navbar/navbar-mobile-menu";

type NavLinkItem = {
  id: string;
  label: string;
  url: string;
  openInNewTab?: boolean;
  children?: NavLinkItem[];
};

interface NavbarProps {
  navItems: NavLinkItem[];
  ctaButton: {
    enabled: boolean;
    url: string;
    label: string;
    variant?: "default" | "outline" | "ghost";
  };
  forceBlackText?: boolean;
  ctaComponent?: React.ReactNode;
  appName: string;
  dashboardText?: string | null;
  dashboardLink?: string | null;
}

export function Navbar({
  navItems,
  ctaButton,
  ctaComponent,
  appName,
  dashboardText,
  dashboardLink,
}: NavbarProps) {
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const [isScrolled, setIsScrolled] = useState(false);
  const { data: session } = authClient.useSession();
  const isAuthenticated = !!session?.user;

  useEffect(() => {
    const handleScroll = () => setIsScrolled(window.scrollY > 10);
    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  return (
    <>
      <nav
        className={`fixed top-0 right-0 left-0 z-50 w-full transition-all duration-300 ${
          isScrolled
            ? "bg-background/95 border-border/40 border-b backdrop-blur-sm"
            : "border-b border-transparent bg-transparent"
        }`}
      >
        <div className="container mx-auto flex h-16 items-center justify-between px-4 md:px-6 lg:px-8">
          {/* Logo */}
          <div className="text-foreground flex-shrink-0">
            <Link href="/" className="text-xl font-bold">
              {appName}
            </Link>
          </div>

          {/* Desktop Navigation Links — pushed right */}
          <div className="hidden flex-1 items-center justify-end gap-1 md:flex">
            {navItems.map(item => {
              const hasChildren = item.children && item.children.length > 0;
              return (
                <div key={item.id} className="flex items-center">
                  <NavLink
                    href={item.url}
                    label={item.label}
                    openInNewTab={item.openInNewTab}
                    className="text-foreground/70 hover:text-foreground rounded-lg px-3 py-1.5 text-sm font-medium transition-colors"
                  />
                  {hasChildren && <ChevronDown className="text-foreground/50 h-3.5 w-3.5" />}
                </div>
              );
            })}
          </div>

          {/* Desktop Actions */}
          <div className="hidden flex-shrink-0 items-center pl-4 md:flex">
            {/* Separator */}
            <div className="bg-border mx-2 h-5 w-px" />
            <LocaleSwitcher />
            <div className="w-2" />
            {ctaComponent ? (
              ctaComponent
            ) : isAuthenticated ? (
              <Link
                href={dashboardLink || "/new"}
                className="bg-primary text-primary-foreground hover:bg-primary/90 inline-flex items-center gap-2 rounded-full px-5 py-2 text-sm font-semibold shadow-sm transition-all duration-200 hover:shadow-md"
              >
                <LayoutDashboard className="h-4 w-4" />
                {dashboardText ?? "Dashboard"}
              </Link>
            ) : (
              <Link
                href={ctaButton.url}
                className="bg-primary text-primary-foreground hover:bg-primary/90 inline-flex items-center rounded-full px-5 py-2 text-sm font-semibold shadow-sm transition-all duration-200 hover:shadow-md"
              >
                {ctaButton.label}
              </Link>
            )}
          </div>

          {/* Mobile Actions */}
          <div className="flex items-center gap-2 md:hidden">
            <LocaleSwitcher />
            <Button variant="ghost" size="icon" onClick={() => setMobileMenuOpen(!mobileMenuOpen)}>
              {mobileMenuOpen ? (
                <X className="text-foreground h-6 w-6" />
              ) : (
                <Menu className="text-foreground h-6 w-6" />
              )}
            </Button>
          </div>
        </div>
      </nav>

      {/* Mobile Menu */}
      <NavbarMobileMenu
        menuItems={navItems}
        ctaButton={ctaButton}
        isOpen={mobileMenuOpen}
        onClose={() => setMobileMenuOpen(false)}
        dashboardText={dashboardText}
      />
    </>
  );
}
