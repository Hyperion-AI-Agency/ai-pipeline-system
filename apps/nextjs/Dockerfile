# syntax=docker.io/docker/dockerfile:1

FROM node:20-slim AS base
WORKDIR /app

# ---
# Prepare stage: prune the monorepo to just the app
FROM base AS prepare
RUN npm install -g turbo
COPY . .
RUN turbo prune nextjs --docker

# ---
# Builder stage: install dependencies and build
FROM base AS builder
COPY --from=prepare /app/out/json/ .
RUN corepack enable pnpm && pnpm install
COPY --from=prepare /app/out/full/ .

# Build with reduced disk usage
ENV NEXT_TELEMETRY_DISABLED=1
ENV TURBO_TELEMETRY_DISABLED=1
ENV TURBO_FORCE=true
ENV SKIP_ENV_VALIDATION=true
ENV NODE_OPTIONS="--max-old-space-size=3072"
ENV SENTRY_SUPPRESS_GLOBAL_ERROR_HANDLER_FILE_WARNING=1

# NEXT_PUBLIC_ vars are inlined at build time — pass them as build args
ARG NEXT_PUBLIC_APP_URL
ARG NEXT_PUBLIC_PAYLOAD_URL
ARG NEXT_PUBLIC_BACKEND_API_URL
ARG NEXT_PUBLIC_COPILOTKIT_PUBLIC_LICENSE_KEY
ARG NEXT_PUBLIC_SIGNUP_ENABLED=false
ARG NEXT_PUBLIC_APP_UNDER_DEVELOPMENT=false
ARG NEXT_PUBLIC_REQUIRE_EMAIL_VERIFICATION
ARG NEXT_PUBLIC_ALL_LOCALES=lt,en
ARG NEXT_PUBLIC_DEFAULT_LOCALE=lt
ARG NEXT_PUBLIC_SENTRY_DSN
ARG NEXT_PUBLIC_POSTHOG_KEY
ARG NEXT_PUBLIC_POSTHOG_HOST
ARG NEXT_PUBLIC_COOKIEKIT_ID
ARG NEXT_PUBLIC_CONTACT_URL
RUN pnpm exec turbo build && \
    rm -rf apps/nextjs/.next/cache .turbo apps/nextjs/.turbo

# ---
# Seeder stage: full environment for DB migrations and content seed scripts
# Usage: docker run <image> [migrate|seed-admin|seed-content|seed-legal|seed-blog|seed-all|all]
FROM builder AS seeder
WORKDIR /app
RUN chmod +x ./apps/nextjs/docker-entrypoint.sh
ENTRYPOINT ["./apps/nextjs/docker-entrypoint.sh"]
CMD ["all"]

# ---
# Runner stage: minimal production image
FROM node:20-slim AS runner

# Create non-root user
RUN groupadd --system --gid 1001 nodejs && \
    useradd --system --uid 1001 nextjs

# curl for healthcheck
RUN apt-get update && apt-get install -y --no-install-recommends curl && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy Next.js standalone output
COPY --from=builder --chown=nextjs:nodejs /app/apps/nextjs/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/apps/nextjs/.next/static ./apps/nextjs/.next/static
COPY --from=builder --chown=nextjs:nodejs /app/apps/nextjs/public ./apps/nextjs/public

# Copy node_modules from builder (native deps like sharp)
COPY --from=builder --chown=nextjs:nodejs /app/node_modules ./node_modules
COPY --from=builder --chown=nextjs:nodejs /app/apps/nextjs/node_modules ./apps/nextjs/node_modules

USER nextjs

EXPOSE 3000

ENV HOSTNAME=0.0.0.0
ENV PORT=3000

CMD ["node", "apps/nextjs/server.js"]
