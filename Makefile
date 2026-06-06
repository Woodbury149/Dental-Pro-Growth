.PHONY: help setup start stop restart logs clean

# Colors for output
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[0;33m
NC := \033[0m # No Color

help:
	@echo "$(GREEN)Dental Pro Growth - Development Commands$(NC)"
	@echo ""
	@echo "$(YELLOW)Setup:$(NC)"
	@echo "  make setup      - Initial setup (clone, install, env)"
	@echo "  make init       - Initialize Docker services"
	@echo ""
	@echo "$(YELLOW)Running:$(NC)"
	@echo "  make start      - Start all services"
	@echo "  make stop       - Stop all services"
	@echo "  make restart    - Restart all services"
	@echo "  make rebuild    - Rebuild and start"
	@echo ""
	@echo "$(YELLOW)Monitoring:$(NC)"
	@echo "  make logs       - View logs (all services)"
	@echo "  make logs-api   - View backend logs"
	@echo "  make logs-db    - View database logs"
	@echo ""
	@echo "$(YELLOW)Development:$(NC)"
	@echo "  make dev        - Start backend + frontend dev servers"
	@echo "  make test       - Run tests"
	@echo "  make lint       - Run linter"
	@echo "  make lint-fix   - Fix linting issues"
	@echo ""
	@echo "$(YELLOW)Database:$(NC)"
	@echo "  make db-shell   - Open MongoDB shell"
	@echo "  make redis-cli  - Open Redis CLI"
	@echo ""
	@echo "$(YELLOW)Cleanup:$(NC)"
	@echo "  make clean      - Stop and remove containers"
	@echo "  make clean-all  - Remove everything (including volumes)"

# Setup
setup:
	@echo "$(GREEN)Setting up Dental Pro Growth...$(NC)"
	@git clone https://github.com/Woodbury149/Dental-Pro-Growth.git 2>/dev/null || true
	@cp .env.example .env.local
	@npm install
	@cd frontend && npm install && cd ..
	@echo "$(GREEN)✓ Setup complete!$(NC)"

init:
	@echo "$(GREEN)Initializing Docker services...$(NC)"
	docker-compose up -d
	@echo "$(GREEN)✓ Services ready!$(NC)"

# Running
start:
	@echo "$(GREEN)Starting services...$(NC)"
	docker-compose up -d
	@echo "$(GREEN)✓ Services started!$(NC)"

stop:
	@echo "$(YELLOW)Stopping services...$(NC)"
	docker-compose stop
	@echo "$(GREEN)✓ Services stopped!$(NC)"

restart: stop start
	@echo "$(GREEN)✓ Services restarted!$(NC)"

rebuild:
	@echo "$(GREEN)Rebuilding and starting...$(NC)"
	docker-compose up -d --build
	@echo "$(GREEN)✓ Services rebuilt and running!$(NC)"

# Monitoring
logs:
	@docker-compose logs -f

logs-api:
	@docker-compose logs -f backend

logs-db:
	@docker-compose logs -f mongodb

# Development
dev:
	@echo "$(GREEN)Starting development servers...$(NC)"
	npm run dev

test:
	@echo "$(GREEN)Running tests...$(NC)"
	npm test

lint:
	@echo "$(GREEN)Running linter...$(NC)"
	npm run lint

lint-fix:
	@echo "$(GREEN)Fixing lint issues...$(NC)"
	npm run lint:fix

# Database
db-shell:
	docker-compose exec mongodb mongosh

redis-cli:
	docker-compose exec redis redis-cli

# Cleanup
clean:
	@echo "$(YELLOW)Removing containers...$(NC)"
	docker-compose down
	@echo "$(GREEN)✓ Cleaned up!$(NC)"

clean-all:
	@echo "$(RED)Removing everything (including data)...$(NC)"
	docker-compose down -v
	@echo "$(GREEN)✓ Full cleanup complete!$(NC)"

.DEFAULT_GOAL := help
