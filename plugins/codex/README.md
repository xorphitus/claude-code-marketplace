# Codex Plugin

## Dependencies

- [Codex CLI](https://github.com/openai/codex) must be installed and available in PATH
- Authenticated with OpenAI (`codex login`)
- No plugin dependencies (standalone — does not require tdd-plugin or other plugins)

## Installation

Install at the local (project) scope for project-specific delegation workflows:

```bash
claude plugin install --scope local codex-plugin
```

Or at user scope to make Codex available across all projects:

```bash
claude plugin install --scope user codex-plugin
```

## Hooks Configuration

No hooks are typically needed. Codex manages its own file modifications through its sandbox (`--full-auto`), so pre/post hooks are not required for normal use.

## CLAUDE.md Configuration

Add to your project's CLAUDE.md to make Codex available as a delegation target for both task execution and code review:

```markdown
## External Agents

- `codex-plugin:codex` — Delegate tasks to OpenAI Codex CLI via `/codex`
- `codex-plugin:codex` — Request code reviews via `/codex-review`
```

Example usage:

```
/codex refactor the authentication module to use JWT
/codex-review --uncommitted
```

## Recommended External Tools

- [Codex CLI](https://github.com/openai/codex) — OpenAI's non-interactive coding agent CLI
