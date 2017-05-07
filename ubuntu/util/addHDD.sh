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

cd "${0%/*}" &> /dev/null
source ../../shared/autobotUtils.sh
confirmRunAsRoot

##
# Prints usage and exits
##
usage() {
  printf "addHDD <device id> <mount destination>\n"
  exit 1
}

if (( $# < 2 )); then
	usage
fi

## Fetch target UUID and perform sanity checks
targetDrive="/dev/${1}"
targetUUID=$( blkid -s UUID -o value "$targetDrive" )

if [[ -z $targetUUID ]]; then
   printf "Error: ${targetDrive} does not exist\n"
   usage
fi

mountPoint="/mnt/${2}"
lineOut="UUID=${targetUUID} ${mountPoint} auto nosuid,nodev,nofail,rw 0 2"

## Perform changes
mkdir -p "$mountPoint"
printf "\n%s" "$lineOut" >> /etc/fstab

printf "OK: ${targetDrive} will mount on ${mountPoint} on next reboot.\n"