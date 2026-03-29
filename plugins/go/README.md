# Go Plugin

## Dependencies

This plugin depends on `tdd-plugin` from this repository. Install it first:

```bash
claude plugin install --scope local tdd-plugin
```

## Recommended Hooks Configuration

Formatting, linting, and vet checks are not included in the plugin agents. Ideally these checks would be built into the plugin, but the specific linting tool (`golangci-lint` vs individual linters) and project structure vary across projects. As a compromise, configure them as [Claude Code hooks](https://code.claude.com/docs/en/hooks-guide) in your project's `.claude/settings.json`.

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
            "command": "goimports -w ."
          },
          {
            "type": "command",
            "command": "go vet ./... && staticcheck ./..."
          },
          {
            "type": "command",
            "command": "go mod tidy"
          }
        ]
      }
    ]
  }
}
```

Adjust the linting commands to match your project. If you use `golangci-lint`, replace the vet/staticcheck hook:

```json
{
  "type": "command",
  "command": "golangci-lint run ./..."
}
```

## CLAUDE.md Configuration

Add to your project's CLAUDE.md to enforce subagent usage:

```markdown
## Development Workflow

Use subagents for all non-trivial work:
1. `spec-plugin:spec` — Clarify requirements
2. `go-plugin:coding` — Implement with TDD
3. `go-plugin:code-review`, `go-plugin:testing`, `go-plugin:security` — Validate (run in parallel)
4. `go-plugin:e2e` — E2E verification (loop to step 2 on failure)
```

## Recommended External Tools

- [`golangci-lint`](https://golangci-lint.run/) — aggregated linter runner
- [`govulncheck`](https://pkg.go.dev/golang.org/x/vuln/cmd/govulncheck) — vulnerability scanner for Go dependencies
- [`goimports`](https://pkg.go.dev/golang.org/x/tools/cmd/goimports) — automatic import formatting
- [`staticcheck`](https://staticcheck.dev/) — advanced static analysis

## Multi-Module Repos

For repositories containing multiple Go modules, use [Go workspaces](https://go.dev/doc/tutorial/workspaces) (`go work init`, `go work use ./module-a ./module-b`) to manage local development across modules. This avoids `replace` directives in `go.mod` and keeps dependency resolution consistent.
