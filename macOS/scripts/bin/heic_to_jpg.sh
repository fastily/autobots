#!/usr/bin/env bash

##
#: Converts dirs with heic images to jpg.  Optionally strips gps info from EXIF.
#:
#: Author: Fastily
##

set -e
shopt -s nocaseglob nullglob

if (( $# <= 0 )); then
    printf "Usage: %s [-s] <PATH_TO_DIRS_WITH_HEIC>...\n" "${0##*/}"
    printf "\t-s: Strip location data from EXIF\n"
    exit 1
fi

if [[ $1 == -s ]]; then
    STRIP_EXIF=true
    shift
fi

for d in "$@"; do
    if [[ ! -d $d ]]; then
        echo "[WARN]: '${d}' is not a directory, skippping!"
        continue
    fi

    pushd "$d" > /dev/null
    for f in *.heic; do
        magick "$f" -quality 100 -verbose "${f%.*}.jpg"
    done

    if [[ ! -z $STRIP_EXIF ]]; then
        exiftool -ext jpg -overwrite_original -gps:all= .
    fi
    popd > /dev/null
done