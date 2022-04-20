#!/bin/bash

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
    state=$(nmcli con|grep "OpenVPN"|awk -F' ' '{print $4}')
    [ $state = "--" ] && echo 0 || echo 1
}

function toggle() {
    if [ $(is_up) -eq 1 ]
    then
        nmcli con down id OpenVPN
    else
        nmcli con up id OpenVPN
    fi
}

if [ "$1" == "toggle" ]
then
    toggle
else
    [ $(nmcli con|grep "OpenVPN" | wc -l ) -eq 1 ] || error COUNT
    [ $(is_up) -eq 1 ] && connected || disconnected
fi
