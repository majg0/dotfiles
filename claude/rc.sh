claude() {
  CLAUDE_TTY=$(tty 2>/dev/null) \
  GIT_CONFIG_GLOBAL=~/.config/git/claude \
  command claude "$@"
}
