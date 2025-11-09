#!/usr/bin/env bash
#!/usr/bin/env sh
# echo "DEBUG: Launching polybar at $(date)" >> /tmp/polybar_debug.log

#Old version	
# pkill -9 -x polybar
# pkill -9 -f "polybar/main"
# pkill -9 -f "polybar/secondary"
# sleep 3
# 
# # Ждём, пока они реально завершатся
# while pgrep -x polybar >/dev/null; do sleep 1; done
# 
# # Список активных мониторов
# screens=$(xrandr --listactivemonitors | grep -v "Monitors" | cut -d" " -f6)
# 
# # Если подключён только 1 монитор
# if [[ $(xrandr --listactivemonitors | grep -v "Monitors" | cut -d" " -f4 | cut -d"+" -f2- | uniq | wc -l) == 1 ]]; then
#   MONITOR=$(polybar --list-monitors | cut -d":" -f1) TRAY_POS=right polybar main &
# else
#   # Определяем какой монитор главный
#   primary=$(xrandr --query | grep primary | cut -d" " -f1)
# 
#   for m in $screens; do
#     if [[ $primary == $m ]]; then
#         MONITOR=$m TRAY_POS=right polybar main &
#     else
#         MONITOR=$m TRAY_POS=none polybar secondary &
#     fi
#   done
# fi


#!/usr/bin/env bash

pkill -x polybar
sleep 1

primary=$(xrandr --listactivemonitors | awk '/\*/{print $NF; exit}')
[ -z "$primary" ] && primary=$(xrandr --query | awk '/ connected primary/{print $1; exit}')

for m in $(xrandr --listactivemonitors | awk 'NR>1{print $NF}'); do
  if [[ $m == "$primary" ]]; then
    MONITOR=$m TRAY_POS=right polybar main &
    sleep 0.5
  else
    MONITOR=$m TRAY_POS=none polybar secondary &
  fi
done
