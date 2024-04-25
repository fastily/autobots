#!/usr/bin/env bash

##
#: Simple deploy script, copies my custom scripts to the home directory bin.
#:
#: Author: Fastily
##

cd "${0%/*}" &> /dev/null

DEST_BIN=~/"bin"

echo "Copying scripts to ${DEST_BIN}..."
for s in bin ../../shared/scripts; do
    rsync -avhP "${s}/" "$DEST_BIN"
done

chflags hidden "$DEST_BIN"

echo "Copying .bash_profile"
cp bash_profile.sh ~/.bash_profile

echo "Done!"