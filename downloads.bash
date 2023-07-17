#!/bin/env bash

deps() {
    if ! type -p $1 &> /dev/null; then
        echo "'$1' must be installed to run this script."
        exit 126
    fi
}

deps "fzf"

help() {
    cat <<_EOF

    Downloads directory files utility script.

    usage:
        
        downloads ls
        downloads cp [dest]
        downloads mv [dest]

        downloads clean
        
        downloads find
        downloads empty

        downloads help

_EOF
}

DOWNLOADS="$(xdg-user-dir DOWNLOAD)"

case "$1" in
    help)
        help
        ;;
    ls)
        if [[ $(downloads.bash empty) == "YES" ]]; then
            echo "EMPTY"
        else
            ls -l $DOWNLOADS
        fi
        ;;
    cp)
        DEST="${2:-.}"
        SRC="$(downloads.bash find)"
        if [[ "$SRC" != "NOT FOUND" ]]; then
             cp $SRC $DEST
        fi
        ;;
    mv)
        DEST="${2:-.}"
        SRC="$(downloads.bash find)"
        if [[ "$SRC" != "NOT FOUND" ]]; then
            mv $SRC $DEST
        fi
        ;;
    clean)
        echo -n "This will remove all files in the download ($DOWNLOADS) directory. Are you sure? [y/n]: "
        read ANSWER
        if [[ "$ANSWER" == "y" ]]; then
            rm -rf $DOWNLOADS/*
        fi
        ;;
    find)
        FILE="$DOWNLOADS/$(ls -1 $DOWNLOADS | fzf)"
        if [[ -f "$FILE" ]]; then
            echo "$FILE"
        else
            echo "NOT FOUND"
        fi
        ;;
    empty)
        if [[ -z "$(ls -A $DOWNLOADS)" ]]; then
            echo "YES"
        else
            echo "NO"
        fi
        ;;
    *)
        help
        ;;
esac
