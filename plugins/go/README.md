# Go Plugin

## Dependencies

This plugin depends on `tdd-plugin` from this repository. Install it first:

```bash
claude plugin install --scope project tdd-plugin
```

## Recommended Hooks Configuration

Formatting, linting, and vet checks are not included in the plugin agents. Ideally these checks would be built into the plugin, but the specific linting tool (`golangci-lint` vs individual linters) and project structure vary across projects. As a compromise, configure them as [Claude Code hooks](https://docs.anthropic.com/en/docs/claude-code/hooks) in your project's `.claude/settings.json`.

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

Enforce using the subagents.

```markdown
## Development Workflow

Must follow these steps sequentially for any non-trivial implementation:

### 1. Spec

Use `spec-plugin:spec` subagent to clarify requirements and produce a specification before writing any code.

### 2. Coding

Use `go-plugin:coding` subagent to implement the feature following TDD Red-Green-Refactor cycle with idiomatic Go practices.

### 3. Review & Testing

Run all three of the following subagents to validate the implementation:

- `go-plugin:code-review` — Review for readability, maintainability, and Go idioms
- `go-plugin:testing` — Run tests, analyze coverage, and identify gaps
- `go-plugin:security` — Audit for vulnerabilities and insecure patterns

### 4. E2E Verification

Use `go-plugin:e2e` subagent to verify end-to-end behavior. If E2E tests fail, loop back to step 2 (Coding) to fix the implementation and repeat from there.
```

## Recommended External Tools

- [`golangci-lint`](https://golangci-lint.run/) — aggregated linter runner
- [`govulncheck`](https://pkg.go.dev/golang.org/x/vuln/cmd/govulncheck) — vulnerability scanner for Go dependencies
- [`goimports`](https://pkg.go.dev/golang.org/x/tools/cmd/goimports) — automatic import formatting
- [`staticcheck`](https://staticcheck.dev/) — advanced static analysis

## Multi-Module Repos

For repositories containing multiple Go modules, use [Go workspaces](https://go.dev/doc/tutorial/workspaces) (`go work init`, `go work use ./module-a ./module-b`) to manage local development across modules. This avoids `replace` directives in `go.mod` and keeps dependency resolution consistent.
