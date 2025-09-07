#!/bin/bash

# VPN connection name
VPN_NAME="VPN Enyx"

# Check if VPN is connected
check_vpn_status() {
    if nmcli connection show --active | grep -q "$VPN_NAME"; then
        echo "connected"
    else
        echo "disconnected"
    fi
}

# Toggle VPN connection
toggle_vpn() {
    status=$(check_vpn_status)
    if [ "$status" = "connected" ]; then
        nmcli connection down "$VPN_NAME"
    else
        nmcli connection up "$VPN_NAME"
    fi

    # Force waybar update
    pkill -SIGRTMIN+8 waybar
}

# Handle command line arguments
case "$1" in
    "toggle")
        toggle_vpn
        ;;
    *)
        status=$(check_vpn_status)
        if [ "$status" = "connected" ]; then
            echo '{"text": "󰒘", "tooltip": "VPN Connected: '"$VPN_NAME"'", "class": "connected"}'
        else
            echo '{"text": "󰦞", "tooltip": "VPN Disconnected: '"$VPN_NAME"'", "class": "disconnected"}'
        fi
        ;;
esac
