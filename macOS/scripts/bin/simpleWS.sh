#!/usr/bin/env bash

##
#: Starts a fileserver in the current working directory
#:
#: Author: Fastily
##

localIP.sh | while read -r line; do
    echo "Server (probably) reachable at http://${line}:8000"
done

python3 -m http.server