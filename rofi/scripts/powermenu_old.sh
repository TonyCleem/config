#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Paths / theme
dir="$HOME/.config/rofi/powermenu"
theme="powermenu"

# CMDs
uptime="$(uptime -p | sed -e 's/up //g')"

# Options (icons)
shutdown=''
reboot=''
suspend=''
logout=''
lock=''
yes=''
no=''

# Rofi menu
rofi_cmd() {
    rofi -dmenu \
        -p "Exit" \
        -mesg "Uptime: $uptime" \
        -theme "${dir}/${theme}.rasi"
}


# Confirmation
confirm_cmd() {
    rofi -dmenu \
        -p 'Confirmation' \
        -mesg 'Are you sure?' \
        -theme "${dir}/confirm"
}

confirm_exit() {
    echo -e "${yes}\n${no}" | confirm_cmd
}

# Menu
run_rofi() {
    echo -e "${shutdown}\n${reboot}\n${suspend}\n${logout}\n${lock}" | rofi_cmd
}

# Execute actions
run_cmd() {
    local selected
    selected="$(confirm_exit)"

    [[ "$selected" == "$yes" ]] || return 0

    case "$1" in
        shutdown) systemctl poweroff ;;
        reboot)   systemctl reboot ;;
        suspend)
            command -v mpc >/dev/null && mpc -q pause || true
            command -v amixer >/dev/null && amixer set Master mute || true
            systemctl suspend
            ;;
        logout)   i3-msg exit ;;
    esac
}

# Main
case "$(run_rofi)" in
    "$shutdown") run_cmd shutdown ;;
    "$reboot")   run_cmd reboot ;;
    "$suspend")  run_cmd suspend ;;
    "$logout")   run_cmd logout ;;
    "$lock")     "$HOME/.config/i3/scripts/lock" ;;
esac
