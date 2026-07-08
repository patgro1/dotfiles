#!/bin/bash

# Your physical interfaces in priority order
INTERFACES=("wlp0s20f3" "enp46s0" "enp39s0" "enx605b3038ed0a" "enx605b302142ca", "enp8s0")

get_network_status() {
    # Check each interface in priority order
    for interface in "${INTERFACES[@]}"; do
        # Skip if interface doesn't exist
        if ! ip link show "$interface" >/dev/null 2>&1; then
            continue
        fi
        
        # Check if interface is up and has an IP
        if ip link show "$interface" | grep -q "state UP"; then
            local ip_addr=$(ip addr show "$interface" 2>/dev/null | grep -E "inet [0-9]" | head -1 | awk '{print $2}' | cut -d'/' -f1)
            
            if [ -n "$ip_addr" ]; then
                # Determine if it's WiFi or Ethernet
                if [[ "$interface" == wl* ]]; then
                    # Get WiFi SSID
                    local ssid=$(iwgetid -r "$interface" 2>/dev/null)
                    if [ -n "$ssid" ]; then
                        # Get signal strength
                        local signal=$(iwconfig "$interface" 2>/dev/null | grep -o "Signal level=-[0-9]*" | grep -o "\-[0-9]*" | tr -d '-')
                        local signal_icon="📶"
                        if [ -n "$signal" ] && [ "$signal" -lt 50 ]; then
                            signal_icon="📶"
                        elif [ -n "$signal" ] && [ "$signal" -lt 70 ]; then
                            signal_icon="📶"
                        fi
                        echo "{\"text\": \"📶 $ssid\"}"
                        return
                    fi
                else
                    # Ethernet connection
                    echo "{\"text\": \"🌐 $ip_addr\"}"
                    return
                fi
            fi
        fi
    done
    
    # No active connection found
    echo "{\"text\": \"  Disconnected\"}"
}

get_network_status
