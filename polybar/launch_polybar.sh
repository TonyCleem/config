# Kill and relaunch polybar
killall -q polybar

while pgrep -u $UID -x polybar > /dev/null; do sleep 2; done


if [[ $(xrandr -q | grep "${EXTERNAL_MONITOR} connected") ]]; then
  polybar --reload primary -c ~/.config/polybar/config.ini </dev/null >/var/tmp/polybar-primary.log 2>&1 200>&- &
  polybar --reload secondary -c ~/.config/polybar/config.ini </dev/null >/var/tmp/polybar-secondary.log 2>&1 200>&- &
else
  polybar --reload primary -c ~/.config/polybar/config.ini </dev/null >/var/tmp/polybar-primary.log 2>&1 200>&- &
fi
