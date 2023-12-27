#!/usr/bin/env bash

##
#: Add an ad-hoc signature to a standalone binary.  Useful for when homebrew cask installs something that lacks a signature.
#:
#: Author: Fastily
##

if (( $# < 1 )); then
    printf "Usage: %s <NAME_OF_PROGRAM_TO_SIGN>\n" "${0##*/}"
    exit 1
fi

TARGET="$(readlink "$(which "$1")")"

perl -pi -e 's/cdc_/dog_/g' "$TARGET"
codesign --remove-signature "$TARGET"
codesign -f -s - "$TARGET"