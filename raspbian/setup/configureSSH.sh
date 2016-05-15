#!/bin/bash

#: Apply custom settings for OpenSSH on Raspbian.   This isn't 
#: gaunrateed to be 100% automatic; you may be prompted for input or with confirm dialogs.  
#: Must be run as root.
#: 
#: PRECONDITIONS: 
#:		1) OpenSSH is installed
#: 
#: Tested on Raspbian March 2016
#: Author: Fastily

cd "${0%/*}"
source ../../shared/autobotUtils.sh
confirmRunAsRoot

## Some globals
res="../../shared"
me="pi"
home="/home/""$me"

## Configuring ssh
printf "Apply settings for ssh\n"
mv /etc/ssh/sshd_config "$home"/sshd_config_backup.txt # create backup in user's home dir
chown "$me" "$home"/sshd_config_backup.txt

cp "$res"/sshd_config /etc/ssh/

if [ ! -d "$home"/.ssh ]; then
	mkdir -p "$home"/.ssh
	chown "$me" "$home"/.ssh
	
	touch "$home"/.ssh/authorized_keys
	chown "$me" "$home"/.ssh/authorized_keys
fi

printf "Restarting ssh...\n"
service sshd restart


printf "Done!\n"