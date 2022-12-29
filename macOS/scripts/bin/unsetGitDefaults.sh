#!/usr/bin/env bash

##
#: If the current directory is a git repo, then unset user.name, user.email, and credential.helper.  Makes it easy to make commits as a different user.
#: 
#: Author: Fastily
##

set -e

git config --local user.name ""
git config --local user.email ""
git config --local credential.helper ""

echo "OK"