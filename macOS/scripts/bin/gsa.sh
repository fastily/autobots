#!/usr/bin/env bash

##
#: Recursively check git statuses in a directory and indiciate if dirty
#:
#: PARAMETERS:
#:      $1 - pass -u to pull latest changes if the repo was not changed
#:
#: Author: Fastily
##

for d in */ ; do
    if [[ -d "${d}.git" ]]; then
        pushd "$d" > /dev/null

        REPO_NAME="$(basename "$d")"
        if [[ $(git status --porcelain) ]]; then
            echo "repo changed: ${REPO_NAME}"
        elif [[ $1 == "-u" ]]; then
            echo "attempting update for ${REPO_NAME}..."
            git pull
        fi

        popd > /dev/null
    fi
done