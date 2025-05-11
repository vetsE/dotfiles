#!/bin/bash

# Name of your VPN connection as configured in NetworkManager
VPN_NAME="OpenVPN"

# Check if the VPN connection exists
check_vpn_exists() {
    if ! nmcli connection show | grep -q "$VPN_NAME"; then
        echo '{"text": "VPN: Not Found", "class": "error", "tooltip": "VPN connection '"$VPN_NAME"' does not exist"}'
        exit 1
    fi
}

# Toggle the VPN connection
toggle_vpn() {
    check_vpn_exists
    
    # Check if the VPN is currently active
    if nmcli -t -f TYPE,STATE,NAME connection show --active | grep -q "vpn:activated:$VPN_NAME"; then
        # If active, disconnect
        if nmcli connection down "$VPN_NAME"; then
            echo '{"text": "VPN: Down", "class": "disconnected"}'
        else
            echo '{"text": "VPN: Error", "class": "error", "tooltip": "Failed to disconnect from '"$VPN_NAME"'"}'
        fi
    else
        # If inactive, connect
        if nmcli connection up "$VPN_NAME"; then
            # Verify that the connection was successful (give it a moment to connect)
            sleep 2
            if nmcli -t -f TYPE,STATE,NAME connection show --active | grep -q "vpn:activated:$VPN_NAME"; then
                echo '{"text": "VPN: Up", "class": "connected"}'
            else
                echo '{"text": "VPN: Failed", "class": "error", "tooltip": "Connection attempt completed but VPN is not active"}'
            fi
        else
            echo '{"text": "VPN: Error", "class": "error", "tooltip": "Failed to connect to '"$VPN_NAME"'"}'
        fi
    fi
}

# Show the current VPN status
show_status() {
    check_vpn_exists
    
    # Check if the VPN is currently active
    if nmcli -t -f TYPE,STATE,NAME connection show --active | grep -q "vpn:activated:$VPN_NAME"; then
        # Get the device name for additional info
        VPN_DEVICE=$(nmcli -t -f DEVICE connection show --active "$VPN_NAME" | head -1)
        echo '{"text": "VPN: Up", "class": "connected", "tooltip": "Connected to '"$VPN_NAME"' via '"$VPN_DEVICE"'"}'
    else
        echo '{"text": "VPN: Down", "class": "disconnected", "tooltip": "VPN is disconnected"}'
    fi
}

# Main script logic
case "$1" in
    toggle)
        toggle_vpn
        ;;
    status|"")
        show_status
        ;;
    *)
        echo "Usage: $0 [toggle|status]"
        exit 1
        ;;
esac
