#!/bin/bash
eval "$(TMPDIR=/tmp/claude-1000 ssh-agent -s)" >/dev/null 2>&1
trap 'ssh-agent -k >/dev/null 2>&1' EXIT
if ! TMPDIR=/tmp/claude-1000 op item get "Claude SSH Key" --vault Claude --field "private key" --reveal 2>/dev/null | tr -d '"' | tail -n +2 | ssh-add - 2>/dev/null; then
  echo "Failed to load SSH key from 1Password" >&2
  exit 1
fi
ssh -F ~/.claude/ssh_config "$@"
