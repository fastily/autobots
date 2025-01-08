#!/usr/bin/env bash

##
#: Encode a media file as mp3
#: PARAMETERS:
#: 		$1 - path to media file to encode as mp3
#:
#: Author: Fastily
##

if [[ ! -f $1 ]]; then
    echo "Usage: ${0##*/} <PATH_TO_MEDIA_FILE>"
    exit 1
fi

ffmpeg -y -i "$1" -vn -c:a libmp3lame -q:a 0 -loglevel panic "${1%.*}".mp3