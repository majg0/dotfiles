#!/usr/bin/env bash
# Sends a desktop notification. On WSL, uses BurntToast via pwsh.exe.
# On other systems, sends a bell + OSC 777 to the parent terminal,
# walking up the process tree to find the TTY since hooks have no controlling terminal.

MSG="${1:-Notification}"

# Use CLAUDE_TTY if set (exported by the claude shell function), else walk process tree
TTY="$CLAUDE_TTY"
if [ -z "$TTY" ]; then
  PID=$$
  while [ "$PID" != "1" ] && [ -n "$PID" ]; do
    T=$(ps -o tty= -p "$PID" 2>/dev/null | tr -d ' ')
    if [ -n "$T" ] && [ "$T" != "??" ] && [ -e "/dev/$T" ]; then
      TTY="/dev/$T"
      break
    fi
    PID=$(ps -o ppid= -p "$PID" 2>/dev/null | tr -d ' ')
  done
fi

if [ -z "$TTY" ]; then
  exit 0
fi

# Send notification
if uname -r 2>/dev/null | grep -qi microsoft; then
  # WSL: use BurntToast on the Windows side
  pwsh.exe -Command "Import-Module BurntToast; New-BurntToastNotification -Text 'Claude Code','$MSG'" 2>/dev/null
else
  # Native: send OSC 777 desktop notification + bell to the parent terminal
  printf '\033]777;notify;Claude Code;%s\007' "$MSG" > "$TTY"
  printf '\a' > "$TTY"
fi

exit 0
