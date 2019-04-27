#!/bin/bash

#: Configure a hard drive or HD partition to be auto-mounted on boot via /etc/fstab.
#: 
#: PRECONDITIONS: 
#:		1) Specified device/partition exists.
#:
#: ARGUMENTS:
#: 		$1 - The device/partition identifier, exluding the '/dev/' prefix.  Example: sdb1
#: 		$2 - The desired mount identifier.  Will be prefixed with '/mnt/'.  Example: myDrive
#: 
#: Tested on Ubuntu 17.04
#: Author: Fastily

##
# Prints usage and exits
##
usage() {
  printf "Usage: addHDD <device id> <mount destination>\n"
  exit 1
}

if (( $# < 2 )); then
	usage
fi

## Fetch target UUID and perform sanity checks
targetDrive="/dev/${1}"
targetUUID=$( sudo blkid -s UUID -o value "$targetDrive" )

if [[ -z $targetUUID ]]; then
   printf "Error: ${targetDrive} does not exist\n"
   usage
fi

mountPoint="/mnt/${2}"

## Perform changes
mkdir -p "$mountPoint"
printf "\nUUID=${targetUUID} ${mountPoint} auto defaults,nofail 0 0" | sudo tee -a /etc/fstab > /dev/null

printf "OK: ${targetDrive} will mount on ${mountPoint} on next reboot.\n"