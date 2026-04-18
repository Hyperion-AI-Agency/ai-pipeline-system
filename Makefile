.PHONY: help dev up down install migrate test lint clean

help:
	@echo "Commands:"
	@echo "  make dev       Start full local dev environment (install + docker + migrate + dev server)"
	@echo "  make up        Start Docker services only"
	@echo "  make down      Stop Docker services"
	@echo "  make install   Install dependencies (pnpm + poetry)"
	@echo "  make migrate   Run DB migrations"
	@echo "  make test      Run all tests"
	@echo "  make lint      Run linters (ruff + pnpm lint)"
	@echo "  make clean     Remove build artifacts and volumes"

dev: install up migrate
	pnpm dev

up:
	docker compose -f docker-compose.local.yml up -d

down:
	docker compose -f docker-compose.local.yml down

install:
	pnpm install
	cd apps/api && poetry install

migrate:
	cd apps/api && poetry run alembic upgrade head

test:
	cd apps/api && poetry run pytest --tb=short -q
	pnpm test

lint:
	cd apps/api && poetry run ruff check . && poetry run ruff format --check .
	pnpm lint

clean:
	docker compose -f docker-compose.local.yml down -v
	rm -rf node_modules apps/*/node_modules
	find . -type d -name __pycache__ -exec rm -rf {} +
