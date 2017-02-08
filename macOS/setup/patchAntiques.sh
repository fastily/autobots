#!/bin/bash

#: Use Homebrew to update OSX's ancient CLI utilities.
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
brew install vim --with-override-system-vi
brew install less
brew install bash

printf "Done!\n"