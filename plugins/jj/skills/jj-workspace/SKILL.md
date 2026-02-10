---
name: jj-workspace
description: Create isolated jj workspace for parallel work. Use when working on separate tasks simultaneously or testing changes in isolation.
user-invocable: true
---

# jj Workspace Skill

## When to Use

- **Parallel development**: Work on multiple features simultaneously
- **Testing changes**: Test modifications without affecting main workspace
- **Isolated experiments**: Try approaches that might be discarded
- **Code review**: Check out a PR while keeping current work intact

## Workspace Location

Use the `.wt/` prefix at repository root for all workspaces:
- `.wt/feature-name`
- `.wt/bugfix-123`
- `.wt/experiment`

This keeps workspaces organized and separate from the main working directory.

## Operations

### Create a New Workspace

```bash
# Create workspace at .wt/<name>
jj workspace add .wt/<workspace-name>

# Create workspace and check out a specific revision
jj workspace add .wt/<workspace-name> -r <revision>
```

Example:
```bash
jj workspace add .wt/feature-auth
jj workspace add .wt/review-pr-42 -r @some-bookmark
```

### List All Workspaces

```bash
jj workspace list
```

### Work in a Workspace

Simply change directory to the workspace:
```bash
cd .wt/<workspace-name>
```

All jj commands will operate on that workspace's working copy.

### Return to Main Workspace

```bash
cd /path/to/repository-root
```

### Delete a Workspace

```bash
# Remove from jj's tracking
jj workspace forget <workspace-name>

# Remove the directory
rm -rf .wt/<workspace-name>
```

Or do both:
```bash
jj workspace forget <workspace-name> && rm -rf .wt/<workspace-name>
```

## Best Practices

1. **Use descriptive names**: Name workspaces after the task or feature
2. **Clean up when done**: Remove workspaces after merging or abandoning work
3. **Shared history**: All workspaces share the same commit history
4. **Independent working copies**: Each workspace has its own working copy state
5. **Bookmark association**: Each workspace tracks its own current change

## Example Workflow

```bash
# 1. Create workspace for a new feature
jj workspace add .wt/new-feature

# 2. Switch to the workspace
cd .wt/new-feature

# 3. Work on the feature
jj describe -m "feat: implement new feature"
# ... make changes ...
jj new

# 4. When done, return to main workspace
cd ../..

# 5. The changes are available in the main workspace too
jj log  # Shows commits from all workspaces

# 6. Clean up
jj workspace forget new-feature
rm -rf .wt/new-feature
```

## Troubleshooting

### Workspace conflicts
If the same file is modified in multiple workspaces and you try to merge:
```bash
jj resolve  # Interactive conflict resolution
```

### Stale workspace
If a workspace gets into a bad state:
```bash
jj workspace forget <name>
rm -rf .wt/<name>
jj workspace add .wt/<name>  # Recreate fresh
```
