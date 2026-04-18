import type { NextConfig } from "next";
import { withPayload } from "@payloadcms/next/withPayload";
import { withSentryConfig } from "@sentry/nextjs";
import createNextIntlPlugin from "next-intl/plugin";

// Import env to validate environment variables at build time
import "./src/env.ts";

const nextConfig: NextConfig = {
  output: "standalone",
  productionBrowserSourceMaps: false,
  typescript: {
    ignoreBuildErrors: true,
  },
  eslint: {
    ignoreDuringBuilds: true,
  },
  /** Tree-shake heavy packages: only bundle used exports */
  experimental: {
    optimizePackageImports: [
      "lodash",
      "lucide-react",
      "@radix-ui/react-avatar",
      "@radix-ui/react-dialog",
      "@radix-ui/react-dropdown-menu",
      "@radix-ui/react-label",
      "@radix-ui/react-select",
      "@radix-ui/react-separator",
      "@radix-ui/react-slot",
      "@radix-ui/react-tabs",
      "@radix-ui/react-tooltip",
      "recharts",
      "date-fns",
    ],
  },
  transpilePackages: [
    "@packages/api-client",
    "@packages/analytics",
    "@packages/db",
    "@packages/ui",
    "@packages/validators",
    "@packages/sentry",
  ],
  async rewrites() {
    return [
      {
        source: "/ingest/static/:path*",
        destination: "https://us-assets.i.posthog.com/static/:path*",
      },
      {
        source: "/ingest/:path*",
        destination: "https://us.i.posthog.com/:path*",
      },
      {
        source: "/ingest/decide",
        destination: "https://us.i.posthog.com/decide",
      },
    ];
  },
  images: {
    dangerouslyAllowSVG: true,
    remotePatterns: [
      {
        protocol: "https",
        hostname: "pub-6f0cf05705c7412b93a792350f3b3aa5.r2.dev",
      },
      {
        protocol: "https",
        hostname: "jdj14ctwppwprnqu.public.blob.vercel-storage.com",
      },
      {
        protocol: "https",
        hostname: "images.unsplash.com",
      },
      {
        protocol: "https",
        hostname: "placehold.co",
      },
      {
        protocol: "https",
        hostname: "cdn.prod.website-files.com",
      },
    ],
  },
};

// Wrap with Payload first, then conditionally with Sentry.
// Skip the Sentry webpack plugin entirely when no auth token is present (e.g. Docker build)
// to avoid the significant memory overhead of source map processing.
const withNextIntl = createNextIntlPlugin("./src/lib/i18n/request.ts");
const payloadConfig = withPayload(withNextIntl(nextConfig));

export default process.env.SENTRY_AUTH_TOKEN
  ? withSentryConfig(payloadConfig, {
      org: process.env.SENTRY_ORG,
      project: process.env.SENTRY_PROJECT,
      authToken: process.env.SENTRY_AUTH_TOKEN,
      sourcemaps: {
        deleteSourcemapsAfterUpload: true,
      },
      silent: false,
      telemetry: false,
    })
  : payloadConfig;
