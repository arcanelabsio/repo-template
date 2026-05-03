# Makefile — {{REPO_NAME}}
#
# Top-level wrapper around the project's package manager / build tool.
# Local-dev ergonomics: `make setup`, `make dev`, `make test`, `make check`, `make build`.
# Replace placeholder commands with the real ones during SETUP.md step 4.

.PHONY: help setup dev test check lint fmt build release clean state

help:  ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | sort | awk -F':.*## ' '{printf "  %-12s %s\n", $$1, $$2}'

setup:  ## Install deps; one-time after clone
	@echo "TODO: replace with real setup command (e.g., flutter pub get / npm i / cargo fetch / go mod download)"

dev:  ## Run the app locally with hot reload (where applicable)
	@echo "TODO: replace with real dev command"

test:  ## Run unit + integration tests
	@echo "TODO: replace with real test command"

check: fmt lint test  ## fmt + lint + test — pre-commit gate

lint:  ## Static analysis
	@echo "TODO: replace with real lint command"

fmt:  ## Auto-format
	@echo "TODO: replace with real formatter"

build:  ## Build release artifact
	@echo "TODO: replace with real build command"

release:  ## Tag + push; CI builds + publishes
	@./scripts/release.sh

clean:  ## Remove build artifacts and caches
	@rm -rf dist build node_modules .cache target

state:  ## Update STATE.md with last commit + status
	@echo "Last commit: $$(git log -1 --format='%h — %s — %cd' --date=short)"
	@echo "Branch: $$(git rev-parse --abbrev-ref HEAD)"
	@echo "(Edit STATE.md manually — automation hook is intentionally light.)"
