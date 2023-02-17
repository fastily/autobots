#!/usr/bin/env bash

##
#: Back up the Public folder on my dev server to a local hard drive.
#:
#: PRECONDITIONS:
#:      1. The dev server is accessible and the local hard drive, Other, is plugged in.
#:
#: Author: Fastily
##

set -e

dest="/Volumes/Other/Preserve/Dev-Public"

if [ ! -d "$dest" ]; then
    echo "'${dest}' does not exist, abort."
    exit 1
fi

rsync -avhuP --delete -e "ssh -T -o Compression=no -x" "fastily@dev:Public/" "$dest"