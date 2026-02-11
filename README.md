# claude-code-marketplace

Basic plugins local installation:

```bash
claude plugin marketplace add /path/to/claude-code-marketplace
claude plugin install --scope local jj-plugin
claude plugin install --scope local spec-plugin
claude plugin install --scope local tdd-plugin
```

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
claude plugin install --scope project claude-md-management
claude plugin install --scope project claude-code-setup
```
