#!/usr/bin/env bash

##
#: Performs a backup of the specified folders of one volume to my local NAS box.
#:
#: PRECONDITION:
#: 		1. The remote destination contains each of the specified local folders to copy under the /archive directory. For example,
#: 				if the source volume is "Foo", then the remote destination must be named "/archive/Foo".
#: PARAMETERS:
#: 		$1 - base name of the source volume
#:		$2 - THe remote host.  Use ssh format. For example, if user is "bar" and host address is 192.168.1.1 then specify
#:				"bar@192.168.1.1"
#:		$3 - base names of directories in the source volume to copy to the dest volume
#:
#: Author: Fastily
##

src="/Volumes/${1}"
remoteDest="/archive/${1}"
dest="${2}:${remoteDest}"

if [ $# -lt 3 ]; then
	printf "Usage: extSync <SRC_VOLUME_BASENAME> <REMOTE_HOST> <DIRS_TO_COPY...>\n"
    exit 1
fi

if ([ ! -d "$src" ] || ssh "$2" "[ ! -d ${remoteDest} ]"); then
	printf "ERROR: \"%s\" or \"%s\" does not exist!\n" "$src" "$dest"
    exit 1
fi

## fetch target paths as an Array.
shift 2
targets=("$@")

ddss.sh "$src"

for d in "${targets[@]}"; do
	rsync -rltDvhu --progress --delete -e "ssh -T -o Compression=no -x" "${src}/${d}/" "${dest}/${d}"
done

printf "Done!\n"