#!/bin/sh

BAT1=/sys/class/power_supply/BAT1
BAT2=/sys/class/power_supply/BAT2
CRIT=${1:-15}

FILE="$HOME/.config/waybar/scripts/notified"

# Read capacity and status
perc1=$(cat "$BAT1/capacity")
perc2=$(cat "$BAT2/capacity")
stat1=$(cat "$BAT1/status")
stat2=$(cat "$BAT2/status")

# Compute average percentage
perc=$(( (perc1 + perc2) / 2 ))

# Check if either battery is discharging
if { [ "$stat1" = "Discharging" ] || [ "$stat2" = "Discharging" ]; } && [ "$perc" -le "$CRIT" ]; then
  if [ ! -f "$FILE" ]; then
    notify-send --urgency=critical --icon=dialog-warning "Battery Low" "Average charge: $perc%"
    touch "$FILE"
  fi
elif [ -f "$FILE" ]; then
  rm "$FILE"
fi
