import Link from "next/link";
import { getLocale, getTranslations } from "next-intl/server";

export default async function RootNotFound() {
  const locale = await getLocale();
  const t = await getTranslations({ locale, namespace: "common" });

  return (
    <html lang={locale}>
      <body
        style={{
          margin: 0,
          overflow: "hidden",
          fontFamily:
            "'THICCCBOI', -apple-system, BlinkMacSystemFont, 'Helvetica Neue', sans-serif",
          backgroundColor: "#ffffff",
          color: "#0b1f3a",
        }}
      >
        <div
          style={{
            position: "fixed",
            inset: 0,
            display: "flex",
            flexDirection: "column",
            alignItems: "center",
            justifyContent: "center",
            padding: "2rem",
            textAlign: "center" as const,
          }}
        >
          <p
            style={{
              fontSize: "clamp(6rem, 15vw, 12rem)",
              fontWeight: 900,
              lineHeight: 1,
              margin: 0,
              color: "#0b1f3a",
            }}
          >
            404
          </p>
          <h1 style={{ fontSize: "1.75rem", fontWeight: 600, margin: "0.5rem 0 0" }}>
            {t("pageNotFound")}
          </h1>
          <p style={{ marginTop: "0.75rem", color: "#6b7280", maxWidth: "400px" }}>
            {t("pageNotFoundDescription")}
          </p>
          <Link
            href={`/${locale}`}
            style={{
              marginTop: "2rem",
              display: "inline-flex",
              alignItems: "center",
              gap: "0.5rem",
              padding: "0.75rem 1.5rem",
              borderRadius: "10px",
              border: "none",
              backgroundColor: "#1e4a70",
              color: "#ffffff",
              fontFamily: "inherit",
              fontSize: "0.875rem",
              fontWeight: 500,
              textDecoration: "none",
              cursor: "pointer",
            }}
          >
            &larr; {t("goHome")}
          </Link>
        </div>
      </body>
    </html>
  );
}
