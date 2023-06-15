#!/usr/bin/env bash

##
#: Recursively check git statuses in a directory and indiciate if dirty
#:
#: Author: Fastily
##

for d in */ ; do
    if [[ -d "${d}.git" ]]; then
        pushd "$d" > /dev/null
        if [[ $(git status --porcelain) ]]; then
            echo "repo changed: $(basename "$d")"
        fi
        popd > /dev/null
    fi
done