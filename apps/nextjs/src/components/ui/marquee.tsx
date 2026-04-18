"use client";

import * as React from "react";
import type { MarqueeProps as FastMarqueeProps } from "react-fast-marquee";
import FastMarquee from "react-fast-marquee";

import { cn } from "@/lib/utils";

const Marquee = React.forwardRef<HTMLDivElement, React.HTMLAttributes<HTMLDivElement>>(
  ({ className, ...props }, ref) => (
    <div ref={ref} className={cn("relative w-full overflow-hidden", className)} {...props} />
  )
);
Marquee.displayName = "Marquee";

const MarqueeContent = React.forwardRef<
  HTMLDivElement,
  React.HTMLAttributes<HTMLDivElement> & FastMarqueeProps
>(({ className, loop = 0, autoFill = true, pauseOnHover = true, ...props }, ref) => {
  const MarqueeComponent = FastMarquee as any;
  return (
    <MarqueeComponent
      ref={ref}
      autoFill={autoFill}
      loop={loop}
      pauseOnHover={pauseOnHover}
      className={cn("flex", className)}
      {...props}
    />
  );
});
MarqueeContent.displayName = "MarqueeContent";

const MarqueeItem = React.forwardRef<HTMLDivElement, React.HTMLAttributes<HTMLDivElement>>(
  ({ className, ...props }, ref) => (
    <div ref={ref} className={cn("mx-2 flex-shrink-0", className)} {...props} />
  )
);
MarqueeItem.displayName = "MarqueeItem";

const MarqueeFade = React.forwardRef<
  HTMLDivElement,
  React.HTMLAttributes<HTMLDivElement> & { side: "left" | "right" }
>(({ className, side, ...props }, ref) => (
  <div
    ref={ref}
    className={cn(
      "pointer-events-none absolute top-0 z-10 h-full w-24",
      side === "left"
        ? "left-0 bg-gradient-to-r from-white to-transparent"
        : "right-0 bg-gradient-to-l from-white to-transparent",
      className
    )}
    {...props}
  />
));
MarqueeFade.displayName = "MarqueeFade";

export { Marquee, MarqueeContent, MarqueeItem, MarqueeFade };
