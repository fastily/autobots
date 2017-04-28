#!/bin/bash

#: Use Homebrew to install FFmpeg
#: 
#: PRECONDITIONS: 
#:		1) Homebrew is installed
#: 
#: Tested on OS X 10.11.4
#: Author: Fastily

which brew &> /dev/null
if [ $? -ne 0 ]; then
	printf "[ERROR]: Homebrew is not installed.  Exiting.\n"
	exit 1
fi

brew update
brew install ffmpeg --with-fdk-aac --with-libcaca --with-libvidstab --with-libvorbis --with-libvpx --with-opus --with-schroedinger --with-speex --with-theora --with-tools

printf "Done!\n"