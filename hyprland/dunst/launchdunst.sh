#!/bin/sh
set -a
source "$HOME/.cache/wal/colors.sh"
set +a

pkill dunst
dunst \
  -frame_color "$color7" \
  -lf "$color7" \
  -lb "$color0" \
  -lfr "$color2" \
  -nf "$color7" \
  -nb "$color0" \
  -nfr "$color2" \
  -cf "$color1" \
  -cb "$color0" \
  -cfr "$color1" &
