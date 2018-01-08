#!/bin/bash

##
#: Performs a backup of the specified folders in one volume to another volume on the same machine.
#:
#: PRECONDITION:
#: 		1. The destination volume must share the same base name as the source volume, but followed by a 2. For example,
#: 				if the source volume is "Foo", then the dest volume must be named "Foo2".
#: PARAMETERS:
#: 		$1 - base name of the source volume
#:		$2 - base names of directories in the source volume to copy to the dest volume
#:
#: Author: Fastily
##

src="/Volumes/${1}"
dest="/Volumes/${1}2"

if [ $# -lt 2 ]; then
	printf "Usage: localSync <SRC_VOLUME_BASENAME> <DIRS_TO_COPY...>\n"
    exit 1
fi

if [ ! -d "$src" ] || [ ! -d "$dest" ]; then
	printf "ERROR: \"%s\" or \"%s\" does not exist!\n" "$src" "$dest"
    exit 1
fi

## fetch target paths as an Array.
shift
targets=("$@")

ddss.sh "$src"

for d in "${targets[@]}"; do
	rsync -avhn --progress --delete "${1}/${d}/" "${dest}/${d}"
done

printf "Done!\n"