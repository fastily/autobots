#!/usr/bin/env bash

##
#: Simple deploy script, copies my custom scripts to the home directory bin.
#:
#: Author: Fastily
##

cd "${0%/*}" &> /dev/null

echo "Copying scripts to bin"
mkdir -p ~/bin
cp -p -f bin/* ~/bin/
chflags hidden ~/bin

echo "Copying bash profile"
cp bash_profile.sh ~/.bash_profile

echo "Done!"