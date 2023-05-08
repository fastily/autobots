#!/usr/bin/env bash

##
#: Recursively rips audio from video files.  Supported formats: mkv,mts,mt2s,webm,ogg,ogv,mp4,mov.
#: Operates in 2 modes
#:  1) Pass video file paths as arguments, in which case the ripped audio files will be saved in the current working directory.
#:  2) Don't specify arguments, script will recursively search current working directory for video files, saving the files in the same directory as any video files that were encountered.
#:
#: Author: Fastily
##

# Set bash case-insensitivity and set non-matching patterns to expand to nothing
shopt -s globstar nocaseglob nullglob


# Rips audio from a video file
#
# PARAMETERS:
#   $1 - file to process
#   $2 - The output directory.  Optional, if not specified, then the output file will be saved in the same directory as `$1`.
##
_rip() {
    [[ ${1,,} =~ .*(mp4|mov)$ ]] && local ext="m4a" || local ext="mka"

    local out="${1%.*}.${ext}"
    if [[ $2 ]]; then
        out="${2}/$(basename "$out")"
    fi

    echo "$(date) [INFO]: ripping audio from '${1}' and sending it to '${out}'"
    ffmpeg -n -i "$1" -vn -c:a copy -map_metadata 0 -map_metadata:s:a 0:s:a -loglevel panic "$out"
}

if (( $# > 0 )); then
    for s in "$@"; do
        _rip "$s" "$PWD"
    done
else
    for f in **/*.{mkv,mts,mt2s,webm,ogv,mp4,mov}; do
        _rip "$f"
    done
fi