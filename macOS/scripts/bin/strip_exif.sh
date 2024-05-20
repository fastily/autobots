#!/usr/bin/env bash

##
#: Strips EXIF from input files
#: PARAMETERS:
#: 		$1... - The files to strip EXIF from
#:
#: Author: Fastily
##

if (( $# < 1 )); then
    echo "[ERROR]: You must specify at least one input file to strip exif from"
    exit 1
fi

for f; do
    exiftool -EXIF= -overwrite_original "$f"
done