import { processSubscriptionWebhook } from "@/actions/process-subscription-webhook";
import { sendPasswordResetEmail } from "@/actions/send-password-reset-email";
import { sendVerificationEmail } from "@/actions/send-verification-email";
import { env } from "@/env";
import { db } from "@/server/db/drizzle";
import {
  jwks,
  oauth_access_token,
  oauth_application,
  oauth_consent,
  user_accounts,
  user_sessions,
  user_verifications,
  users,
} from "@/server/db/schemas/payload-schema";
import { checkout, polar, portal, usage, webhooks } from "@polar-sh/better-auth";
import { Polar } from "@polar-sh/sdk";
import { betterAuth, User } from "better-auth";
import { drizzleAdapter } from "better-auth/adapters/drizzle";
import { nextCookies } from "better-auth/next-js";
import { jwt, oidcProvider } from "better-auth/plugins";
import { admin } from "better-auth/plugins/admin";

const polarClient = new Polar({
  accessToken: env.POLAR_ACCESS_TOKEN,
  server: env.POLAR_ENVIRONMENT,
});

export const auth = betterAuth({
  baseURL: env.NEXT_PUBLIC_APP_URL,
  secret: env.BETTER_AUTH_SECRET,
  trustedOrigins: [env.NEXT_PUBLIC_APP_URL],
  allowedDevOrigins: [env.NEXT_PUBLIC_APP_URL],
  cookieCache: {
    enabled: true,
    maxAge: 5 * 60, // Cache duration in seconds
  },
  // /token enabled for authClient.token() (JWT); OIDC uses /oauth2/token
  disabledPaths: [],
  authenticatedUsersOnly: true,
  database: drizzleAdapter(db, {
    provider: "pg",
    schema: {
      users,
      user_accounts,
      user_sessions,
      user_verifications,
      oauthApplication: oauth_application,
      oauthAccessToken: oauth_access_token,
      oauthConsent: oauth_consent,
      jwks,
    },
    usePlural: false,
  }),
  advanced: {
    database: {
      generateId: false, // Should be false since we'll let Payload generate the ids
    },
  },
  user: {
    modelName: "users",
  },
  account: {
    modelName: "user_accounts",
    accountLinking: {
      allowDifferentEmails: true,
      enabled: true,
    },
  },
  session: {
    modelName: "user_sessions",
  },
  verification: {
    modelName: "user_verifications",
  },
  socialProviders: {
    google: {
      clientId: env.GOOGLE_CLIENT_ID,
      clientSecret: env.GOOGLE_CLIENT_SECRET,
    },
  },
  emailAndPassword: {
    requireEmailVerification: env.REQUIRE_EMAIL_VERIFICATION ?? false,
    enabled: true,
    disableSignUp: env.DISABLE_SIGNUP ?? false,
    sendResetPassword: async ({ user, url, token }, request) => {
      await sendPasswordResetEmail({
        to: user.email,
        url: url,
        callbackURL: "/reset-password",
      });
    },
  },
  emailVerification: {
    sendOnSignUp: true,
    autoSignInAfterVerification: true,
    sendVerificationEmail: async ({ user, url, token }, request) => {
      await sendVerificationEmail({
        to: user.email,
        url: url,
        callbackURL: "/new",
      });
    },
  },
  plugins: [
    admin(),
    jwt({
      disableSettingJwtHeader: true,
      jwt: {
        issuer: env.NEXT_PUBLIC_APP_URL,
        audience: env.NEXT_PUBLIC_APP_URL,
      },
    }),
    oidcProvider({
      useJWTPlugin: true,
      trustedClients: [
        {
          clientId: env.FASTAPI_OAUTH_CLIENT_ID,
          clientSecret: env.FASTAPI_OAUTH_CLIENT_SECRET,
          type: "web",
          name: "FastAPI Backend",
          redirectURLs: [`${env.BACKEND_API_URL}/auth/callback`],
          disabled: false,
          skipConsent: true, // Skip consent for trusted backend service
          metadata: null,
        },
      ],
      loginPage: `${env.NEXT_PUBLIC_APP_URL}/sign-in`,
    }),
    polar({
      client: polarClient,
      createCustomerOnSignUp: true,
      user: {
        deleteUser: {
          enabled: true,
          afterDelete: async (user: User, request: Request) => {
            await polarClient.customers.deleteExternal({
              externalId: user.id,
            });
          },
        },
      },
      use: [
        checkout({
          successUrl: `${env.NEXT_PUBLIC_APP_URL}/${env.POLAR_SUCCESS_URL}`,
          authenticatedUsersOnly: true,
          returnUrl: `${env.NEXT_PUBLIC_APP_URL}/new`,
          // Theme will be read from cookies in the API route handler
          // Better Auth's checkout plugin doesn't support dynamic theme, so we use "light" as default
          // The actual theme will be determined by reading cookies in the checkout API route
          theme: "light",
        }),
        portal({
          returnUrl: `${env.NEXT_PUBLIC_APP_URL}`,
        }),
        usage(),
        webhooks({
          secret: env.POLAR_WEBHOOK_SECRET,
          onPayload: async ({ data, type }) => {
            await processSubscriptionWebhook(data, type);
          },
        }),
      ],
    }),
    nextCookies(),
  ],
});
