#!/bin/sh

DEFAULT=$(pactl info | awk -F': ' '/Default Sink/ {print $2}')
VOL=$(pactl get-sink-volume "$DEFAULT" | awk '{print $5}' | head -n1)
DEVICE=$(pactl list short sinks | grep "$DEFAULT" | awk '{print $2}')

ICON=""
if [ "${VOL%\%}" -gt 30 ]; then ICON=""; fi
if [ "${VOL%\%}" -gt 70 ]; then ICON=""; fi

echo "{\"text\": \"$VOL $ICON\", \"tooltip\": \"$DEVICE\"}"