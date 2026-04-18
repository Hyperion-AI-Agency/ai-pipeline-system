# Legacy System Reference

The `legacy/` directory contains the original MatchedPro betting signals system. This code runs on a VPS with systemd services and cron jobs. It serves as reference for the new implementation.

## Components

| Component | Purpose | New App Equivalent |
|-----------|---------|-------------------|
| `signal-bot/` | Telegram signal bot, bet tracker, admin dashboard | FastAPI endpoints + Next.js dashboard |
| `tick-scanner/` | Live odds tick scanner (Betfair + The Odds API) | Celery background tasks |
| `oc-confirm/` | Oddschecker odds confirmation (browser automation) | Celery tasks + headless browser |
| `oc-confirm-signals/` | Hourly dedup for signal bot | Celery periodic tasks |
| `oc-rechecker/` | Re-verifies live signals every 3 mins | Celery beat scheduler |
| `signal-bot-admin/` | Simple HTML admin panel | Next.js dashboard |
| `root-scripts/` | Cron jobs: monitoring, reports, healthchecks | Celery beat + API endpoints |

## Data Flow (Original)

```
Betfair/Odds API → tick-scanner → signal detection
                                       ↓
                              oc-confirm (browser check)
                                       ↓
                              signal-bot (Telegram alert)
                                       ↓
                              oc-rechecker (re-verify every 3min)
```

## Key Integrations

- **Betfair API** — live odds data, BSP (Starting Price) data
- **The Odds API** — multi-bookmaker odds comparison
- **Oddschecker** — browser-based odds scraping via AdsPower
- **Telegram Bot API** — signal delivery to subscribers
- **Whop** — subscription management + webhooks

## Notes

- All secrets have been scrubbed from legacy code (replaced with env var lookups)
- The `.env` files are gitignored
- `debug_last_failure.html` files are gitignored (debug artifacts)
