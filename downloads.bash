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
    usage:

        downloads ls
        downloads cp [dest]
        downloads mv [dest]
        
        downloads find
        downloads 
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
        cp "$(downloads.bash find)" $DEST
        ;;
    mv)
        DEST="${2:-.}"
        mv "$(downloads.bash find)" $DEST
        ;;
    find)
        echo $DOWNLOADS/$(ls -1 $DOWNLOADS | fzf)
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
