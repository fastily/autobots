#!/bin/bash

#: Installs autobots ffmpeg scripts to ~/scripts and creates a new PATH entry in bash_profile for ~/scripts
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
