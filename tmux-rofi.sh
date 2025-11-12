#!/bin/sh
set -eu

terminal="kitty"
theme_path="$HOME/.config/rofi/power-profiles.rasi"

sessions="$(tmux list-sessions -F '#S' 2>/dev/null || true)"
[ -n "${sessions}" ] || exit 0

rofi_pick_session() {
  if command -v rofi >/dev/null 2>&1; then
    rofi -dmenu -i -p 'tmux sessions:' -lines 10 -theme "$theme_path" \
      -kb-row-down "Down,Control+n,j" -kb-row-up "Up,Control+p,k"
  else
    dmenu -i -vi -c -bw 3 -l 10 -h 30 -F -p 'tmux sessions:'
  fi
}

chosen="$(printf '%s\n' "$sessions" | rofi_pick_session)"
[ -n "$chosen" ] || exit 0

# Если уже в tmux — просто переключаемся
if [ "${TMUX-}" ]; then
  exec tmux switch-client -t "${chosen}"
fi

# Если есть активный клиент kitty — переключаем его
client_tty="$(
  tmux list-clients -F '#{client_tty} #{client_termname}' 2>/dev/null |
    awk '$2 ~ /^kitty/ { print $1; exit }' || true
)"

if [ -n "${client_tty}" ]; then
  tmux switch-client -c "${client_tty}" -t "${chosen}"
  exit 0
fi

# Убиваем все kitty и запускаем новый — безопасно
(
  sleep 0.5
  pkill -x $terminal 2>/dev/null || true
  sleep 0.5
  $terminal -e tmux attach -t "${chosen}"
) &
disown
