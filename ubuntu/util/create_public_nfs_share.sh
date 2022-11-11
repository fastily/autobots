#!/usr/bin/env bash

#: Create a new nfs share with the specified directory and IP/CIDR
#: 
#: PRECONDITIONS:
#:		1) *Kernel* NFS is installed
#:
#: ARGUMENTS:
#: 		$1 - The path to the directory to share.
#: 		$2 - The IPs allowed to access the share. Example: 192.168.1.0/24
#: 
#: Tested on Ubuntu 20.04
#: Author: Fastily

##
# Print usage and exits
##
usage() {
  printf "Usage: %s <PATH_OF_DIR_TO_SHARE> <CIDR_WHICH_CAN_CONNECT>\n" "${0##*/}"
  exit 1
}

if (( $# < 2 )); then
	usage
fi

printf "\n\"${1}\" ${2}(insecure,subtree_check)\n" | sudo tee -a "/etc/exports" > /dev/null
sudo exportfs -a