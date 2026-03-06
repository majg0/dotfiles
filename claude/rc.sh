claude() {
  CLAUDE_TTY=$(tty 2>/dev/null) \
  GIT_CONFIG_GLOBAL=~/.config/git/claude \
  GIT_SSH_COMMAND="$HOME/.claude/git_ssh.sh" \
  OP_SERVICE_ACCOUNT_TOKEN="${OP_SERVICE_ACCOUNT_TOKEN:-$(op item get "Service Account Auth Token: Agents" --vault Private --field credential --reveal)}" \
  command claude "$@"
}
