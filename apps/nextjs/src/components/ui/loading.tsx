import { Loader2 } from "lucide-react";

import { cn } from "@/lib/utils";

/** Spinner icon only; use for inline loading states. */
interface LoadingSpinnerProps {
  className?: string;
  size?: "sm" | "md" | "lg";
}

const sizeClasses = {
  sm: "h-4 w-4",
  md: "h-6 w-6",
  lg: "h-8 w-8",
};

export function LoadingSpinner({ className, size = "md" }: LoadingSpinnerProps) {
  return (
    <Loader2
      className={cn("text-primary animate-spin", sizeClasses[size], className)}
      aria-hidden
    />
  );
}

interface LoadingProps {
  className?: string;
  text?: string;
  /** When true, overlay is absolute (only covers the relative parent); otherwise fixed (whole page). */
  contained?: boolean;
}

/** Full-screen overlay with spinner and optional text. Use contained to limit to content pane. */
export function Loading({ className, text = "Loading...", contained = false }: LoadingProps) {
  return (
    <div
      className={cn(
        "bg-background/80 z-50 flex items-center justify-center backdrop-blur-sm",
        contained ? "absolute inset-0" : "fixed inset-0",
        className
      )}
    >
      <div className="flex flex-col items-center space-y-4">
        <LoadingSpinner size="lg" />
        {text && <p className="text-muted-foreground text-sm">{text}</p>}
      </div>
    </div>
  );
}
