---
name: jj
description: Use `jj` for version control operations (commit, status, log, diff). Invoke with /jj or when committing changes.
user-invocable: true
---

# jj Version Control Skill

## Prerequisites

Always try `jj` commands directly without any prerequisite checks.

If a `jj` command fails (e.g., "There is no jj repo in..."), ask the user how they would like to proceed (e.g., use git instead, initialize jj, or something else).

## Common Operations

### Check Status
```bash
jj status
```
Shows the current working copy status and any conflicts.

### View History
```bash
jj log
```
Shows commit history with change IDs. Use `-r` to filter revisions.

### View Diff
```bash
# Diff of working copy
jj diff

# Diff of specific revision
jj diff -r @-
```

### Create a Commit

In jj, you work differently from git. The working copy is always a commit:

```bash
# Describe the current working copy change
jj describe -m "commit message"

# Start a new empty change on top
jj new
```

Or combine both:
```bash
jj commit -m "commit message"
```

### Amend Current Change
```bash
# Add more changes to current commit
jj squash
```

### Squash Into Parent
```bash
jj squash
```

### Split a Commit
```bash
jj split
```
Interactive tool to split the current change into multiple commits.

### Rebase
```bash
# Rebase current change onto main
jj rebase -d main

# Rebase a branch
jj rebase -s <change-id> -d <destination>
```

### Bookmarks (Branches)
```bash
# List bookmarks
jj bookmark list

# Create/move bookmark to current change
jj bookmark set <name>

# Delete bookmark
jj bookmark delete <name>
```

### Undo
```bash
jj undo
```
Undo the last jj operation.

### Push to Remote
```bash
# Push all bookmarks
jj git push

# Push specific bookmark
jj git push -b <bookmark-name>
```

### Fetch from Remote
```bash
jj git fetch
```

## Commit Message Guidelines

- Use conventional commit format when appropriate (feat:, fix:, docs:, etc.)
- Keep the first line under 72 characters
- Add blank line before detailed description if needed
- Add Co-Authored-By trailer for AI-assisted commits:
  ```
  Co-Authored-By: Claude <noreply@anthropic.com>
  ```

## Key Differences from Git

| Git | jj |
|-----|-----|
| `git add` + `git commit` | `jj commit` or `jj describe` + `jj new` |
| `git stash` | Not needed - just `jj new` |
| `git branch` | `jj bookmark` |
| `git checkout` | `jj edit` or `jj new -r` |
| `git rebase -i` | `jj rebase` + `jj squash` / `jj split` |
| `git log` | `jj log` |
| `git diff` | `jj diff` |
