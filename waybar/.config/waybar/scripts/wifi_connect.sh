#!/bin/bash

STATE=$(nmcli -t -f STATE general)
CURRENT_SSID=$(nmcli -t -f NAME,DEVICE,TYPE connection show --active | head -n1 | cut -d: -f1)

if [ "$STATE" = "connected" ] && [ -n "$CURRENT_SSID" ]; then
  echo "You are currently connected to '$CURRENT_SSID'. What do you want to do?"
  echo "1) Disconnect from current network"
  echo "2) Connect to another network"
  echo "3) Do nothing"
  read -p "Choose an option (1, 2, or 3): " choice
  if [ "$choice" = "1" ]; then
    nmcli connection down "$CURRENT_SSID"
    echo "Disconnected from '$CURRENT_SSID'."
    exit 0
  fi
  if [ "$choice" = "3" ]; then
    exit 0
  fi
else
  echo "You are currently disconnected."
fi

echo "Scanning for wifi networks..."
nmcli -t -f SSID device wifi list | sort | uniq

read -p "Enter network SSID you want to connect to: " SSID

echo "Connecting to $SSID..."
nmcli device wifi connect "$SSID" --ask

# Check connection
if [ $? -eq 0 ]; then
  echo "Connected to $SSID successfully!"
  echo "For public Wi-Fi with captive portal, open a browser to accept terms & conditions."
  exit 0
else
  echo "Failed to connect. Check password or network availability."
  read -p "Press enter to exit."
  exit 1
fi
