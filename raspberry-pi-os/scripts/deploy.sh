#!/bin/bash

#: Installs/updates my scripts in ~/bin.
#:
#: Author: Fastily

cd "${0%/*}" &> /dev/null

DEST_BIN=~/"bin"

echo "Copying scripts to ${DEST_BIN}..."
for s in bin ../../shared; do
    rsync -avhP "${s}/" "$DEST_BIN"
done

echo "Done!"