#!/bin/bash

#: Quickly backs up all my folders in my home directory.
#: 
#: ARGUMENTS:
#: 		$1 - The full path to the directory to back up to.  This must already exist.
#: 
#: Author: Fastily


if [ $# -lt 1 ]; then
	printf "Usage: backupHome.sh <BACKUP_DIRECTORY>\n"
	exit
fi

if [ ! -d "$1" ]; then 
	printf "ERROR: you must specify an existing directory as an argument\n"
	exit 1
fi


targets=("Desktop" "Documents", "Downloads", "Music/iTunes/iTunes Media/Music", "Pictures", "Public", ".ssh")


for d in "${targets[@]}"; do

	printf "Backing up %s...\n" "$d"
	cp -R ~/"$d" "${1}/${d}"
done

printf "Done!\n"