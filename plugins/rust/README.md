# Rust Plugin

## Dependencies

This plugin depends on `tdd-plugin` from this repository. Install it first:

```bash
claude plugin install --scope local tdd-plugin
```

## Recommended Hooks Configuration

Formatting, linting, and build verification are not included in the plugin agents. Ideally these checks would be built into the plugin, but the specific tooling (clippy configuration, feature flags, workspace layout) varies across projects. As a compromise, configure them as [Claude Code hooks](https://code.claude.com/docs/en/hooks-guide) in your project's `.claude/settings.json`.

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
            "command": "cargo fmt && cargo fix"
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

Add to your project's CLAUDE.md to enforce subagent usage:

```markdown
## Development Workflow

Use subagents for all non-trivial work:
1. `spec-plugin:spec` — Clarify requirements
2. `rust-plugin:coding` — Implement with TDD
3. `rust-plugin:code-review`, `rust-plugin:testing`, `rust-plugin:security` — Validate (run in parallel)
4. `rust-plugin:e2e` — E2E verification (loop to step 2 on failure)
```

## Recommended External Tools

- [`cargo-clippy`](https://doc.rust-lang.org/clippy/) — lint collection for common mistakes and style issues
- [`cargo-audit`](https://rustsec.org/) — vulnerability scanner for Rust dependencies
- [`cargo-tarpaulin`](https://github.com/xd009642/tarpaulin) — code coverage tool
- [`cargo-deny`](https://embarkstudios.github.io/cargo-deny/) — supply chain security (licenses, bans, advisories)
- [`cargo-nextest`](https://nexte.st/) — faster, more reliable test runner
- [`cargo-llvm-cov`](https://github.com/taiki-e/cargo-llvm-cov) — coverage tool using LLVM
- [`cargo-machete`](https://github.com/bnjbvr/cargo-machete) — unused dependency detection
- [`cargo-msrv`](https://github.com/foresterre/cargo-msrv) — minimum supported Rust version checks
- [`cargo-vet`](https://github.com/mozilla/cargo-vet) — dependency auditing and trust policies
- [`rustfmt`](https://rust-lang.github.io/rustfmt/) — official code formatter
