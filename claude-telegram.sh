#!/bin/bash
# Claude Code Telegram bot service wrapper
# Uses script to allocate a pseudo-TTY (required for Claude's TUI)

export HOME=/root
export PATH="/root/.local/bin:/root/.bun/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

CLAUDE_BIN="/root/.local/bin/claude"
LOG="/var/log/claude-telegram.log"

echo "[$(date)] Starting Claude Telegram bot..." >> "$LOG"

# script allocates a PTY so claude runs as if in a terminal
# Output is logged; claude exits -> systemd restarts
exec script -q -c "$CLAUDE_BIN --channels plugin:telegram@claude-plugins-official --permission-mode auto" /dev/null >> "$LOG" 2>&1
