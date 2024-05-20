#!/usr/bin/env bash

##
#: Simple deploy script, copies my custom scripts to the home directory bin.
#:
#: Author: Fastily
##

cd "${0%/*}" &> /dev/null
set -e

DEST_BIN=~/"bin"
for s in bin ../../shared/scripts; do
    rsync -avhP "${s}/" "$DEST_BIN"
done
chflags hidden "$DEST_BIN"

rsync -avhP "./bash_profile.sh" ~/".bash_profile"

echo "Done!"