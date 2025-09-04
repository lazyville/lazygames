#!/usr/bin/env bash
set -euo pipefail

# git worktree helper for repo-local worktrees under ./.worktrees
#
# Commands:
#   list                          List configured worktrees
#   add <branch>                  Add worktree for existing branch
#   create <branch> [--base REF]  Create new branch from REF (default HEAD) and add worktree
#   remove <branch>               Remove worktree for branch
#   prune                         Prune stale worktree references
#   path <branch>                 Print filesystem path for the worktree
#
# Examples:
#   scripts/worktrees.sh list
#   scripts/worktrees.sh add gh-pages
#   scripts/worktrees.sh create feature/foo --base main
#   scripts/worktrees.sh remove gh-pages

usage() {
  sed -n '1,40p' "$0" | sed 's/^# \{0,1\}//'
}

require_repo_root() {
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: not inside a git repository" >&2
    exit 1
  fi
}

to_dir_name() {
  # Map a branch like "feature/foo" to a safe dir name "feature-foo"
  echo "$1" | sed 's#[/:]#-#g'
}

wt_dir_for_branch() {
  local branch="$1"
  local root
  root="$(git rev-parse --show-toplevel)"
  echo "$root/.worktrees/$(to_dir_name "$branch")"
}

ensure_wt_root() {
  local root
  root="$(git rev-parse --show-toplevel)"
  mkdir -p "$root/.worktrees"
}

branch_exists() {
  git show-ref --verify --quiet "refs/heads/$1"
}

cmd_list() {
  git worktree list
}

cmd_add() {
  local branch="$1"
  ensure_wt_root
  if ! branch_exists "$branch"; then
    echo "Error: branch '$branch' does not exist. Use 'create' to create it." >&2
    exit 1
  fi

  local dir
  dir="$(wt_dir_for_branch "$branch")"
  if [ -d "$dir" ]; then
    echo "Skip: $dir already exists" >&2
  else
    git worktree add "$dir" "$branch"
  fi
}

cmd_create() {
  local branch="$1"; shift
  local base="HEAD"
  while [ $# -gt 0 ]; do
    case "$1" in
      --base)
        base="${2:-}"
        if [ -z "$base" ]; then
          echo "Error: --base requires a value" >&2
          exit 1
        fi
        shift 2 ;;
      *)
        echo "Unknown option: $1" >&2
        exit 1 ;;
    esac
  done

  ensure_wt_root
  local dir
  dir="$(wt_dir_for_branch "$branch")"
  if [ -d "$dir" ]; then
    echo "Skip: $dir already exists" >&2
  else
    git worktree add -b "$branch" "$dir" "$base"
  fi
}

cmd_remove() {
  local branch="$1"
  local dir
  dir="$(wt_dir_for_branch "$branch")"
  if [ ! -d "$dir" ]; then
    echo "Skip: $dir not found" >&2
  else
    git worktree remove "$dir"
  fi
}

cmd_prune() {
  git worktree prune
}

cmd_path() {
  wt_dir_for_branch "$1"
}

main() {
  require_repo_root
  local cmd="${1:-}"
  case "$cmd" in
    list)
      shift; cmd_list "$@" ;;
    add)
      shift; [ $# -ge 1 ] || { echo "Usage: $0 add <branch>" >&2; exit 1; }
      cmd_add "$1" ;;
    create)
      shift; [ $# -ge 1 ] || { echo "Usage: $0 create <branch> [--base REF]" >&2; exit 1; }
      local branch="$1"; shift; cmd_create "$branch" "$@" ;;
    remove)
      shift; [ $# -ge 1 ] || { echo "Usage: $0 remove <branch>" >&2; exit 1; }
      cmd_remove "$1" ;;
    prune)
      shift; cmd_prune ;;
    path)
      shift; [ $# -ge 1 ] || { echo "Usage: $0 path <branch>" >&2; exit 1; }
      cmd_path "$1" ;;
    -h|--help|help|"")
      usage ;;
    *)
      echo "Unknown command: $cmd" >&2
      usage ;;
  esac
}

main "$@"

