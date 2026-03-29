# claude-code-marketplace

Basic plugins local installation:

```bash
claude plugin marketplace add /path/to/claude-code-marketplace
claude plugin install --scope local jj-plugin
claude plugin install --scope local spec-plugin
claude plugin install --scope local tdd-plugin
```

Use `--scope local` for personal utility plugins (jj, spec, tdd) and `--scope project` for language plugins (go, kotlin, rust, typescript).

## Recommended External Tools

Official plugins:

```bash
claude plugin install --scope project claude-md-management
claude plugin install --scope project claude-code-setup
```
