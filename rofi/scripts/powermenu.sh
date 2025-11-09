#!/usr/bin/env bash

# i3 Power Menu

# Rofi Theme
theme='~/.config/rofi/powermenu/powermenu'

# Options
shutdown=' Shutdown'
reboot=' Reboot'
lock=' Lock'
suspend=' Suspend'
logout=' Logout'

# Rofi CMD
run_rofi() {
    echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | \
rofi -dmenu -p "Uptime: $(uptime -p | sed -e 's/up //g')" -theme ${dir}/${theme}.rasi
}

# Execute Command
chosen="$(run_rofi)"
case "$chosen" in
    "$shutdown") systemctl poweroff ;;
    "$reboot")   systemctl reboot ;;
    "$lock")     "$HOME/.config/i3/scripts/lock" ;;
    "$suspend")
        mpc -q pause
        amixer set Master mute
        systemctl suspend
        ;;
    "$logout")   i3-msg exit ;;
esac
    "$shutdown") run_cmd shutdown ;;
    "$reboot")   run_cmd reboot ;;
    "$suspend")  run_cmd suspend ;;
    "$logout")   run_cmd logout ;;
    "$lock")     "$HOME/.config/i3/scripts/lock" ;;
esac


