---
name: codex-review
description: Request a code review from OpenAI Codex CLI. Reviews uncommitted changes, a branch diff, or a specific commit. Invoke with /codex-review.
user-invocable: true
argument-hint: "[review instructions or flags]"
---

# Codex Review — Code Review Skill

Request a code review from OpenAI's Codex CLI. This is a read-only operation that produces feedback without modifying files.

## When to Use

- Before committing changes — review staged/unstaged work
- After finishing a feature branch — review the full diff against the base branch
- Reviewing a specific commit

## Usage

```
/codex-review --uncommitted
/codex-review --base main
/codex-review --base main Focus on error handling and edge cases
/codex-review --commit abc123
```

### Flags

| Flag | Description |
|------|-------------|
| `--uncommitted` | Review staged, unstaged, and untracked changes |
| `--base BRANCH` | Review changes against the given base branch |
| `--commit SHA` | Review changes introduced by a specific commit |
| `--title TITLE` | Optional commit title to display in the review summary |

## How It Works

1. The agent runs `codex review` with the specified flags and optional custom instructions
2. Codex analyzes the diff and produces review feedback
3. The review findings are reported back

## Notes

- Codex must be installed and authenticated (`codex login`)
- This is a read-only operation — no files are modified
- You can combine flags with custom review instructions as a trailing prompt
