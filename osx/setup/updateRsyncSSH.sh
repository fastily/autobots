#!/bin/bash

#: Use Homebrew to update OSX's ancient version of rsync and ssh.
#: 
#: PRECONDITIONS: 
#:		1) Homebrew is installed
#:		2) '/usr/local/bin' is before '/usr/bin' in /private/etc/paths
#: 
#: Tested on OS X 10.11.2
#: Author: Fastily

which brew &> /dev/null
if [ $? -ne 0 ]; then
	printf "[ERROR]: Homebrew is not installed.  Exiting.\n"
	exit 1
fi

printf "Installing new version of rsync\n"
brew update
brew tap homebrew/dupes
brew install rsync
brew install openssh

printf "Done!\n"