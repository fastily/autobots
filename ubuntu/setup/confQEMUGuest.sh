#!/bin/bash

#: Script to setup QEMU ubuntu guests
#: 
#: Tested on Ubuntu Desktop 20.04
#: Author: Fastily

## apply shared configuration
cd "${0%/*}" &> /dev/null
bash confEnv.sh


## Add config for mounting shared folders.  Assumes shared folder w/ Driver (Default), Mode (Squash), Target path (/hostshare)
STUFF_DIR="/mnt/bifrost"

sudo mkdir -p "$STUFF_DIR"
sudo chmod a+rwx "$STUFF_DIR"

echo "/hostshare  ${STUFF_DIR}  9p  trans=virtio,access=any,version=9p2000.L,_netdev  0  0" | sudo tee -a /etc/fstab > /dev/null