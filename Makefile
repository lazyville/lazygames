# Worktree shortcuts
# Usage examples:
#   make wt-list
#   make wt-create BR=feature.foo [BASE=main]
#   make wt-add BR=gh-pages
#   make wt-remove BR=feature.foo
#   make wt-path BR=gh-pages

SHELL := /bin/bash
BASE ?= main

.PHONY: wt-list wt-add wt-create wt-remove wt-prune wt-path

wt-list:
	./scripts/worktrees.sh list

wt-add:
	@test -n "$(BR)" || (echo "BR is required (branch name)" >&2; exit 1)
	./scripts/worktrees.sh add "$(BR)"

wt-create:
	@test -n "$(BR)" || (echo "BR is required (branch name)" >&2; exit 1)
	./scripts/worktrees.sh create "$(BR)" --base "$(BASE)"

wt-remove:
	@test -n "$(BR)" || (echo "BR is required (branch name)" >&2; exit 1)
	./scripts/worktrees.sh remove "$(BR)"

wt-prune:
	./scripts/worktrees.sh prune

wt-path:
	@test -n "$(BR)" || (echo "BR is required (branch name)" >&2; exit 1)
	./scripts/worktrees.sh path "$(BR)"

