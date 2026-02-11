# claude-code-marketplace
Local installation example:

```bash
claude plugin marketplace add /path/to/claude-code-marketplace
claude plugin install --scope local jj-plugin
```

## Appendix
### Frontend Project Setup Example
Official plugins:

```bash
claude plugin install --scope project typescript-lsp
claude plugin install --scope project frontend-design
claude plugin install --scope project claude-md-management
claude plugin install --scope project claude-code-setup
```

MCP:
```bash
claude mcp add --scope project playwright npx @playwright/mcp@latest
```
