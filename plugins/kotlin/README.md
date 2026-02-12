# Kotlin Plugin

## Dependencies

This plugin depends on `tdd-plugin` from this repository. Install it first:

```bash
claude plugin install --scope project tdd-plugin
```

## Recommended Hooks Configuration

Formatting, linting, and static analysis are not included in the plugin agents. Ideally these checks would be built into the plugin, but the specific tooling (ktlint vs standalone, detekt configuration) and project structure vary across projects. As a compromise, configure them as [Claude Code hooks](https://docs.anthropic.com/en/docs/claude-code/hooks) in your project's `.claude/settings.json`.

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
            "command": "./gradlew ktlintFormat"
          },
          {
            "type": "command",
            "command": "./gradlew detekt"
          }
        ]
      }
    ]
  }
}
```

If you use standalone `ktlint` instead of the Gradle plugin, replace the format hook:

```json
{
  "type": "command",
  "command": "ktlint --format"
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

Use `kotlin-plugin:coding` subagent to implement the feature following TDD Red-Green-Refactor cycle with idiomatic Kotlin practices.

### 3. Review & Testing

Run all three of the following subagents to validate the implementation:

- `kotlin-plugin:code-review` — Review for readability, maintainability, and Kotlin idioms
- `kotlin-plugin:testing` — Run tests, analyze coverage, and identify gaps
- `kotlin-plugin:security` — Audit for vulnerabilities and insecure patterns

### 4. E2E Verification

Use `kotlin-plugin:e2e` subagent to verify end-to-end behavior. If E2E tests fail, loop back to step 2 (Coding) to fix the implementation and repeat from there.
```

## Recommended External Tools

- [`ktlint`](https://pinterest.github.io/ktlint/) — Kotlin linter and formatter with built-in code style
- [`detekt`](https://detekt.dev/) — static code analysis for Kotlin
- [OWASP dependency-check](https://owasp.org/www-project-dependency-check/) — vulnerability scanner for project dependencies
- [JaCoCo](https://www.jacoco.org/jacoco/) — code coverage library for JVM languages
