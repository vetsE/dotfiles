#!/bin/bash

FILE_LOCATION="${HOME}/Downloads/OpenVPN.ovpn"

function error() {
    echo "%{F#f00}VPN $1%{F-}"
}

function connected() {
    echo "%{F#0F0}VPN  ON%{F-}"
}

function disconnected() {
    echo "%{F#FDF}VPN OFF%{F-}"
}

function busy() {
    echo "%{F#000}...%{F-}"
}

function is_up() {
    state=$(nmcli con | grep "OpenVPN" | awk -F' ' '{print $4}') || exit 1
    [ $state = "--" ] && echo 0 || echo 1
}

function toggle() {
    if [ $(is_up) -eq 1 ]; then
        nmcli con down id OpenVPN
    else
        nmcli con up id OpenVPN
    fi
}

function setup() {
    [ ! -e "$FILE_LOCATION" ] && exit 1
    echo "setup"
    sed -i 's/or-highest//' "$FILE_LOCATION"
    # nmcli con down id OpenVPN
    nmcli con delete OpenVPN
    nmcli_output=$(nmcli connection import type openvpn file "$FILE_LOCATION" | grep -i "successfully added")
    if [ -z "$nmcli_output" ]; then
        echo "Import of $1 failed !"
        exit 1
    fi
    nmcli connection modify OpenVPN ipv4.never-default yes
    echo "Imported successfully!"
}

[ "$1" == "toggle" ] && toggle
[ "$1" == "setup" ] && setup

[ $(nmcli con | grep "OpenVPN" | wc -l) -eq 1 ] || error COUNT
[ $(is_up) -eq 1 ] && connected || disconnected
