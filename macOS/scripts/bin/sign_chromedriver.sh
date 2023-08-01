#!/usr/bin/env bash

##
#: Add an ad-hoc signature to Chromedriver
#:
#: Author: Fastily
##

MY_CHROMEDRIVER="$(readlink "$(which chromedriver)")"

perl -pi -e 's/cdc_/dog_/g' "$MY_CHROMEDRIVER"
codesign --remove-signature "$MY_CHROMEDRIVER"
codesign -f -s - "$MY_CHROMEDRIVER"