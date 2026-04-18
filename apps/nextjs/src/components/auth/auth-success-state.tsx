import Link from "next/link";
import { Check, Mail } from "lucide-react";

import { Button } from "@/components/ui/button";

interface AuthSuccessStateProps {
  icon?: "mail" | "check";
  title: string;
  description: string;
  buttonText?: string;
  buttonHref?: string;
  email?: string;
}

export function AuthSuccessState({
  icon = "mail",
  title,
  description,
  buttonText,
  buttonHref,
  email,
}: AuthSuccessStateProps) {
  const IconComponent = icon === "check" ? Check : Mail;
  const iconColor = icon === "check" ? "text-green-500" : "text-primary";
  const iconBg = icon === "check" ? "bg-green-500/10" : "bg-primary/10";

  return (
    <div className="w-full max-w-md">
      <div className="mb-8 text-center">
        <div
          className={`${iconBg} mb-4 inline-flex h-16 w-16 items-center justify-center rounded-full`}
        >
          <IconComponent className={`${iconColor} h-8 w-8`} />
        </div>
        <h1 className="mb-2 text-2xl font-semibold">{title}</h1>
        <p className="text-muted-foreground text-sm">{description}</p>
        {email && <p className="text-muted-foreground mt-2 text-sm font-medium">{email}</p>}
      </div>

      {buttonText && buttonHref && (
        <div className="mt-6 text-center">
          <Button
            variant={icon === "check" ? "default" : "link"}
            className={icon === "check" ? "" : "h-auto p-0"}
            asChild
          >
            <Link href={buttonHref as any}>{buttonText}</Link>
          </Button>
        </div>
      )}
    </div>
  );
}
