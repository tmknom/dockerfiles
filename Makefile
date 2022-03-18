# This option causes make to display a warning whenever an undefined variable is expanded.
MAKEFLAGS += --warn-undefined-variables

# Disable any builtin pattern rules, then speedup a bit.
MAKEFLAGS += --no-builtin-rules

# If this variable is not set, the program /bin/sh is used as the shell.
SHELL := /bin/bash

# The arguments passed to the shell are taken from the variable .SHELLFLAGS.
#
# The -e flag causes bash with qualifications to exit immediately if a command it executes fails.
# The -u flag causes bash to exit with an error message if a variable is accessed without being defined.
# The -o pipefail option causes bash to exit if any of the commands in a pipeline fail.
# The -c flag is in the default value of .SHELLFLAGS and we must preserve it.
# Because it is how make passes the script to be executed to bash.
.SHELLFLAGS := -eu -o pipefail -c

# Disable any builtin suffix rules, then speedup a bit.
.SUFFIXES:

# Sets the default goal to be used if no targets were specified on the command line.
.DEFAULT_GOAL := help

#
# Variables for the directory path
#
ROOT_DIR ?= $(shell $(GIT) rev-parse --show-toplevel)

#
# Variables to be used by Git and GitHub CLI
#
GIT ?= $(shell \command -v git 2>/dev/null)
GH ?= $(shell \command -v gh 2>/dev/null)

#
# Variables to be used by Docker
#
DOCKER ?= $(shell \command -v docker 2>/dev/null)
DOCKER_WORK_DIR ?= /work
DOCKER_RUN_OPTIONS ?=
DOCKER_RUN_OPTIONS += -it
DOCKER_RUN_OPTIONS += --rm
DOCKER_RUN_OPTIONS += -v $(ROOT_DIR):$(DOCKER_WORK_DIR)
DOCKER_RUN_OPTIONS += -w $(DOCKER_WORK_DIR)
DOCKER_RUN_SECURE_OPTIONS ?=
DOCKER_RUN_SECURE_OPTIONS += --security-opt=no-new-privileges
DOCKER_RUN_SECURE_OPTIONS += --cap-drop all
DOCKER_RUN_SECURE_OPTIONS += --network none
DOCKER_RUN ?= $(DOCKER) run $(DOCKER_RUN_OPTIONS)
SECURE_DOCKER_RUN ?= $(DOCKER_RUN) $(DOCKER_RUN_SECURE_OPTIONS)

#
# Lint
#
.PHONY: lint
lint: lint-markdown lint-yaml lint-shell ## lint all

.PHONY: lint-markdown
lint-markdown: ## lint markdown by markdownlint and prettier
	$(SECURE_DOCKER_RUN) markdownlint --dot --config .markdownlint.yml **/*.md
	$(SECURE_DOCKER_RUN) prettier --check --parser=markdown **/*.md

.PHONY: lint-yaml
lint-yaml: ## lint yaml by yamllint and prettier
	$(SECURE_DOCKER_RUN) yamllint --strict --config-file .yamllint.yml .
	$(SECURE_DOCKER_RUN) prettier --check --parser=yaml **/*.y*ml

.PHONY: lint-shell
lint-shell: ## lint shell by shellcheck and shfmt
	$(SECURE_DOCKER_RUN) koalaman/shellcheck:stable **/*.sh
	$(SECURE_DOCKER_RUN) mvdan/shfmt -i 2 -ci -bn -d **/*.sh

#
# Format code
#
.PHONY: format
format: format-markdown format-yaml format-shell ## format all

.PHONY: format-markdown
format-markdown: ## format markdown by prettier
	$(SECURE_DOCKER_RUN) prettier --write --parser=markdown **/*.md

.PHONY: format-yaml
format-yaml: ## format yaml by prettier
	$(SECURE_DOCKER_RUN) prettier --write --parser=yaml **/*.y*ml

.PHONY: format-shell
format-shell: ## format shell by shfmt
	$(SECURE_DOCKER_RUN) mvdan/shfmt -i 2 -ci -bn -w **/*.sh

#
# Release management
#
release: ## release
	version="v$$(cat VERSION)" && \
	major_version=$$(echo "$${version%%.*}") && \
	$(GIT) tag --force --message "$${version}" "$${version}" && \
	$(GIT) tag --force --message "$${version}" "$${major_version}" && \
	$(GIT) push --force origin "$${version}" && \
	$(GIT) push --force origin "$${major_version}"

bump: input-version commit create-pr ## bump version

input-version:
	@echo "Current version: $$(cat VERSION)" && \
	read -rp "Input next version: " version && \
	echo "$${version}" > VERSION

commit:
	version="v$$(cat VERSION)" && \
	$(GIT) switch -c "bump-$${version}" && \
	$(GIT) add VERSION && \
	$(GIT) commit -m "Bump up to $${version}"

create-pr:
	version="v$$(cat VERSION)" && \
	$(GIT) push origin $$($(GIT) rev-parse --abbrev-ref HEAD) && \
	$(GH) pr create --title "Bump up to $${version}" --body "" --web

#
# Help
#
.PHONY: help
help: ## show help
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
