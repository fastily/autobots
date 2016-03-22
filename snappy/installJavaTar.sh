#!/bin/bash

#: Install a Java tar to ~/bin
#: 
#: PRECONDITIONS: 
#:		1) bash .profile file exists
#: 
#: ARGUMENTS:
#: 		$1 - The full path of the tar to extract to ~/bin
#: 
#: Tested on Raspberry Pi 2 : ubuntu-core/15.04/stable
#: Author: Fastily

if [ $# -eq 0 ]; then
	printf "[ERROR]: You need to specify the path a tar to install\n"
	exit 1
fi

mkdir -p ~/bin
cd ~/bin

fn=${1%%.*}
fn=$(basename "$fn")
mkdir "$fn"

cd "$fn"

# Extract tar
printf "Extracting %s to %s\n" "$1" to $(pwd)
tar -xzvf "$1"

if [ $? -ne 0 ]; then
	printf "[ERROR]: Looks like something went wrong!\n"
	exit 1
fi

# Include the bin directory in the bash path
binpath=$(find $(pwd) -maxdepth 2 -name bin -type d -exec printf ":%s" "{}" \;)

if [ ! -z "$binpath" ]; then
	printf "\nPATH=\"\${PATH}${binpath}\"" >> ~/.profile
fi


printf "[INFO]: You will have to restart bash for tab-complete to work\n"
printf "Done!\n"