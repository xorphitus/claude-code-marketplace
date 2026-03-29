# Kotlin Plugin

## Dependencies

This plugin depends on `tdd-plugin` from this repository. Install it first:

```bash
claude plugin install --scope local tdd-plugin
```

## Recommended Hooks Configuration

Formatting, linting, and static analysis are not included in the plugin agents. Ideally these checks would be built into the plugin, but the specific tooling (ktlint vs standalone, detekt configuration) and project structure vary across projects. As a compromise, configure them as [Claude Code hooks](https://code.claude.com/docs/en/hooks-guide) in your project's `.claude/settings.json`.

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

Add to your project's CLAUDE.md to enforce subagent usage:

```markdown
## Development Workflow

Use subagents for all non-trivial work:
1. `spec-plugin:spec` — Clarify requirements
2. `kotlin-plugin:coding` — Implement with TDD
3. `kotlin-plugin:code-review`, `kotlin-plugin:testing`, `kotlin-plugin:security` — Validate (run in parallel)
4. `kotlin-plugin:e2e` — E2E verification (loop to step 2 on failure)
```

## Recommended External Tools

- [`ktlint`](https://pinterest.github.io/ktlint/) — Kotlin linter and formatter with built-in code style
- [`detekt`](https://detekt.dev/) — static code analysis for Kotlin
- [OWASP dependency-check](https://owasp.org/www-project-dependency-check/) — vulnerability scanner for project dependencies
- [JaCoCo](https://www.jacoco.org/jacoco/) — code coverage library for JVM languages
