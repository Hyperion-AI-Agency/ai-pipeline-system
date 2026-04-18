#!/usr/bin/env bash
set -e

migrate() {
  echo "Running database migrations..."
  alembic upgrade head
}

start() {
  echo "Starting FastAPI server..."
  exec poetry run start
}

celery_worker() {
  echo "Starting Celery worker..."
  exec poetry run celery-worker
}

case "${1:-start}" in
  migrate)       migrate ;;
  start)         migrate && start ;;
  celery-worker) celery_worker ;;
  *)
    echo "Unknown command: $1"
    echo "Usage: docker-entrypoint.sh [start|migrate|celery-worker]"
    exit 1
    ;;
esac
