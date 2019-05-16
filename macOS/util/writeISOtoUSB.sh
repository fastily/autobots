#!/usr/bin/env bash

#: Writes an ISO to a USB. This can take a few minutes to complete, depending on the amount of data you're trying to copy.
#: 
#: PRECONDITIONS: 
#:		1) You have an empty USB thumb drive to create the bootable installer on
#: 		2) You have obtained the disk node of the thumb drive (use diskutil list),
#:			e.g. '/dev/disk2'
#: ARGUMENTS:
#: 		$1 - The full path to the ISO to use.  
#: 		$2 - The disk id (integer) to write to.  This disk will be unmounted before being written to; 
#:			use 'diskutil list' to get the id.
#: 
#: Author: Fastily

## Ensure that the the target drive volume exists
if [ "$#" -lt 2 ]; then
	printf "[Usage]: writeISOtoUSB <PATH_TO_ISO> <DISK_ID_NUMBER>\n"
	exit 1
fi

## Verify that the ISO exists
if [ ! -f "$1" ]; then
	printf "[ERROR]: '%s' does not exist.\n" "$1"
	exit 1
fi

## Ensure we are not going to overwrite something crazy
if [ "$2" -lt 2 ]; then
	printf "[ERROR]: disk_id cannot be less than 2.  You entered %s.\n" "$2"
	exit 1
fi

targetDisk="/dev/disk${2}"
targetDiskRaw="/dev/rdisk${2}"

## Check to make sure target disks exist.
if [ ! -b "$targetDisk" ] || [ ! -c "$targetDiskRaw" ]; then
	printf "[ERROR]: '%s' or '%s' does not exist.  Do you have the right number?\n" "$targetDisk" "$targetDiskRaw"
	exit 1
fi

printf "[INFO]: Unmounting '%s'\n" "$targetDisk"
diskutil unmountDisk "$targetDisk"

printf "[INFO]: Writing '%s' to '%s'\n" "$1" "$targetDiskRaw"
sudo dd if="$1" of="$targetDiskRaw" bs=1m

printf "Done!\n"