#!/usr/bin/env bash

deps() {
    if ! type -p $1 &> /dev/null; then
        echo "'$1' must be installed to run this script."
        exit 126
    fi
}

deps "mpv"
deps "pamixer"

MUSIC_DIR="$HOME/files/music"

help() {
    cat <<_EOF
Play music.

usage:
    
    music <command>

commands:

    play   Play all files in: $MUSIC_DIR

    stop   Stop music.

    help   Print help.
_EOF
}

case "$1" in
    help)
        help
        ;;
    play)
        swaymsg exec "mpv --volume=50 --playlist=$MUSIC_DIR/playlist.txt"
        ;;
    stop)
        kill -9 $(pgrep mpv)
        ;;
    *)
        help 
        ;;
esac
