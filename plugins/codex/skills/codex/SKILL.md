---
name: codex
description: Delegate a task to OpenAI Codex CLI for non-interactive execution. Invoke with /codex followed by a prompt.
user-invocable: true
argument-hint: "[prompt]"
---

# Codex — Task Delegation Skill

Delegate implementation tasks to OpenAI's Codex CLI. Codex runs non-interactively with workspace-write access and can modify files in the working directory.

## When to Use

- Delegating implementation tasks (refactoring, adding features, fixing bugs)
- Getting a second opinion from a different AI model
- Running tasks where Codex's strengths complement Claude's

## Usage

```
/codex refactor the authentication module to use JWT
/codex add unit tests for the parser module
/codex fix the off-by-one error in pagination logic
```

## How It Works

1. The agent receives your prompt and runs `codex exec --full-auto --ephemeral` non-interactively
2. Codex operates in a workspace-write sandbox (can read and write within the project directory)
3. The final output is captured and reported back
4. If Codex modified files, the agent shows a diff of changes

## Notes

- Codex must be installed and authenticated (`codex login`)
- Default sandbox is `workspace-write` via `--full-auto`
- Long-running tasks may take several minutes
