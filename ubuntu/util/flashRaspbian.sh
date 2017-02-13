#!/bin/bash

#: Flashes a Raspbian image to a SD card.  This can take a few minutes to complete, depending on your SD card's write time
#: 
#: PRECONDITIONS: 
#:		1) You have an unmounted empty SD card (formatted FAT32) mounted to load the image on.  Use fdisk -l to determine which /dev/ file points at the SD card.
#:			 Unmount partitions by running something like umount /dev/sdc1.
#: 		2) You have downloaded and extracted a Raspbian .img
#:
#: ARGUMENTS:
#: 		$1 - The base filesystem path to the target SD card (e.g. '/dev/sdc')
#:		$2 - The full path to the Raspbian .img file
#: 
#: Tested on Ubuntu 16.10
#: Author: Fastily

cd "${0%/*}" &> /dev/null
source ../../shared/autobotUtils.sh
confirmRunAsRoot

if [ -z "$1" ] || [ -z "$2" ]; then
	printf "Usage: flashRaspbian <path to SD> <path to img>\n"
	exit 1
fi

printf "Attempting to flash %s to %s\n" "$2" "$1"

dd bs=4M if="$2" of="$1"
sync

printf "All done!\n"
