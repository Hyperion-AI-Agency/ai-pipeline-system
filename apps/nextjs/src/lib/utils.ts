import { clsx, type ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

/** Format a date string as relative time (e.g. "2 hours ago"). */
export function formatRelativeTime(isoDate: string): string {
  const short = formatRelativeTimeShort(isoDate);
  if (short === "just now") return short;
  return `${short} ago`;
}

/** Relative time segment only (e.g. "5 minutes") for use in "Last message {{time}} ago". */
export function formatRelativeTimeShort(isoDate: string): string {
  const date = new Date(isoDate);
  const now = new Date();
  const diffMs = now.getTime() - date.getTime();
  const diffSec = Math.floor(diffMs / 1000);
  const diffMin = Math.floor(diffSec / 60);
  const diffHour = Math.floor(diffMin / 60);
  const diffDay = Math.floor(diffHour / 24);

  if (diffSec < 60) return "just now";
  if (diffMin < 60) return `${diffMin} minute${diffMin === 1 ? "" : "s"}`;
  if (diffHour < 24) return `${diffHour} hour${diffHour === 1 ? "" : "s"}`;
  if (diffDay < 7) return `${diffDay} day${diffDay === 1 ? "" : "s"}`;
  return date.toLocaleDateString(undefined, {
    month: "short",
    day: "numeric",
    year: date.getFullYear() !== now.getFullYear() ? "numeric" : undefined,
  });
}
