#!/bin/bash
# HUD tile wrapper for Ghost Eye (added 2026-11-25).
# ghost_eye.py is an interactive terminal menu (input() prompts), so a tile with no terminal
# exits at its first "Enter your choice". This opens it in a new Terminal.app window, run by
# ghost_eye/.venv's python (python-nmap, bs4, cloudscraper, webtech). The first run asks for
# Automation permission to let the HUD control Terminal.
set -euo pipefail
DIR="$HOME/Projects/mac-gui-suite/ghost_eye"
PY="$DIR/.venv/bin/python"
[ -x "$PY" ] || { echo "Ghost Eye venv missing: $PY" >&2; exit 1; }
CMD="cd $(printf %q "$DIR") && exec $(printf %q "$PY") ghost_eye.py"
exec /usr/bin/osascript - "$CMD" <<'OSA'
on run argv
  tell application "Terminal"
    activate
    do script (item 1 of argv)
  end tell
end run
OSA
