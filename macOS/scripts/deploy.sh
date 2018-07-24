#!/usr/bin/env bash

##
#: Simple deploy script, copies my custom scripts to the home directory bin.
#:
#: Author: Fastily
##

cd "${0%/*}" &> /dev/null

printf "Copying scripts to bin\n"

mkdir -p ~/bin
cp -f bin/* ~/bin/
chflags hidden ~/bin

printf "Copying bash profile\n"
cat bash_profile.sh > ~/.bash_profile

printf "Done!\n"