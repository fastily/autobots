#!/bin/bash

#: Create a RAID 0 setup and mount it at the specified location
#: 
#: Example: lazyRAID.sh md0 sda sdb sdd sde
#:
#: Tested on Ubuntu 18.04
#: Author: Fastily

##
# Prints usage and exits
##
usage() {
  printf "Usage: %s <new_mount_id> <device_name_1> <device_name_2> <device_name_3>...\n" "${0##*/}"
  exit
}

if (( $# < 3 )); then
	usage
fi

dest="$1"

# get device ids correct 
shift
targets=($@)
targets=( "${targets[@]/#//dev/}" )

# install reqts
sudo apt update && sudo apt install -y mdadm

# create array and automount at reboot
sudo mdadm --create --verbose "/dev/${dest}" --level=0 --raid-devices="$#" "${targets[@]}" && \
sudo mkfs.ext4 -F "/dev/${dest}" && \
sudo mkdir -p "/mnt/${dest}" && \
sudo mount "/dev/${dest}" "/mnt/${dest}" && \
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf > /dev/null && \
sudo update-initramfs -u && \
printf "/dev/${dest} /mnt/${dest} auto defaults,nofail 0 0\n" | sudo tee -a /etc/fstab > /dev/null # add discard as a fstab option for ssds


# show details
cat /proc/mdstat
df -h -x devtmpfs -x tmpfs -x squashfs
printf "It probably worked!\n"