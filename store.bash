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

        store ls
        store cp [dest]
        store mv [dest]
        
        store find
        store empty

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
             cp $SRC $DEST
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
        help
        ;;
esac
