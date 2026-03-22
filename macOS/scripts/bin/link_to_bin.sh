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

[[ $1 = /* ]] && SRC="$1" || SRC="${PWD}/${1#./}"

if [[ -f $SRC ]]; then
    ln -s "$SRC" ~/"bin/$(basename "$SRC")"
else
    echo "'${SRC}' doesn't exist, is this actually what you meant?"
fi