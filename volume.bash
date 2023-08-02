#!/bin/env bash

deps() {
    if ! type -p $1 &> /dev/null 
    then
        echo "'$1' must be installed to run this script."
        exit 126
    fi
}

deps "pamixer"

help() {
    cat <<_EOF
Adjust the volume.

usage: 

    volume <command> [<arg> ...]

commands:

    set   <volume>  Set the sound volume (0-100).
    get             Get the sound volume.

    mute            Mute sound.
    unmute          Unmute sound.

    help            Print help.
_EOF
}

(( $# < 1 )) && {
    help
    exit 0
}

case "$1" in
    set)
        pamixer --set-volume $2
        ;;
    get)
        echo "$(pamixer --get-volume)%"
        ;;
    mute)
        pamixer -m
        ;;
    unmute)
        pamixer -u
        ;;
    help)
        help
        ;;
    *)
        help
        exit 126
        ;;
esac

