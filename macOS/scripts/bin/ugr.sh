#!/usr/bin/env bash

##
#: Recursively check git status in a directory and pull the latest revisions if possible
#:
#: Author: Fastily
##

for d in */ ; do
	if [ -d "${d}.git" ]; then

		pushd "$d" > /dev/null

		if [[ -z $(git status --porcelain) ]]; then
			echo "attempting update for $(basename "$d")..."
			git pull
		fi

		popd > /dev/null
	fi
done