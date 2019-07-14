#!/bin/bash

#: Installs my working environment to ~/bin and sets PATH variable in .profile for ~/bin if needed.
#: Also works as an updater 
#:
#: Tested on Ubuntu 18.04.2
#: Author: Fastily

cd "${0%/*}" &> /dev/null

BINDIR="${HOME}/bin"

printf 'Installing scripts to "%s"\n' "$BINDIR"
mkdir -p "$BINDIR"
cp -f bin/* "${BINDIR}/"

printf "Done!\n"