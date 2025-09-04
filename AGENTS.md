Agent Worktree Structure

Overview
- Main branch stays checked out in the repo root (`.`).
- All other branches live as Git worktrees under `./.worktrees/<branch>`.
- Directory names replace slashes with dashes (e.g., `feature/foo` -> `.worktrees/feature-foo`).

Why
- Enables multiple agents/tabs to work concurrently without branch conflicts.
- Keeps `main` as the canonical working copy at the root for quick reads and simple changes.

Conventions
- Do not check out `main` in a worktree. Root holds `main`.
- Create and work on new branches only inside `./.worktrees/`.
- One branch can only be checked out in one place at a time (Git worktree rule).

Helper Script
- Use `scripts/worktrees.sh` to manage worktrees consistently.

Branch Naming
- Prefer using hyphens or dots in branch names (e.g., `feature.foo` or `feature-foo`) for clearer 1:1 mapping to worktree folder names.
- Slashes in branch names (e.g., `feature/foo`) are fine and conventional; just note that worktree folders are flattened (slashes become dashes) to avoid nested dirs.
- Use `scripts/worktrees.sh path <branch>` to get the exact folder path regardless of naming.

Common Tasks
- List worktrees: `scripts/worktrees.sh list`
- Create a new feature branch from `main` and add a worktree:
  - `scripts/worktrees.sh create feature/foo --base main`
  - `cd $(scripts/worktrees.sh path feature/foo)`
- Add a worktree for an existing branch:
  - `scripts/worktrees.sh add gh-pages`
  - `cd $(scripts/worktrees.sh path gh-pages)`
- Remove a worktree when done:
  - `scripts/worktrees.sh remove feature/foo`
  - Clean stale refs (if needed): `scripts/worktrees.sh prune`

Makefile Shortcuts
- List: `make wt-list`
- Create: `make wt-create BR=feature.foo [BASE=main]`
- Add existing: `make wt-add BR=gh-pages`
- Remove: `make wt-remove BR=feature.foo`
- Path: `make wt-path BR=feature.foo`

Working Guidelines
- Always run Git commands inside the specific worktree directory you’re working in.
- Push/pull as usual; new branches created via the script are based on `--base` (default `HEAD`).
- If you need a long‑running local edit on `main`, do it at the repo root.
- If two agents need similar work, create separate branches (e.g., `feature/foo-a`, `feature/foo-b`).

Tips
- To open multiple tabs quickly, use the printed path: `cd $(scripts/worktrees.sh path <branch>)`.
- If a `remove` reports the worktree as "prunable", ensure no editor/process is locking the directory, then run `scripts/worktrees.sh prune`.
- You can safely delete an untracked worktree directory if Git shows it as prunable; prefer the script to keep metadata tidy.

Optional
- To mirror all non-`main` branches as worktrees: for b in $(git for-each-ref --format='%(refname:short)' refs/heads | grep -v '^main$'); do scripts/worktrees.sh add "$b"; done
