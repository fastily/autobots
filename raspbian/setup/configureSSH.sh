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

cd `dirname "$0"`
source ../../shared/autobotUtils.sh
confirmRunAsRoot

## Some globals
res="../../shared"
me="`whoami`"

## Configuring ssh
printf "Apply settings for ssh\n"
mv /etc/ssh/sshd_config ~/sshd_config_backup.txt # create backup in user's home dir
chown "$me" ~/sshd_config_backup.txt

cp "$res"/sshd_config /etc/ssh/

if [ ! -d ~/.ssh ]; then
	mkdir -p ~/.ssh
	chown "$me" ~/.ssh
	
	touch ~/.ssh/authorized_keys
	chown "$me" ~/.ssh/authorized_keys
fi

printf "Restarting ssh...\n"
service sshd restart


printf "Done!\n"