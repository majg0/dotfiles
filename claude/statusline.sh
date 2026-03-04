#!/usr/bin/env bash
set -euo pipefail

# DOCS (Martin): https://code.claude.com/docs/en/statusline#available-data

# Read JSON data that Claude Code sends to stdin
input=$(cat)

AGENT=$(echo "$input" | jq -r '.agent.name // "no agent"')
MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')

# The "// 0" provides a fallback if the field is null
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
IN=$(echo "$input" | jq -r '.context_window.total_input_tokens')
OUT=$(echo "$input" | jq -r '.context_window.total_output_tokens')

COST=$(echo "$input" | jq -r '.cost.total_cost_usd * 100 | round / 100')

VERSION=$(echo "$input" | jq -r '.version')

# Output the status line - ${DIR##*/} extracts just the folder name
echo -e "[${MODEL}] \x1B[0;3;36m${AGENT}\x1B[m | 📁 ${DIR##*/} | ${PCT}% 🔺${IN}🔻${OUT} | \x1B[0;33m\$${COST}\x1B[m | v${VERSION}"
