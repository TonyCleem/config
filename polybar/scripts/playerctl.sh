#!/bin/bash
status=$(playerctl status 2>/dev/null)
  [ "$status" = "Playing" ] && echo " " || echo " "

