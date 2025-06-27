#!/bin/bash

# Check if NordVPN is logged in
if ! nordvpn account &>/dev/null; then
    echo "󰍂"  # Not logged in
    exit 0
fi

# Check connection status
STATUS=$(nordvpn status | grep -i "Status" | awk '{print $2}')

if [[ "$STATUS" == "Connected" ]]; then
    echo ""  # Connected icon
else
    echo ""  # Not connected icon
fi
