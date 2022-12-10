#!/bin/bash

#: Script to setup QEMU ubuntu guests
#: 
#: Tested on Ubuntu Desktop 20.04
#: Author: Fastily

cd "${0%/*}" &> /dev/null
set -e
source shared.sh

apply_ui_settings
general_settings

## Add config for mounting shared folders.  Assumes shared folder w/ Driver (Default), Mode (Squash), Target path (/hostshare)
STUFF_DIR="/mnt/bifrost"

sudo mkdir -p "$STUFF_DIR"
sudo chmod a+rwx "$STUFF_DIR"

echo "/hostshare  ${STUFF_DIR}  9p  trans=virtio,access=any,version=9p2000.L,_netdev  0  0" | sudo tee -a /etc/fstab > /dev/null

echo "Done, reboot for changes to take effect."