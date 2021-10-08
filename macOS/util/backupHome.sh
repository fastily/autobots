#!/usr/bin/env bash

#: Quickly backs up all my folders in my home directory.
#: 
#: ARGUMENTS:
#: 		$1 - The full path to the directory to back up to.  This must already exist.
#: 
#: Author: Fastily


if [ $# -lt 1 ]; then
	printf "Usage: %s <BACKUP_DIRECTORY>\n" "${0##*/}"
	exit
fi

if [ ! -d "$1" ]; then 
	printf "ERROR: you must specify an existing directory as an argument\n"
	exit 1
fi


BACKUP_DIR="$1"

##
# Helper method to perform actual backups
# PARAMETERS:
# 		$1 - Relative path of folder to backup, rooted in user's home folder
# 		$2 - The folder name to save the contents of $1 in the destination directory.
#		$3... - Additional arguments to pass to the underlying rsync call.  Useful for exclude/include.  Optional param - leave blank to omit.
##
doBackup()
{
	SRC_NAME="$1"
	DEST_NAME="$2"
	shift 2

	rsync -avhn --progress ~/"${SRC_NAME}/" "${BACKUP_DIR}/${DEST_NAME}" "$@" --exclude=".localized" --exclude=".DS_Store"
}

doBackup "Desktop" "Desktop"
doBackup "Documents" "Documents" --exclude="/workspace" --exclude="/git"
doBackup "Downloads" "Downloads"
doBackup "Music/iTunes/iTunes Media/Music" "Music"
doBackup "Pictures" "Pictures" --exclude='/Photos Library.photoslibrary'
doBackup "Public" "Public" --exclude='/Drop Box'
doBackup ".ssh" ".ssh" --exclude='/known_hosts'

printf "Done!\n"