# Rust Plugin

## Dependencies

This plugin depends on `tdd-plugin` from this repository. Install it first:

```bash
claude plugin install --scope project tdd-plugin
```

## Recommended Hooks Configuration

Formatting, linting, and build verification are not included in the plugin agents. Ideally these checks would be built into the plugin, but the specific tooling (clippy configuration, feature flags, workspace layout) varies across projects. As a compromise, configure them as [Claude Code hooks](https://docs.anthropic.com/en/docs/claude-code/hooks) in your project's `.claude/settings.json`.

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
            "command": "cargo fmt"
          },
          {
            "type": "command",
            "command": "cargo clippy -- -D warnings && cargo check"
          }
        ]
      }
    ]
  }
}
```

Adjust the clippy flags and feature sets to match your project.

## CLAUDE.md Configuration

Enforce using the subagents.

```markdown
## Development Workflow

Must follow these steps sequentially for any non-trivial implementation:

### 1. Spec

Use `spec-plugin:spec` subagent to clarify requirements and produce a specification before writing any code.

### 2. Coding

Use `rust-plugin:coding` subagent to implement the feature following TDD Red-Green-Refactor cycle with idiomatic Rust practices.

### 3. Review & Testing

Run all three of the following subagents to validate the implementation:

- `rust-plugin:code-review` — Review for readability, maintainability, and Rust idioms
- `rust-plugin:testing` — Run tests, analyze coverage, and identify gaps
- `rust-plugin:security` — Audit for vulnerabilities and insecure patterns

### 4. E2E Verification

Use `rust-plugin:e2e` subagent to verify end-to-end behavior. If E2E tests fail, loop back to step 2 (Coding) to fix the implementation and repeat from there.
```

## Recommended External Tools

- [`cargo-clippy`](https://doc.rust-lang.org/clippy/) — lint collection for common mistakes and style issues
- [`cargo-audit`](https://rustsec.org/) — vulnerability scanner for Rust dependencies
- [`cargo-tarpaulin`](https://github.com/xd009642/tarpaulin) — code coverage tool
- [`cargo-deny`](https://embarkstudios.github.io/cargo-deny/) — supply chain security (licenses, bans, advisories)
- [`rustfmt`](https://rust-lang.github.io/rustfmt/) — official code formatter
