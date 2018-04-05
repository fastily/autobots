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

## include home bin in path
if [[ ":$PATH:" != *"$BINDIR"* ]]; then
	printf "Updating PATH with script directory\n"
	printf "\nPATH=\$PATH:${BINDIR}" >> ~/.profile
fi

## install update/upgrade alias if it does not exist
if ! grep -q 'uuu' ~/.profile ; then 
	printf "Installing uuu alias into .profile\n"
	printf '\nalias uuu="sudo apt update && sudo apt upgrade -y"' >> ~/.profile
fi

printf "Done!\n"