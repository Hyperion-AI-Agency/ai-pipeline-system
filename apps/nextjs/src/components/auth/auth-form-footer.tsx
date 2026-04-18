import Link from "next/link";

import { Button } from "@/components/ui/button";

interface AuthFormFooterProps {
  text: string;
  linkText: string;
  linkHref: string;
}

export function AuthFormFooter({ text, linkText, linkHref }: AuthFormFooterProps) {
  return (
    <div className="text-muted-foreground mt-6 text-sm">
      {text}{" "}
      <Button variant="link" className="h-auto p-0" asChild>
        <Link href={linkHref as any}>{linkText}</Link>
      </Button>
    </div>
  );
}
