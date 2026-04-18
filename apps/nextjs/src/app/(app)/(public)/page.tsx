import type { Metadata } from "next";
import { fetchPage } from "@/actions/fetch-page";
import { getTranslations } from "next-intl/server";

import { pageMetadata } from "@/lib/seo/metadata";
import { BlocksRenderer } from "@/components/content/blocks-renderer";

/** Avoid static build so CMS content is only used at runtime */
export const dynamic = "force-dynamic";

const HOME_PAGE_SLUG = "home";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const page = await fetchPage({ slug: HOME_PAGE_SLUG, locale });
  const t = await getTranslations({ locale, namespace: "metadata" });

  return pageMetadata({
    locale,
    title: page?.title ?? t("homeTitle"),
    description: t("homeDescription"),
    internalPath: "/",
  });
}

export default async function Home({ params }: { params: Promise<{ locale: string }> }) {
  const { locale } = await params;
  const page = await fetchPage({ slug: HOME_PAGE_SLUG, locale });

  if (!page) {
    return (
      <main className="flex min-h-[60vh] items-center justify-center">
        <p className="text-muted-foreground">Landing page not found. Run seed scripts.</p>
      </main>
    );
  }

  return (
    <main className="w-full">
      <BlocksRenderer blocks={page.layout} locale={locale} />
    </main>
  );
}
