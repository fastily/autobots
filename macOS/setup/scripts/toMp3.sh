#!/bin/bash

#: Converts an audio file to mp3
#: 
#: PRECONDITION: FFmpeg and libmp3lame are installed
#: PARAMETERS:
#: 		$1 - input file
#: 		$2 - bitrate, optional
#:
#: Tested on macOS 10.12.5
#: Author: Fastily

if [ -z ${1+x} ]; then
	printf "Usage: toMp3 <INPUT_FILE> <BITRATE>\n\n"
	exit 1
fi

printf "Converting $1 to mp3\n"
bitrate=320

if [ ! -z ${2+x} ]; then
 	bitrate=$2
fi

ffmpeg -y -i "$1" -vn -c:a libmp3lame -b:a ${bitrate}k "${1%.*}".mp3