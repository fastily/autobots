#!/usr/bin/env bash

##
#: Perform a backup of the specified folders on an external hard drive attached to my computer to my local NAS.
#:
#: PRECONDITIONS:
#: 		1. The remote destination contains each of the specified local folders to copy under the /mnt/archive directory. For example,
#: 				if the source volume is "Foo", then the remote destination must be named "/mnt/archive/USERNAME/Foo".
#: PARAMETERS:
#: 		$1 - base name of the source volume
#: 		$2 - The path suffix of the destination archive (e.g. "username/Pictures")
#:		$3 - THe remote host, accessible via ssh.  (e.g. for user "bar" on server address 192.168.1.1, use "bar@192.168.1.1")
#:		$4 - base names of directories in the source volume to copy to the destination volume
#:
#: Author: Fastily
##

src="/Volumes/${1}"
remoteDest="/mnt/archive/${2}"
dest="${3}:${remoteDest}"

if [ $# -lt 3 ]; then
	printf "Usage: extSync <SRC_VOLUME_BASENAME> <REMOTE_HOST> <DIRS_TO_COPY...>\n"
    exit 1
fi

if ([ ! -d "$src" ] || ssh "$3" "[ ! -d ${remoteDest} ]"); then
	printf 'ERROR: "%s" or "%s" does not exist!\n' "$src" "$dest"
    exit 1
fi

## fetch target paths as an Array.
shift 3
targets=("$@")

ddss.sh "$src"

for d in "${targets[@]}"; do
	rsync -rltDvhu --progress --delete -e "ssh -T -o Compression=no -x" "${src}/${d}/" "${dest}/${d}"
done

printf "Done!\n"