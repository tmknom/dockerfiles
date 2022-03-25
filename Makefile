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
# Variables for the file and directory path
#
ROOT_DIR ?= $(shell $(GIT) rev-parse --show-toplevel)
DOCKERFILE_FILES ?= $(shell find . -name Dockerfile)
MARKDOWN_FILES ?= $(shell find . -name '*.md')
YAML_FILES ?= $(shell find . -name '*.y*ml')
SHELL_FILES ?= $(shell find . -name '*.sh')
JSON_FILES ?= $(shell find . -name '*.json')

#
# Variables to be used by Git and GitHub CLI
#
GIT ?= $(shell \command -v git 2>/dev/null)
GH ?= $(shell \command -v gh 2>/dev/null)
GIT_EXCLUDE_FILES ?= ':!*.md' ':!Makefile' ':!.github/*'

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
DOCKER_RUN_SECURE_OPTIONS += --user 1111:1111
DOCKER_RUN_SECURE_OPTIONS += --read-only
DOCKER_RUN_SECURE_OPTIONS += --security-opt no-new-privileges
DOCKER_RUN_SECURE_OPTIONS += --cap-drop all
DOCKER_RUN_SECURE_OPTIONS += --network none
DOCKER_RUN ?= $(DOCKER) run $(DOCKER_RUN_OPTIONS)
SECURE_DOCKER_RUN ?= $(DOCKER_RUN) $(DOCKER_RUN_SECURE_OPTIONS)
DOCKER_PULL ?= $(DOCKER) pull
DOCKER_RMI ?= $(DOCKER) rmi

#
# Variables for the image name
#
REGISTRY ?= ghcr.io/tmknom/dockerfiles
HADOLINT ?= hadolint/hadolint:latest
DOCKERFILELINT ?= replicated/dockerfilelint:latest
PRETTIER ?= $(REGISTRY)/prettier:latest
MARKDOWNLINT ?= $(REGISTRY)/markdownlint:latest
YAMLLINT ?= $(REGISTRY)/yamllint:latest
ACTIONLINT ?= rhysd/actionlint:latest
SHELLCHECK ?= koalaman/shellcheck:stable
SHFMT ?= mvdan/shfmt:latest
JSONLINT ?= $(REGISTRY)/jsonlint:latest

#
# Variables for the version
#
VERSION ?= $(shell \cat VERSION)
SEMVER ?= "v$(VERSION)"
MAJOR_VERSION ?= $(shell version=$(SEMVER) && echo "$${version%%.*}")

#
# All
#
.PHONY: all
all: install lint test clean ## all

#
# Install dependencies
#
.PHONY: install
install: ## install docker images
	$(DOCKER_PULL) $(HADOLINT)
	$(DOCKER_PULL) $(DOCKERFILELINT)
	$(DOCKER_PULL) $(PRETTIER)
	$(DOCKER_PULL) $(MARKDOWNLINT)
	$(DOCKER_PULL) $(YAMLLINT)
	$(DOCKER_PULL) $(ACTIONLINT)
	$(DOCKER_PULL) $(SHELLCHECK)
	$(DOCKER_PULL) $(SHFMT)
	$(DOCKER_PULL) $(JSONLINT)
	$(DOCKER_PULL) $(DOCKERFILELINT)

#
# Test
#
.PHONY: test
test: prepare-test test-prettier test-markdownlint test-yamllint test-jsonlint ## test all

prepare-test: clean pull-base-image

pull-base-image:
	$(DOCKER_PULL) node:16-alpine3.15
	$(DOCKER_PULL) python:3.10-alpine3.15

.PHONY: test-prettier
test-prettier:
	$(DOCKER_PULL) tmknom/prettier
	$(DOCKER_PULL) ghcr.io/tmknom/dockerfiles/prettier
	$(SECURE_DOCKER_RUN) tmknom/prettier --version
	$(SECURE_DOCKER_RUN) ghcr.io/tmknom/dockerfiles/prettier --version
	.github/tests/prettier/test.sh

.PHONY: test-markdownlint
test-markdownlint:
	$(DOCKER_PULL) tmknom/markdownlint
	$(DOCKER_PULL) ghcr.io/tmknom/dockerfiles/markdownlint
	$(SECURE_DOCKER_RUN) tmknom/markdownlint --version
	$(SECURE_DOCKER_RUN) ghcr.io/tmknom/dockerfiles/markdownlint --version
	.github/tests/markdownlint/test.sh

.PHONY: test-yamllint
test-yamllint:
	$(DOCKER_PULL) tmknom/yamllint
	$(DOCKER_PULL) ghcr.io/tmknom/dockerfiles/yamllint
	$(SECURE_DOCKER_RUN) tmknom/yamllint --version
	$(SECURE_DOCKER_RUN) ghcr.io/tmknom/dockerfiles/yamllint --version
	.github/tests/yamllint/test.sh

