#!/usr/bin/env bash

##
#: Batch converts the specified images to heic with imagemagick
#:
#: Author: Fastily
##

if (( $# <= 0 )); then
    echo "Usage: ${0##*/} <PATH_TO_IMG>..."
    exit 1
fi

for s; do
    echo "[INFO]: Converting '${s}' to heic..."
    magick "$s" "${s%.*}.heic"
done