#!/usr/bin/env bash

#: Sets up the loki grafana plugin for docker.  Inspired by [https://grafana.com/docs/loki/latest/send-data/docker-driver/].
#:
#: PRECONDITIONS:
#:      1) Docker is installed
#: 
#: Author: Fastily

set -e

LOKI="loki"
LOKI_DRIVER="grafana/loki-docker-driver"


##
# Prints usage and exits
##
usage() {
    echo "usage: ${0##*/} <install|upgrade|uninstall>"
    exit 1
}

if (( $# < 1 )); then
    usage
fi

case "$1" in
    install)
        docker plugin install "$LOKI_DRIVER" --alias "$LOKI" --grant-all-permissions
        docker plugin ls
        ;;
    upgrade)
        docker plugin disable "$LOKI" --force
        docker plugin upgrade "$LOKI" "$LOKI_DRIVER" --grant-all-permissions
        docker plugin enable "$LOKI"
        ;;
    uninstall)
        docker plugin disable "$LOKI" --force
        docker plugin rm "$LOKI"
        ;;
    *)
        usage
        ;;
esac

echo "Done!  Reboot for changes to take effect"