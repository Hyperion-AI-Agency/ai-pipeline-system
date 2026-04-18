#!/usr/bin/env bash
set -e

# ── Functions ─────────────────────────────────────────────────────────────────

migrate() {
  echo "Running database migrations..."
  pnpm --filter app db:migrate
}

seed_admin() {
  echo "Seeding admin user..."
  pnpm --filter app db:seed-admin
}

seed_content() {
  echo "Seeding CMS content (navbar, footer, plans, homepage, blog page)..."
  pnpm --filter app db:seed-content
}

seed_legal() {
  echo "Seeding legal pages..."
  pnpm --filter app db:seed-legal
}

seed_blog() {
  echo "Seeding blog posts..."
  pnpm --filter app db:seed-blog
}

seed_templates() {
  echo "Seeding page templates (navbar, footer)..."
  pnpm --filter app db:seed-templates
}

seed_landing() {
  echo "Seeding landing page..."
  pnpm --filter app db:seed-landing
}

seed_all() {
  seed_admin
  seed_content
  seed_templates
  seed_landing
  seed_legal
  seed_blog
}

run_all() {
  migrate
  seed_all
}

# ── Command dispatch ──────────────────────────────────────────────────────────

case "${1:-all}" in
  migrate)      migrate ;;
  seed-admin)   seed_admin ;;
  seed-content) seed_content ;;
  seed-legal)   seed_legal ;;
  seed-blog)    seed_blog ;;
  seed-landing)   seed_landing ;;
  seed-templates) seed_templates ;;
  seed-all)       seed_all ;;
  all)          run_all ;;
  *)
    echo "Unknown command: $1"
    echo "Usage: docker-entrypoint.sh [command]"
    echo ""
    echo "Commands:"
    echo "  all           Run migrations + all seeds (default)"
    echo "  migrate       Run database migrations only"
    echo "  seed-admin    Seed admin user"
    echo "  seed-content  Seed navbar, footer, plans, homepage, blog page"
    echo "  seed-legal    Seed legal pages (terms, privacy, cookies)"
    echo "  seed-templates Seed page templates (navbar, footer)"
    echo "  seed-landing  Seed landing page"
    echo "  seed-blog     Seed blog posts"
    echo "  seed-all      Run all seeds (no migrations)"
    exit 1
    ;;
esac

echo "Done."
