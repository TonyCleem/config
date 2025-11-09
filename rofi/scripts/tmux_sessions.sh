#!/usr/bin/env bash
sessions=$(tmux list-sessions -F "#S" 2>/dev/null || true)
choice=$(printf "[new]\n%s" "$sessions" | fzf)

[ -z "$choice" ] && exit
if [ "$choice" = "[new]" ]; then
  read -rp "New session name: " name
  [ -z "$name" ] && exit
  tmux new -s "$name"
else
  tmux attach -t "$choice"
fi
