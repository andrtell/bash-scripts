#!/bin/env bash

deps() {
    if ! type -p $1 &> /dev/null 
    then
        echo "'$1' must be installed to run this script."
        exit 126
    fi
}

deps "brightnessctl"
deps "bc"

help() {
    cat <<_EOF

    Adjust the screen brightness.

    usage: 

    shine <command> [<arg> ...]

    brightness:

    set   <brightness>    set the brightness (0-100)
    get                   get the brightness

    help                  print help

_EOF
}

(( $# < 1 )) && {
    help
    exit 126
}

case "$1" in
    set)
        sudo brightnessctl -q s "$2%"
        ;;
    get)
        echo "scale=1; ($(brightnessctl g) / $(brightnessctl m)) * 100" | bc
        ;;
    help)
        help
        ;;
    *)
        help
        exit 126
        ;;
esac

