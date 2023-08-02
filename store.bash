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
Stores directory files utility script.

usage:
    
    store <command>

commands:

    [file]        Move file to the store.

    ls            List files in store.
    cp [dest]     Copy file FROM store to [dest].
    mv [dest]     Move file FROM store to [dest].

    find          Find file in store.
    empty         Is store empty?

    help          Print help.
_EOF
}

STORE="$HOME/files/store"

case "$1" in
    help)
        help
        ;;
    ls)
        if [[ $(store.bash empty) == "YES" ]]; then
            echo "EMPTY"
        else
            ls -l $STORE
        fi
        ;;
    cp)
        DEST="${2:-.}"
        SRC="$(store.bash find)"
        if [[ "$SRC" != "NOT FOUND" ]]; then
            rsync $SRC $DEST
        fi
        ;;
    mv)
        DEST="${2:-.}"
        SRC="$(store.bash find)"
        if [[ "$SRC" != "NOT FOUND" ]]; then
            mv $SRC $DEST
        fi
        ;;
    find)
        FILE="$STORE/$(ls -1 $STORE | fzf)"
        if [[ -f "$FILE" ]]; then
            echo "$FILE"
        else
            echo "NOT FOUND"
        fi
        ;;
    empty)
        if [[ -z "$(ls -A $STORE)" ]]; then
            echo "YES"
        else
            echo "NO"
        fi
        ;;
    *)
        if [[ -z "$1" ]]; then
            store.bash help
        elif [[ ! -f "$1" ]]; then
            echo "FILE '$1' NOT FOUND"
        else
            rsync $1 "$STORE/"
        fi
        ;;
esac
