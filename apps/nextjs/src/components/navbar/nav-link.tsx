"use client";

import Link from "next/link";

interface NavLinkProps {
  href: string;
  label: string;
  openInNewTab?: boolean;
  className?: string;
  onClick?: () => void;
}

export function NavLink({ href, label, openInNewTab, className, onClick }: NavLinkProps) {
  const isExternal = href.startsWith("http") || openInNewTab;
  const hasHash = href.includes("#");

  const handleClick = (e: React.MouseEvent<HTMLAnchorElement>) => {
    if (onClick) {
      onClick();
    }

    // Handle smooth scrolling for hash links
    if (hasHash && !isExternal) {
      const hash = href.split("#")[1];
      if (hash) {
        // Small delay to ensure navigation completes first
        setTimeout(() => {
          const element = document.getElementById(hash);
          if (element) {
            element.scrollIntoView({ behavior: "smooth", block: "start" });
          }
        }, 100);
      }
    }
  };

  if (isExternal) {
    return (
      <a
        href={href}
        target={openInNewTab ? "_blank" : undefined}
        rel={openInNewTab ? "noopener noreferrer" : undefined}
        className={className}
        onClick={onClick}
      >
        {label}
      </a>
    );
  }

  return (
    <Link href={href as any} className={className} onClick={handleClick}>
      {label}
    </Link>
  );
}