.PHONY: test-jsonlint
test-jsonlint:
	$(DOCKER_PULL) tmknom/jsonlint
	$(DOCKER_PULL) ghcr.io/tmknom/dockerfiles/jsonlint
	$(SECURE_DOCKER_RUN) tmknom/jsonlint --version || true
	$(SECURE_DOCKER_RUN) ghcr.io/tmknom/dockerfiles/jsonlint --version || true
	.github/tests/jsonlint/test.sh

#
# Lint
#
.PHONY: lint
lint: lint-dockerfile lint-markdown lint-yaml lint-action lint-shell lint-json ## lint all

.PHONY: lint-dockerfile
lint-dockerfile: ## lint dockerfile by hadolint and dockerfilelint
	$(SECURE_DOCKER_RUN) $(HADOLINT) hadolint $(DOCKERFILE_FILES)
	$(SECURE_DOCKER_RUN) $(DOCKERFILELINT) $(DOCKERFILE_FILES)

.PHONY: lint-markdown
lint-markdown: ## lint markdown by markdownlint and prettier
	$(SECURE_DOCKER_RUN) $(MARKDOWNLINT) --dot --config .markdownlint.yml $(MARKDOWN_FILES)
	$(SECURE_DOCKER_RUN) $(PRETTIER) --check --parser=markdown $(MARKDOWN_FILES)

.PHONY: lint-yaml
lint-yaml: ## lint yaml by yamllint and prettier
	$(SECURE_DOCKER_RUN) $(YAMLLINT) --strict --config-file .yamllint.yml .
	$(SECURE_DOCKER_RUN) $(PRETTIER) --check --parser=yaml $(YAML_FILES)

.PHONY: lint-action
lint-action: ## lint action by actionlint
	$(SECURE_DOCKER_RUN) $(ACTIONLINT) -color -ignore '"permissions" section should not be empty.'

.PHONY: lint-shell
lint-shell: ## lint shell by shellcheck and shfmt
	$(SECURE_DOCKER_RUN) $(SHELLCHECK) $(SHELL_FILES)
	$(SECURE_DOCKER_RUN) $(SHFMT) -i 2 -ci -bn -d .

.PHONY: lint-json
lint-json: ## lint json by prettier
	$(SECURE_DOCKER_RUN) $(PRETTIER) --check --parser=json $(JSON_FILES)

#
# Format code
#
.PHONY: format
format: format-markdown format-yaml format-shell format-json ## format all

.PHONY: format-markdown
format-markdown: ## format markdown by prettier
	$(SECURE_DOCKER_RUN) $(PRETTIER) --write --parser=markdown $(MARKDOWN_FILES)

.PHONY: format-yaml
format-yaml: ## format yaml by prettier
	$(SECURE_DOCKER_RUN) $(PRETTIER) --write --parser=yaml $(YAML_FILES)

.PHONY: format-shell
format-shell: ## format shell by shfmt
	$(SECURE_DOCKER_RUN) $(SHFMT) -i 2 -ci -bn -w .

.PHONY: format-json
format-json: ## format json by prettier
	$(SECURE_DOCKER_RUN) $(PRETTIER) --write --parser=json $(JSON_FILES)

#
# Release management
#
release: ## release
	$(GIT) tag --force --message "$(SEMVER)" "$(SEMVER)" && \
	$(GIT) tag --force --message "$(SEMVER)" "$(MAJOR_VERSION)" && \
	$(GIT) push --force origin "$(SEMVER)" && \
	$(GIT) push --force origin "$(MAJOR_VERSION)"

bump: input-version commit create-pr ## bump version

input-version:
	@echo "Current version: $(VERSION)" && \
	read -rp "Input next version: " version && \
	echo "$${version}" > VERSION

commit:
	$(GIT) switch -c "bump-$(SEMVER)" && \
	$(GIT) add VERSION && \
	$(GIT) commit -m "Bump up to $(SEMVER)"

create-pr:
	$(GIT) push origin $$($(GIT) rev-parse --abbrev-ref HEAD) && \
	$(GH) pr create --title "Bump up to $(SEMVER)" --body "" --web

#
# Clean
#
.PHONY: clean
clean: ## clean all
	$(DOCKER_RMI) tmknom/prettier ghcr.io/tmknom/dockerfiles/prettier
	$(DOCKER_RMI) tmknom/markdownlint ghcr.io/tmknom/dockerfiles/markdownlint
	$(DOCKER_RMI) tmknom/yamllint ghcr.io/tmknom/dockerfiles/yamllint
	$(DOCKER_RMI) tmknom/jsonlint ghcr.io/tmknom/dockerfiles/jsonlint

#
# Git shortcut
#
.PHONY: git-diff
git-diff: ## git diff only features
	@$(GIT) diff $(SEMVER)... -- $(GIT_EXCLUDE_FILES)

.PHONY: git-log
git-log: ## git log only features
	@$(GIT) log $(SEMVER)... -- $(GIT_EXCLUDE_FILES)

#
# Help
#
.PHONY: help
help: ## show help
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
