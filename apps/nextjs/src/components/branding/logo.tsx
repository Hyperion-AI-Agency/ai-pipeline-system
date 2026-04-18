import Link from "next/link";
import { cva, type VariantProps } from "class-variance-authority";

import { cn } from "@/lib/utils";

const APP_NAME = "App";

const logoVariants = cva("flex items-center gap-2 font-medium", {
  variants: {
    variant: {
      default: "",
      icon: "",
      text: "",
    },
    size: {
      sm: "gap-1.5",
      default: "gap-2",
      lg: "gap-3",
    },
  },
  defaultVariants: {
    variant: "default",
    size: "default",
  },
});

interface LogoProps extends VariantProps<typeof logoVariants> {
  className?: string;
  href?: string;
}

export function Logo({ className, variant = "default", size = "default", href = "/" }: LogoProps) {
  const showText = variant !== "icon";

  return (
    <Link href={href as any} className={cn(logoVariants({ variant, size }), className)}>
      {showText && <span className="font-semibold">{APP_NAME}</span>}
    </Link>
  );
}
