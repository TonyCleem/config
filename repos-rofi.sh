#!/bin/sh
set -eu

# Set your terminal:
terminal="kitty"
theme_path="$HOME/.config/rofi/power-profiles.rasi"

# Pick repo
configs="$(ls -1d "$HOME"/Study/Devman/*/ 2>/dev/null | xargs -n1 basename)"
[ -n "$configs" ] || exit 0

chosen="$(printf '%s\n' $configs | rofi -dmenu -p 'Projects:' -theme "$theme_path")"
[ -n "$chosen" ] || exit 0

dir="$HOME/Обучение/Devman/$chosen"

# Nuke any existing st (since you only use one terminal)
# pkill -x $terminal 2>/dev/null || true
# sleep 0.1
#
# # Launch a clean terminal: attach if exists, else create
# # exec st -e tmux new-session -As "$chosen" -c "$dir" "nvim ."
# exec $terminal -e tmux new-session -As "$chosen" -c "$dir"
(
  sleep 0.5
  pkill -x $terminal 2>/dev/null || true
  sleep 0.5
  $terminal -e tmux new-session -As "$chosen" -c "$dir"
) &
disown
