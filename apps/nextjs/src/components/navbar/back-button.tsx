"use client";

import Link from "next/link";
import { ArrowLeft } from "lucide-react";
import { useTranslations } from "next-intl";

import { Button } from "@/components/ui/button";

export function BackButton() {
  const t = useTranslations("common");

  return (
    <Button variant="ghost" size="sm" asChild>
      <Link href="/">
        <ArrowLeft className="mr-2 h-4 w-4" />
        {t("back")}
      </Link>
    </Button>
  );
}
