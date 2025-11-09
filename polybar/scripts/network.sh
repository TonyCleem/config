#!/bin/bash

# Активное Ethernet или Wi-Fi подключение
DEVICE=$(nmcli -t -f DEVICE,TYPE,STATE dev status | grep ":ethernet:connected\|:wifi:connected" | head -n1)

# Если нет подключения → ничего не выводим
if [[ -z "$DEVICE" ]]; then
    echo -n ""  # ничего не выводим
    exit 0
fi

DEV_TYPE=$(echo "$DEVICE" | cut -d: -f2)
DEV_NAME=$(echo "$DEVICE" | cut -d: -f1)

if [[ "$DEV_TYPE" == "wifi" ]]; then
    NAME=$(nmcli -t -f NAME,DEVICE con show --active | grep ":$DEV_NAME$" | cut -d: -f1)
    echo "󰖩 $NAME"
elif [[ "$DEV_TYPE" == "ethernet" ]]; then
    IP=$(nmcli -g IP4.ADDRESS dev show "$DEV_NAME" | cut -d/ -f1)
    echo "󰈀 $IP"
fi
