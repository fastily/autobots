#!/usr/bin/env bash

#: Create a new nfs share with the specified directory and IP/CIDR
#: 
#: PRECONDITIONS:
#:    1) *Kernel* NFS is installed
#:
#: ARGUMENTS:
#:    $1 - The path to the directory to share.
#:    $2 - The IPs allowed to access the share. Example: 192.168.1.0/24
#: 
#: Tested on Ubuntu 20.04
#: Author: Fastily

if (( $# < 2 )); then
  echo "Usage: ${0##*/} <PATH_OF_DIR_TO_SHARE> <CIDR_WHICH_CAN_CONNECT>"
  exit 1
fi

# implied - ro,sync,no_subtree_check,root_squash.  Also macOS requires 'insecure' to connect
printf "\n\"${1}\" ${2}(insecure)\n" | sudo tee -a "/etc/exports" > /dev/null
sudo exportfs -r