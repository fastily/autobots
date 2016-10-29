#!/bin/bash

#: Rips audio from YouTube. 
#: 
#: PRECONDITION: You have youtube-dl & eyed3 installed.
#: 
#: Tested on macOS 10.12.1 & Ubuntu 16.10
#: Author: Fastily

##
# Prints usage instructions to stdout and exits
##
usage()
{	
	printf "Usage:\n"
	printf "getYTAudio.sh short_link artist album [path_to_artwork]\n"
	printf "\tshort_link: url excluding \'https://www.youtube.com/\' prefix\n"
	printf "\tartist: used to fill in artist id3 tag\n"
	printf "\talbum: used to fill in album id3 tag\n"
	printf "\tpath_to_artwork: fill in album art (*MUST* BE png or jpg)\n\n"
	exit 1
}

##
# Takes video ids and downloads the video if it has not been downloaded
##
procDL()
{
	printf "Checking '%s'\n" "$1"
	if  grep "$1" "$LOGFILE" > "/dev/null" ; then
		return 0
	fi

	printf "Ripping audio for '%s'\n" "$1"

	youtube-dl -f bestaudio -x --audio-format mp3 --audio-quality 0 --add-metadata --id "${YTURL}/watch?v=${1}" && \
	eyed3 --add-image "${ARTWORK}:FRONT_COVER" "${1}.mp3" -A "$ALBUM" -a "$ARTIST" -b "$ARTIST" && \
	printf "\n${1}" >> "$LOGFILE"
}

## < 3 args -> print usage and exit
if (( $# < 3 )) ; then
	usage
fi

cd "${0%/*}" &> /dev/null

## Global variables
export -f procDL

RES="res"
export LOGFILE="${RES}/log.txt"
export YTURL="https://www.youtube.com"

export ARTIST="$2"
export ALBUM="$3"

ARTWORK="${RES}/defaultcover.png"
if [ $# -eq 4 ]; then
	ARTWORK="$4"
fi
export ARTWORK


## Start DL
mkdir -p "$RES"
touch "$LOGFILE"
youtube-dl --get-id "${YTURL}/${1}" | xargs -n 1 -I "{}" bash -c 'procDL "{}"'