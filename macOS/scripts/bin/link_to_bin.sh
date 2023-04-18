#!/usr/bin/env bash

##
#: Symlinks the specified binary into ~/bin
#:
#: Author: Fastily
##

if [[ -z $1 ]]; then
    echo "[ERROR]: Missing target to symlink into ~/bin"
    exit 1
fi

SRC="$([[ $1 = /* ]] && echo "$1" || echo "${PWD}/${1#./}")"

if [[ ! -f $SRC ]]; then
    echo "'${SRC}' doesn't exist, is this actually what you meant?"
else
    ln -s "$SRC" ~/"bin/$(basename "$SRC")"
fi