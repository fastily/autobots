#!/usr/bin/env bash

#: Wipes & formats a new SSD/HDD as ext4.  Good for setting up additional internal hard drives.  Inspired by https://www.digitalocean.com/community/tutorials/how-to-partition-and-format-storage-devices-in-linux
#: 
#: PRECONDITIONS: 
#:    1) Must be using debian, 64-bit Raspberry Pi OS, or ubuntu
#:    2) jq is installed
#:
#: ARGUMENTS:
#:    $1 - The device/partition identifier, exluding the '/dev/' prefix.  Example: sdb
#: 
#: Author: Fastily

set -e

##
# Prints usage and exits
##
usage() {
  echo "Usage: ${0##*/} <DEVICE_ID>"
  exit 1
}

if (( $# < 1 )); then
  usage
fi

DEV="/dev"
TARGET_DEVICE="${DEV}/${1}"

if [[ ! -b $TARGET_DEVICE ]]; then
    echo "[ERROR]: '${TARGET_DEVICE}' does not exist"
    usage
fi

sudo parted "$TARGET_DEVICE" mklabel gpt
sudo parted -a opt "$TARGET_DEVICE" mkpart primary ext4 0% 100%
sudo mkfs.ext4 "${DEV}/$(lsblk --json "$TARGET_DEVICE" | jq -r ".blockdevices[0].children[0].name")"

echo "[INFO]: Done, does this look right?"
lsblk "$TARGET_DEVICE"