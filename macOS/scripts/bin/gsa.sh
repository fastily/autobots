#!/usr/bin/env bash

##
#: Recursively check git statues in a directory and indiciate if dirty
#:
#: Author: Fastily
##

for d in */ ; do
	if [ -d "${d}.git" ]; then

		pushd "$d" > /dev/null

		if [[ $(git status --porcelain) ]]; then
			printf "repo changed: %s\n" $(basename "$d")
		fi

		popd > /dev/null
	fi
done