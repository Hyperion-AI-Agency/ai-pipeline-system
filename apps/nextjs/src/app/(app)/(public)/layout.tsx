import { ReactNode } from "react";
import { fetchPageTemplate } from "@/actions/fetch-page-template";
import { getLocale } from "next-intl/server";

import { BlocksRenderer } from "@/components/content/blocks-renderer";
import { RefreshRouteOnSave } from "@/components/providers/live-preview-provider";

export default async function PublicLayout({ children }: { children: ReactNode }) {
  const locale = await getLocale();
  const template = await fetchPageTemplate("Default");

  return (
    <div className="min-h-screen">
      <RefreshRouteOnSave />
      {template?.header && Array.isArray(template.header) && template.header.length > 0 && (
        <BlocksRenderer blocks={template.header} locale={locale} />
      )}
      {children}
      {template?.footer && Array.isArray(template.footer) && template.footer.length > 0 && (
        <BlocksRenderer blocks={template.footer} locale={locale} />
      )}
    </div>
  );
}
