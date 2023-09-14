#!/usr/bin/env bash

##
#: Downloads latest videos for my tagged YouTube channels.  Must have a `channels.txt` file in the root YouTube dirs
#:
#: PARAMETERS:
#: 		$1 - the root directory containing the YouTube dirs.  Optional, defaults to `/Volumes/Other/YouTube` if not set.
#:
#: Author: Fastily
##

BASE_DIR="${1:-/Volumes/Other/YouTube}"
CHANNELS="${BASE_DIR}/channels.txt"

if [[ ! -f $CHANNELS ]]; then
    echo "[ERROR]: '${CHANNELS}' does not exist!"
    echo "Usage: ${0##*/} [ROOT_DIR]"
    exit 1
fi

cd "$BASE_DIR"

while read l || [[ -n $l ]]; do
    d="${l%=*}"
    name="${l#*=}"

    mkdir -p "$d"
    pushd "$d"

    CHANNEL_ID="$(yt-dlp --print channel_id -I1 "https://www.youtube.com/${name}")"
    if [[ -z $CHANNEL_ID ]]; then
        echo "[ERROR]: Could not extract channel id for '${name}', skipping"
        continue
    fi

    yt-dlp -w --match-filters '!is_live' --add-metadata --cookies-from-browser safari --download-archive archive.txt -o '%(upload_date)s - %(title)s - [%(id)s].%(ext)s' "https://www.youtube.com/playlist?list=UU${CHANNEL_ID:2}"
    popd

done < "$CHANNELS"