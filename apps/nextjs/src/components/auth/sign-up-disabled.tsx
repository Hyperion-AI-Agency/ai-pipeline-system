import { Wrench } from "lucide-react";
import { useTranslations } from "next-intl";

export function SignUpDisabled() {
  const t = useTranslations("auth.signUp.disabled");

  return (
    <div className="w-full max-w-md">
      <div className="mb-8 text-center">
        <div className="bg-primary/10 mb-4 inline-flex h-16 w-16 items-center justify-center rounded-full">
          <Wrench className="text-primary h-8 w-8" />
        </div>
        <h1 className="mb-2 text-2xl font-semibold">{t("title")}</h1>
        <p className="text-muted-foreground text-sm">{t("description")}</p>
      </div>
    </div>
  );
}
