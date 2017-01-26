#!/bin/bash

#: Installs my working environment to ~/bin and sets PATH variable in .profile for ~/bin if needed.
#: Also works as an updater 
#:
#: Tested on Ubuntu Server 16.10.
#: Author: Fastily

cd "${0%/*}" &> /dev/null

BINDIR="${HOME}/bin"

printf "Installing scripts to ~/bin\n"

mkdir -p "$BINDIR"
cp -Rf scripts/* "${BINDIR}/"

if [[ ":$PATH:" != *"$BINDIR"* ]]; then
	printf "Updating PATH with script directory\n"
	touch ~/.profile
	printf "\nPATH=\$PATH:${BINDIR}" >> ~/.profile
fi

printf "Done!\n"
