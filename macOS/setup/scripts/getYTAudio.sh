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
	if  grep -- "$1" "$LOGFILE" > "/dev/null" ; then
		return 0
	fi

	printf "Ripping audio for '%s'\n" "$1"

	DLURL="${YTURL}/watch?v=${1}"
	BASEFMT='%(title)s - [%(id)s]'
	TITLE=$(youtube-dl --get-filename -o "$BASEFMT" "$DLURL")

	youtube-dl -f bestaudio -x --audio-format mp3 --audio-quality 0 --add-metadata -o "${BASEFMT}.%(ext)s" "$DLURL" && \
	eyed3 $ARTWORK -A "$ALBUM" -a "$ARTIST" -b "$ARTIST" -c "$DLURL" "${TITLE}.mp3" && \
	printf "\n${1}" >> "$LOGFILE"
}

## < 3 args -> print usage and exit
if (( $# < 3 )) ; then
	usage
fi

cd "$PWD"

## Global variables
export -f procDL

export LOGFILE="log.txt"
export YTURL="https://www.youtube.com"

export ARTIST="$2"
export ALBUM="$3"

ARTWORK=' '
if [ $# -eq 4 ]; then
	ARTWORK="--add-image ${4}:FRONT_COVER"
fi
export ARTWORK

## Start DL
touch "$LOGFILE"
youtube-dl --get-id "${YTURL}/${1}" | xargs -n 1 -I "{}" bash -c 'procDL "{}"'