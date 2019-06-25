#!/bin/bash

#: Installs my working environment to ~/bin and sets PATH variable in .profile for ~/bin if needed.
#: Also works as an updater 
#:
#: Tested on Ubuntu Server 16.10.
#: Author: Fastily

cd "${0%/*}" &> /dev/null

BINDIR="${HOME}/bin"

printf 'Installing scripts to "%s"\n' "$BINDIR"

mkdir -p "$BINDIR"
cp -f bin/* "${BINDIR}/"

## install update/upgrade alias if it does not exist
BASHALIASES="${HOME}/.bash_aliases"
touch "$BASHALIASES"

if ! grep -q 'uuu' "$BASHALIASES" ; then 
	printf '\nalias uuu="sudo apt update && sudo apt upgrade -y"' >> "$BASHALIASES"
	printf '\nalias aaa="sudo apt autoclean && sudo apt autoremove -y"' >> "$BASHALIASES"
fi

printf "Done!\n"