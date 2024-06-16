#!/usr/bin/env bash

#: Update grub settings to work with buggy nvidia driver
#: 
#: Tested on Ubuntu 20.04
#: Author: Fastily

set -e

sudo sed -i -e "s/quiet splash/nomodeset/" "/etc/default/grub"
sudo update-grub

echo "Done.  Next, be sure to enable boot with Legacy BIOS, and disable optimizations in BIOS (fast boot, quiet boot)"