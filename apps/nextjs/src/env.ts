import { createEnv } from "@t3-oss/env-nextjs";
import { z } from "zod";
import { env as analyticsEnv } from "@packages/analytics/env";
import { env as apiClientEnv } from "@packages/api-client/env";
import { env as sentryEnv } from "@packages/sentry/env";

export const env = createEnv({
  extends: [sentryEnv, analyticsEnv, apiClientEnv],

  server: {
    // Database
    DATABASE_URL: z.string().url(),

    // Backend API (server-side, for SSR calls)
    BACKEND_API_URL: z.string().url().default("http://localhost:8000"),

    // Payload
    PAYLOAD_SECRET: z.string().min(1),
    ADMIN_EMAIL: z.string().email().default("admin@example.com"),
    ADMIN_PASSWORD: z.string().min(6).default("admin"),

    // Polar
    POLAR_ACCESS_TOKEN: z.string().min(1),
    POLAR_WEBHOOK_SECRET: z.string().min(1),
    POLAR_SUCCESS_URL: z.string().min(1),
    POLAR_ENVIRONMENT: z.enum(["sandbox", "production"]).default("sandbox"),
    POLAR_PRODUCT_KEY_REGULAR: z.string().optional(),
    POLAR_PRODUCT_KEY_HR: z.string().optional(),

    // Social Login
    GOOGLE_CLIENT_ID: z.string().min(1),
    GOOGLE_CLIENT_SECRET: z.string().min(1),

    // OAuth Provider (for FastAPI backend)
    FASTAPI_OAUTH_CLIENT_ID: z.string().min(1),
    FASTAPI_OAUTH_CLIENT_SECRET: z.string().min(1),

    // Email
    RESEND_API_KEY: z.string(),
    RESEND_FROM: z.string(),

    // Port
    PORT: z.coerce.number().default(3000),

    // Node Environment
    NODE_ENV: z.enum(["development", "test", "production"]).default("development"),

    // Sentry (optional — only needed for source map upload at build time)
    SENTRY_AUTH_TOKEN: z.string().min(1).optional(),

    /** Better Auth: signing/encryption (min 32 chars; optional at build when SKIP_ENV_VALIDATION). */
    BETTER_AUTH_SECRET: z.string().min(32).optional(),

    /** When true, Better Auth will reject sign-up (email/password and possibly social). Default false. */
    DISABLE_SIGNUP: z
      .string()
      .optional()
      .transform(v => v === "true"),

    /** When true, require email verification before sign-in; redirect to verify-email when not verified. Default false. */
    REQUIRE_EMAIL_VERIFICATION: z
      .string()
      .optional()
      .transform(v => v === "true"),

    PUBLIC_APP_URL: z.string().url(),
  },

  client: {
    // App URLs
    NEXT_PUBLIC_APP_URL: z.string().url(),
    NEXT_PUBLIC_PAYLOAD_URL: z.string().url(),
    NEXT_PUBLIC_NODE_ENV: z.enum(["development", "test", "production"]).default("development"),

    // CopilotKit
    NEXT_PUBLIC_COPILOTKIT_PUBLIC_LICENSE_KEY: z.string(),

    // Contact & Services
    NEXT_PUBLIC_CONTACT_URL: z.string().url().optional(),
    NEXT_PUBLIC_COOKIEKIT_ID: z.string().optional(),

    // Feature Flags
    NEXT_PUBLIC_SIGNUP_ENABLED: z.boolean().default(false),
    NEXT_PUBLIC_APP_UNDER_DEVELOPMENT: z.boolean().default(false),
    NEXT_PUBLIC_PAYWALL_ENABLED: z.boolean().default(true),
    NEXT_PUBLIC_REQUIRE_EMAIL_VERIFICATION: z
      .string()
      .optional()
      .transform(v => v === "true"),

    // i18n
    NEXT_PUBLIC_ALL_LOCALES: z
      .string()
      .default("lt,en")
      .transform(str => str.split(",").map(s => s.trim())),
    NEXT_PUBLIC_DEFAULT_LOCALE: z.enum(["lt", "en"]).default("lt"),
  },

  runtimeEnv: {
    // Server vars: prefer APP_ prefix (e.g. Docker), fallback to unprefixed (local dev)
    DATABASE_URL: process.env.APP_DATABASE_URL,

    // CMS
    PAYLOAD_SECRET: process.env.APP_PAYLOAD_SECRET,

    // Admin
    ADMIN_EMAIL: process.env.APP_ADMIN_EMAIL,
    ADMIN_PASSWORD: process.env.APP_ADMIN_PASSWORD,

    // Subscriptions
    POLAR_ACCESS_TOKEN: process.env.APP_POLAR_ACCESS_TOKEN,
    POLAR_WEBHOOK_SECRET: process.env.APP_POLAR_WEBHOOK_SECRET,
    POLAR_SUCCESS_URL: process.env.APP_POLAR_SUCCESS_URL,
    POLAR_ENVIRONMENT: process.env.APP_POLAR_ENVIRONMENT,

    GOOGLE_CLIENT_ID: process.env.APP_GOOGLE_CLIENT_ID,
    GOOGLE_CLIENT_SECRET: process.env.APP_GOOGLE_CLIENT_SECRET,

    // FastAPI
    BACKEND_API_URL: process.env.APP_BACKEND_API_URL,

    // Secure OAuth Provider (for FastAPI backend)
    FASTAPI_OAUTH_CLIENT_ID: process.env.APP_FASTAPI_OAUTH_CLIENT_ID,
    FASTAPI_OAUTH_CLIENT_SECRET: process.env.APP_FASTAPI_OAUTH_CLIENT_SECRET,

    // Email
    RESEND_API_KEY: process.env.APP_RESEND_API_KEY,
    RESEND_FROM: process.env.APP_RESEND_FROM,

    // Auth
    BETTER_AUTH_SECRET: process.env.APP_BETTER_AUTH_SECRET,

    NEXT_PUBLIC_COPILOTKIT_PUBLIC_LICENSE_KEY:
      process.env.NEXT_PUBLIC_COPILOTKIT_PUBLIC_LICENSE_KEY,

    // App & Node
    PORT: process.env.PORT,
    NODE_ENV: process.env.NODE_ENV,
    NEXT_PUBLIC_NODE_ENV: process.env.NODE_ENV,

    // App URLs
    NEXT_PUBLIC_APP_URL: process.env.NEXT_PUBLIC_APP_URL,
    PUBLIC_APP_URL: process.env.NEXT_PUBLIC_APP_URL,
    NEXT_PUBLIC_PAYLOAD_URL: process.env.NEXT_PUBLIC_PAYLOAD_URL,

    // CookieKit
    NEXT_PUBLIC_COOKIEKIT_ID: process.env.NEXT_PUBLIC_COOKIEKIT_ID,
    NEXT_PUBLIC_CONTACT_URL: process.env.NEXT_PUBLIC_CONTACT_URL,

    // Feature Flags
    NEXT_PUBLIC_SIGNUP_ENABLED: process.env.NEXT_PUBLIC_SIGNUP_ENABLED === "true",
    NEXT_PUBLIC_APP_UNDER_DEVELOPMENT: process.env.NEXT_PUBLIC_APP_UNDER_DEVELOPMENT === "true",
    NEXT_PUBLIC_PAYWALL_ENABLED: process.env.NEXT_PUBLIC_PAYWALL_ENABLED !== "false",
    NEXT_PUBLIC_REQUIRE_EMAIL_VERIFICATION: process.env.NEXT_PUBLIC_REQUIRE_EMAIL_VERIFICATION,
    DISABLE_SIGNUP: process.env.APP_DISABLE_SIGNUP,
    REQUIRE_EMAIL_VERIFICATION: process.env.APP_REQUIRE_EMAIL_VERIFICATION,

    // i18n (comma-separated locale codes, e.g. "lt,en")
    NEXT_PUBLIC_ALL_LOCALES: process.env.NEXT_PUBLIC_ALL_LOCALES,
    NEXT_PUBLIC_DEFAULT_LOCALE: process.env.NEXT_PUBLIC_DEFAULT_LOCALE,

    // Sentry
    SENTRY_AUTH_TOKEN: process.env.SENTRY_AUTH_TOKEN,
  },

  skipValidation: !!process.env.SKIP_ENV_VALIDATION,
  emptyStringAsUndefined: true,
});
