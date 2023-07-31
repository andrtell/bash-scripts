#!/bin/env sh

help() {
    cat <<_EOF

    Show battery capacity

    usage:

      power <command> 

    commands:

      show    show battery capacity (default command)

      help    print help

_EOF
}

case "$1" in
    help)
        help
        ;;
    *)
        CAPACITY="$(cat /sys/class/power_supply/BAT0/capacity)%"
        LEVEL="$(cat /sys/class/power_supply/BAT0/capacity_level)"
	echo "$CAPACITY ($LEVEL)"
        ;;
esac


