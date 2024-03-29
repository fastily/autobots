#!/usr/bin/env bash

##
#: Encode a media file as 320kbps mp3
#: PARAMETERS:
#: 		$1 - path to media file to encode as mp3
#:
#: Author: Fastily
##

if [[ ! -f $1 ]]; then
    printf "Usage: %s <PATH_TO_MEDIA_FILE>\n" "${0##*/}"
    exit 1
fi

ffmpeg -y -i "$1" -vn -c:a libmp3lame -b:a 320k -loglevel panic "${1%.*}".mp3