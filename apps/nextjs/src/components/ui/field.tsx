"use client";

import * as React from "react";
import * as LabelPrimitive from "@radix-ui/react-label";
import { Slot } from "@radix-ui/react-slot";

import { cn } from "@/lib/utils";

const FieldGroup = React.forwardRef<HTMLDivElement, React.ComponentProps<"div">>(
  ({ className, ...props }, ref) => {
    return <div ref={ref} className={cn("flex flex-col gap-6", className)} {...props} />;
  }
);
FieldGroup.displayName = "FieldGroup";

const FieldSet = React.forwardRef<HTMLFieldSetElement, React.ComponentProps<"fieldset">>(
  ({ className, ...props }, ref) => {
    return <fieldset ref={ref} className={cn("flex flex-col gap-6", className)} {...props} />;
  }
);
FieldSet.displayName = "FieldSet";

const FieldLegend = React.forwardRef<
  HTMLLegendElement,
  React.ComponentProps<"legend"> & {
    variant?: "legend" | "label";
  }
>(({ className, variant = "legend", ...props }, ref) => {
  return (
    <legend
      ref={ref}
      className={cn(
        variant === "label"
          ? "text-sm leading-none font-medium"
          : "text-base leading-none font-semibold",
        className
      )}
      {...props}
    />
  );
});
FieldLegend.displayName = "FieldLegend";

const Field = React.forwardRef<
  HTMLDivElement,
  React.ComponentProps<"div"> & {
    orientation?: "vertical" | "horizontal" | "responsive";
  }
>(({ className, orientation = "vertical", ...props }, ref) => {
  return (
    <div
      ref={ref}
      role="group"
      className={cn(
        "flex gap-4",
        orientation === "horizontal"
          ? "flex-row items-center"
          : orientation === "responsive"
            ? "@container/field-group flex-col @[480px]:flex-row @[480px]:items-center"
            : "flex-col",
        "data-[invalid=true]:gap-2",
        className
      )}
      {...props}
    />
  );
});
Field.displayName = "Field";

const FieldContent = React.forwardRef<HTMLDivElement, React.ComponentProps<"div">>(
  ({ className, ...props }, ref) => {
    return <div ref={ref} className={cn("flex flex-col gap-1.5", className)} {...props} />;
  }
);
FieldContent.displayName = "FieldContent";

const FieldLabel = React.forwardRef<
  React.ElementRef<typeof LabelPrimitive.Root>,
  React.ComponentProps<typeof LabelPrimitive.Root>
>(({ className, ...props }, ref) => {
  return (
    <LabelPrimitive.Root
      ref={ref}
      className={cn(
        "text-sm leading-none font-medium peer-disabled:cursor-not-allowed peer-disabled:opacity-50",
        className
      )}
      {...props}
    />
  );
});
FieldLabel.displayName = "FieldLabel";

const FieldDescription = React.forwardRef<HTMLParagraphElement, React.ComponentProps<"p">>(
  ({ className, ...props }, ref) => {
    return (
      <p
        ref={ref}
        className={cn("text-muted-foreground text-sm [text-wrap:balance]", className)}
        {...props}
      />
    );
  }
);
FieldDescription.displayName = "FieldDescription";

const FieldError = React.forwardRef<
  HTMLDivElement,
  React.ComponentProps<"div"> & {
    errors?: Array<{ message?: string } | string | undefined>;
  }
>(({ className, errors, children, ...props }, ref) => {
  const errorMessages = React.useMemo(() => {
    if (children) return [children];
    if (!errors || errors.length === 0) return [];
    return errors
      .filter(Boolean)
      .map(error => {
        if (typeof error === "string") return error;
        return error?.message;
      })
      .filter(Boolean);
  }, [errors, children]);

  if (errorMessages.length === 0) return null;

  return (
    <div ref={ref} role="alert" className={cn("text-destructive text-sm", className)} {...props}>
      {errorMessages.length === 1 ? (
        <p>{errorMessages[0]}</p>
      ) : (
        <ul className="list-inside list-disc space-y-1">
          {errorMessages.map((message, index) => (
            <li key={index}>{message}</li>
          ))}
        </ul>
      )}
    </div>
  );
});
FieldError.displayName = "FieldError";

const FieldSeparator = React.forwardRef<HTMLDivElement, React.ComponentProps<"div">>(
  ({ className, children, ...props }, ref) => {
    return (
      <div
        ref={ref}
        className={cn(
          "relative flex items-center gap-4",
          "before:border-border before:flex-1 before:border-t",
          "after:border-border after:flex-1 after:border-t",
          className
        )}
        {...props}
      >
        {children && <span className="text-muted-foreground text-xs">{children}</span>}
      </div>
    );
  }
);
FieldSeparator.displayName = "FieldSeparator";

export {
  Field,
  FieldContent,
  FieldDescription,
  FieldError,
  FieldGroup,
  FieldLabel,
  FieldLegend,
  FieldSeparator,
  FieldSet,
};
