#!/bin/env bash

# Original source: https://github.com/lukrop/xbps-pkg/blob/master/pkg

deps() { 
    if ! type -p $1 &> /dev/null 
    then
        echo "'$1' must be installed to run this script."
        exit 126
    fi
}

deps "xbps-alternatives"
deps "xbps-install"
deps "xbps-pkgdb"
deps "xbps-query"
deps "xbps-query"
deps "xbps-reconfigure"
deps "xbps-remove"
deps "xbps-rindex"

help() {
    cat <<_EOF
Wrapper around the Void-linux 'xbps' suit of commands.

usage:

    pack <command> [<arg> ...]

commands:

    add      <package>              Add package.
    remove   <package>              Remove package.
    upgrade  <package>              Upgrade package.

    upgrade                         Upgrade ALL packages.

    files    <package>              List files in a package.
    info     <package>              Show package info.

    deps     <package>              List package dependencies.
    revdeps  <package>              List packages which depends on package.

    hold     <package>              Hold package.
    unhold   <package>              Unhold package.

    search   <package>              Search for package.
    which    <file>                 Show package with file.

    installed                       List installed packages.
    orphans                         List orphaned packages.

    clean                           Remove obsolete packages from cache.

    db            [<arg> ...]       Wraps 'xbps-pkgdb'.
    alternatives  [<arg> ...]       Wraps 'xbps-alternatives'.
    query         [<arg> ...]       Wraps 'xbps-query'.
    reconfigure   [<arg> ...]       Wraps 'xbps-reconfigure'.
    rindex        [<arg> ...]       Wraps 'xbps-rindex'.

    help                            Print help.
_EOF
}

(( $# < 1 )) && {
    help
    exit 126
}

case "$1" in
    help)
        help
        ;;
    installed)
        shift; sudo xbps-query -l
        ;;
    add)
        shift; sudo xbps-install -S "$@"
        ;;
    remove)
        shift; sudo xbps-remove "$@"
        ;;
    search)
        shift; xbps-query -Rs "$@"
        ;;
    upgrade)
        shift; sudo xbps-install -Su "$@"
        ;;
    info)
        shift; xbps-query "$@"
        ;;
    which)
        shift; xbps-query -o "$@"
        ;;
    files)
        shift; xbps-query -f "$@"
        ;;
    clean)
        shift; sudo xbps-remove -O "$@"
        ;;
    hold)
        shift; xbps-pkgdb -m hold "$@"
        ;;
    unhold)
        shift; xbps-pkgdb -m unhold "$@"
        ;;
    deps)
        shift; xbps-query -Rx "$@"
        ;;
    revdeps)
        shift; xbps-query -RX "$@"
        ;;
    orphans)
        shift; xbps-query -O "$@"
        ;;
    db)
        shift; xbps-pkgdb "$@"
        ;;
    alternatives)
        shift; xbps-alternatives "$@"
        ;;
    query)
        shift; xbps-query -Rs "$@"
        ;;
    reconfigure)
        shift; xbps-reconfigure "$@"
        ;;
    rindex)
        shift; xbps-rindex "$@"
        ;;
    help)
        help
        ;;
    *)
        help
        exit 126
        ;;
esac
