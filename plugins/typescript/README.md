# TypeScript Plugin

## Dependencies

This plugin depends on `tdd-plugin` from this repository. Install it first:

```bash
claude plugin install --scope project tdd-plugin
```

## Recommended Hooks Configuration

Formatting, linting, and build (type-check) verification are not included in the plugin agents. Ideally these checks would be built into the plugin, but the specific tooling (ESLint vs Biome), npm script names (`lint`, `check`, `typecheck`, etc.), and package managers (`npm`, `pnpm`, etc.) vary too much across projects. As a compromise, configure them as [Claude Code hooks](https://docs.anthropic.com/en/docs/claude-code/hooks) in your project's `.claude/settings.json`.

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

## Recommended External Tools

Official plugins:

```bash
claude plugin install --scope project typescript-lsp
claude plugin install --scope project frontend-design
```

MCP:

```bash
claude mcp add --scope project playwright npx @playwright/mcp@latest
```

