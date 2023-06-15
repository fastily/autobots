#!/usr/bin/env bash

##
#: Performs a backup of the specified folders in one volume to another volume on the same machine.
#:
#: PRECONDITION:
#: 		1. The destination volume must share the same base name as the source volume, but followed by a 2. For example,
#: 				if the source volume is "Foo", then the DEST volume must be named "Foo2".
#: PARAMETERS:
#: 		$1 - base name of the source volume
#:		$2 - base names of directories in the source volume to copy to the DEST volume
#:
#: Author: Fastily
##

SRC="/Volumes/${1}"
DEST="${SRC}2"


if (( $# < 2 )); then
    echo "Usage: ${0##*/} <SRC_VOLUME_BASENAME> <DIRS_TO_COPY...>"
    exit 1
elif [[ ! -d $SRC ]] || [[ ! -d $DEST ]]; then
    echo "[ERROR]: '${SRC}' or '${DEST}' does not exist!"
    exit 1
fi

ddss.sh "$SRC"
set -e

shift
for d in "$@"; do
    rsync -avhP --delete "${SRC}/${d}/" "${DEST}/${d}"
done

echo "Done!"