#!/usr/bin/env bash

echo -n "This rename all files in the current directory ($(pwd)). Are you sure? [y/n]: "

read ANSWER

if [[ "$ANSWER" == "y" ]]; then
    perl-rename 'y/A-Z/a-z/' *
    perl-rename 'y/-/_/' *
    perl-rename 's/ /_/' *
    perl-rename 's/___/__/' *
    perl-rename 's/\._/_/' *
fi

