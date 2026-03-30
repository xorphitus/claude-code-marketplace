#!/usr/bin/env bash
set -euo pipefail

input=$(cat)
command=$(echo "$input" | jq -r '.tool_input.command // empty')

if [ -z "$command" ]; then
  exit 0
fi

# Block "git" as a standalone word anywhere in the command,
# covering: git ..., cd foo && git ..., VAR=1 git ..., if git ...; etc.
# Allow "jj git ..." which is a valid jj subcommand.
if ! echo "$command" | grep -qE '(^|[;&|]\s*)git($| )'; then
  exit 0
fi
if echo "$command" | grep -qE '(^|[;&|]\s*)jj\s+git($| )'; then
  exit 0
fi

# Only block in jj-managed repositories
if [ ! -d "${CLAUDE_PROJECT_DIR:-.}/.jj" ]; then
  exit 0
fi

cat <<'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "This project uses jj (Jujutsu) for version control (.jj directory detected). Use jj commands instead of git. Common equivalents: git status → jj status | git log → jj log | git diff → jj diff | git add + git commit → jj commit -m 'message' | git push → jj git push | git fetch → jj git fetch | git branch → jj bookmark | git rebase → jj rebase | git checkout → jj edit or jj new -r | git stash → not needed, just jj new"
  }
}
EOF
