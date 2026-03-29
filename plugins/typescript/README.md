# TypeScript Plugin

## Dependencies

This plugin depends on `tdd-plugin` from this repository. Install it first:

```bash
claude plugin install --scope local tdd-plugin
```

## Recommended Hooks Configuration

Formatting, linting, and build (type-check) verification are not included in the plugin agents. Ideally these checks would be built into the plugin, but the specific tooling (ESLint vs Biome), npm script names (`lint`, `check`, `typecheck`, etc.), and package managers (`npm`, `pnpm`, etc.) vary too much across projects. As a compromise, configure them as [Claude Code hooks](https://code.claude.com/docs/en/hooks-guide) in your project's `.claude/settings.json`.

Example:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "pnpm run format"
          },
          {
            "type": "command",
            "command": "pnpm run lint --fix && pnpm run typecheck"
          }
        ]
      }
    ]
  }
}
```

Adjust the package manager and script names to match your project.

## CLAUDE.md Configuration

Add to your project's CLAUDE.md to enforce subagent usage:

```markdown
## Development Workflow

Use subagents for all non-trivial work:
1. `spec-plugin:spec` — Clarify requirements
2. `typescript-plugin:coding` — Implement with TDD
3. `typescript-plugin:code-review`, `typescript-plugin:testing`, `typescript-plugin:security` — Validate (run in parallel)
4. `typescript-plugin:e2e` — E2E verification (loop to step 2 on failure)
```

## Recommended External Tools

Official plugins (requires LSP):

```bash
claude plugin install --scope project typescript-lsp
claude plugin install --scope project frontend-design
```

MCP:

```bash
claude mcp add --scope project playwright npx @playwright/mcp@latest
```

