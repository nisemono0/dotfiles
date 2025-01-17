#!/bin/bash

get_icon() {
    case $1 in
        # Icons
        01d) icon="";;
        01n) icon="";;
        02d) icon="";;
        02n) icon="";;
        03*) icon="";;
        04*) icon="";;
        09*) icon="";;
        10*) icon="";;
        11*) icon="";;
        13*) icon="";;
        50*) icon="";;
        *) icon="";
    esac
    echo $icon
}

# https://home.openweathermap.org/api_keys
KEY=""
# Optional
CITY=""
UNITS="metric"
SYMBOL="°C"

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
    if [ "$weather_temp" = "-0" ]; then
        weather_temp="0"
    fi
    weather_icon_temp=$(echo "$weather" | jq -r ".weather[0].icon")
    weather_icon="$(get_icon "$weather_icon_temp")"
    echo "$weather_temp$SYMBOL$weather_icon"
fi
