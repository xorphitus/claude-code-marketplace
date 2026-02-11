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

## CLAUDE.md Configuration

Enforce using the subagents.

```markdown
## Development Workflow

Must follow these steps sequentially for any non-trivial implementation:

### 1. Spec

Use `spec-plugin:spec` subagent to clarify requirements and produce a specification before writing any code.

### 2. Coding

Use `typescript-plugin:coding` subagent to implement the feature following TDD Red-Green-Refactor cycle with strict type safety.

### 3. Review & Testing

Run all three of the following subagents to validate the implementation:

- `typescript-plugin:code-review` — Review for readability, maintainability, and TypeScript idioms
- `typescript-plugin:testing` — Run tests, analyze coverage, and identify gaps
- `typescript-plugin:security` — Audit for vulnerabilities and insecure patterns

### 4. E2E Verification

Use `typescript-plugin:e2e` subagent to verify end-to-end behavior. If E2E tests fail, loop back to step 2 (Coding) to fix the implementation and repeat from there.
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

