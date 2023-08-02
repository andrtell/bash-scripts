#!/bin/env bash

help() {
    cat <<_EOF
Move file to the $HOME/files/zap directory.

usage:

  zap <file>
_EOF
}

(( $# < 1 )) && {
    help
    exit 126
}

DIR="$HOME/files/zap/$(/bin/date +'%Y/%m/%d')"
mkdir -p $DIR
mv "$@" $DIR
