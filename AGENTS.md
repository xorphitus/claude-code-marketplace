# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A local plugin marketplace for Claude Code. Contains reusable plugins that extend Claude Code with specialized agents and skills. No build process — this is a pure configuration/documentation repository.

## Plugin Architecture

Each plugin lives under `plugins/<name>/` and follows this structure:

```
plugins/<name>/
├── .claude-plugin/
│   └── plugin.json          # name, version, description
├── agents/                   # Optional: specialist subagents
│   └── <agent>.md           # Markdown with YAML frontmatter (name, description, tools, model, skills)
└── skills/                   # Optional: user-invocable skills
    └── <skill>/
        └── SKILL.md         # Markdown with YAML frontmatter (name, description, user-invocable)
```

- **Marketplace registry:** `.claude-plugin/marketplace.json` — lists all available plugins with source paths
- **Local enablement:** `.claude/settings.local.json` — tracks which plugins are enabled
- Agents and skills are defined as Markdown files with YAML frontmatter, not JSON

## Adding a New Plugin

1. Create the plugin directory structure under `plugins/<name>/`
2. Add `plugin.json` with name, description, and version
3. Define agents (`.md` with frontmatter specifying tools, model) and/or skills (`SKILL.md` with frontmatter)
4. Register the plugin in `.claude-plugin/marketplace.json`

## Installation

```bash
claude plugin marketplace add /path/to/claude-code-marketplace
claude plugin install --scope local <plugin-name>
```
