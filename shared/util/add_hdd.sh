#!/usr/bin/env bash

#: Configure a hard drive or HD partition to be auto-mounted on boot via /etc/fstab.
#: 
#: PRECONDITIONS:
#:    1) Specified device/partition exists.
#:    2) Must be using debian, 64-bit Raspberry Pi OS, or ubuntu
#:
#: ARGUMENTS:
#:    $1 - The device/partition identifier, exluding the '/dev/' prefix.  Example: sdb1
#:    $2 - The desired mount identifier.  Will be prefixed with '/mnt/'.  Example: myDrive
#: 
#: Tested on Ubuntu 17.04
#: Author: Fastily

set -e

##
# Prints usage and exits
##
usage() {
  echo "Usage: ${0##*/} <DEVICE_ID> <MNT_DIR>"
  exit 1
}

if (( $# < 2 )); then
  usage
fi

## Fetch target UUID and perform sanity checks
targetDrive="/dev/${1}"
targetUUID="$(sudo blkid -s UUID -o value "$targetDrive")"

if [[ -z $targetUUID ]]; then
   echo "[ERROR]: '${targetDrive}' does not exist"
   usage
fi

mountPoint="/mnt/${2}"

## Perform changes
sudo mkdir -p "$mountPoint"
sudo chmod a+rwx "$mountPoint"
printf "\nUUID=${targetUUID} ${mountPoint} auto defaults,nofail 0 2\n" | sudo tee -a /etc/fstab > /dev/null

echo "[INFO]: '${targetDrive}' will mount at '${mountPoint}' on next reboot"