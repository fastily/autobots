#!/bin/bash

#: Installs QEMU with sane defaults
#: 
#: Tested on Ubuntu 20.04
#: Author: Fastily

set -e

QEMU_CONF="/etc/libvirt/qemu.conf"

sudo apt update && sudo apt -y install virt-manager

## run VMs as the current logged in user
sudo cp "$QEMU_CONF" /tmp/
sudo sed -i "s/#user = \"root\"/user = \"$(whoami)\"/" "$QEMU_CONF"
sudo sed -i "s/#group = \"root\"/group = \"$(whoami)\"/" "$QEMU_CONF"

## Ensure Public folder has correct permissions
chmod a+rwx ~/Public