#!/bin/bash

#: Apply some settings for Ubuntu Snappy on Raspberry pi2.   Configures OpenSSH and updates bash .profile. This isn't 
#: gaunrateed to be 100% automatic; you may be prompted for input or with confirm dialogs.  Must be run as root.
#: 
#: PRECONDITIONS: 
#:		1) OpenSSH is installed
#: 
#: Tested on Raspberry Pi 2 : ubuntu-core/15.04/stable
#: Author: Fastily

cd `dirname "$0"`
source ../../autobotUtils.sh
confirmRunAsRoot

## Some global vars
res="../setup/res" # global resources folder
me="`whoami`" # current user


## Apply custom settings for ssh
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

## Restart affected services
printf "Restarting affected services\n"
service sshd restart


## Update ~/.profile
printf "Update bash .profile\n"
mv ~/.profile ~/profile_backup.txt
cp res/profile.sh ~/.profile
chown "$me" ~/.profile


printf "Done!\n"