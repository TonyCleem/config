#!/bin/sh

get_icon() {
  case $1 in
  ## Nerd Icons
  01d) icon="" ;; # Sun (ясный день)
  01n) icon="" ;; # Moon (ясная ночь)
  02d) icon="󰖕" ;; # Cloud-Sun (переменная облачность день)
  02n) icon="󰼱" ;; # Cloud-Moon (переменная облачность ночь)
  03d) icon="" ;; # Cloud (облачно день)
  03n) icon="" ;; # Cloud (облачно ночь)
  04*) icon="" ;; # Cloud (пасмурно)
  09*) icon="󰖖" ;; # Cloud-Rain (ливень)
  10d) icon="󰼳" ;; # Cloud-Sun-Rain (дождь с солнцем)
  10n) icon="" ;; # Cloud-Moon-Rain (дождь с луной)
  11*) icon="󰖓" ;; # Bolt (гроза)
  13*) icon="󰼶" ;; # Snowflake (снег)
  50*) icon="󰖑" ;; # Fog / Smog
  *) icon="" ;;   # Question / неизвестно
  esac

  echo "$icon"
}

KEY="e434b5435a979de6e155570590bee89b"
CITY="Novosibirsk"
UNITS="metric"
SYMBOL="°"
API="https://api.openweathermap.org/data/2.5"

if [ -n "$CITY" ]; then
  if [ "$CITY" -eq "$CITY" ] 2>/dev/null; then
    CITY_PARAM="id=$CITY"
  else
    CITY_PARAM="q=$CITY"
  fi

  weather=$(curl -sf "$API/weather?appid=$KEY&$CITY_PARAM&units=$UNITS")
else
  location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)
  if [ -n "$location" ]; then
    location_lat="$(echo "$location" | jq '.location.lat')"
    location_lon="$(echo "$location" | jq '.location.lng')"
    weather=$(curl -sf "$API/weather?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS")
  fi
fi

if [ -n "$weather" ]; then
  weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
  weather_code=$(echo "$weather" | jq -r ".weather[0].icon")
  weather_icon=$(get_icon "$weather_code")

  echo "$weather_icon $weather_temp$SYMBOL"
fi
