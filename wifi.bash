#!/bin/env bash

deps() {
    if ! type -p $1 &> /dev/null 
    then
        echo "'$1' must be installed to run this script."
        exit 126
    fi
}

deps "awk"
deps "ip"
deps "iwctl"
deps "rfkill"

help() {
    cat <<_EOF
Manage the WIFI.

usage: 

    wifi <command> [<arg> ...]

commands:

    connect <ssid>    Connect to a WIFI network.
    disconnect        Disconnect from the WIFI network.

    status            Show WIFI status.

    block             Block WIFI.
    unblock           Unblock WIFI.

    config            List WIFI config files.

    help              Print help.
_EOF
}

# NETWORK_DEVICE=${NETWORK_DEVICE:-"wlp0s20f3"}
NETWORK_DEVICE=${NETWORK_DEVICE:-"wlan0"}

(( $# < 1 )) && {
    help
    exit 0
}

case "$1" in
    connect)
        (( $# < 2 )) && {
            echo "A WIFI <ssid> is required."
            exit 126
        }
        shift;
        iwctl station $NETWORK_DEVICE connect "$*"
        ;;
    disconnect)
        iwctl station $NETWORK_DEVICE disconnect
        ;;
    status)
        iwctl station $NETWORK_DEVICE show
        ;;
    scan)
        iwctl station $NETWORK_DEVICE scan
        iwctl station $NETWORK_DEVICE get-networks
        ;;
    block)
        sudo rfkill block wlan
        ;;
    unblock)
        sudo rfkill unblock wlan
        ;;
    config)
        ls -l /etc/iwd/main.conf
        sudo bash -c 'ls -l /var/lib/iwd/*'
        ;;
    help)
        help
        ;;
    *)
        help
        exit 126
        ;;
esac
