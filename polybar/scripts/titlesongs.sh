#!/bin/bash

PLAYER="playerctld"
FORMAT="{{title}} - {{artist}}"

status=$(playerctl --player=$PLAYER status 2>/dev/null || echo "No player")

case "$1" in
  --status)
    echo "$status"
    ;;
  *)
    if [[ "$status" == "Playing" || "$status" == "Paused" ]]; then
      playerctl --player=$PLAYER metadata --format "$FORMAT"
    else
      echo ""
    fi
    ;;
esac
