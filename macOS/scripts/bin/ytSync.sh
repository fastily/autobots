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
CHANNELS="channels.txt"

if ! [ -d "$BASE_DIR" ] || ! [ -f "${BASE_DIR}/${CHANNELS}" ]; then
	printf "'%s' does not exist or '%s/channels.txt' is missing!\nUsage: %s [ROOT_DIR]\n" "$BASE_DIR" "$BASE_DIR" "${0##*/}"
	exit 1
fi

cd "$BASE_DIR"

while read l || [[ -n $l ]]; do
	d="${l%=*}"

	mkdir -p "$d"
	pushd "$d"
	yt-dlp -w --add-metadata --download-archive archive.txt -o '%(upload_date)s - %(title)s - [%(id)s].%(ext)s' "https://www.youtube.com/${l#*=}"
	popd

done < "$CHANNELS"