#!/usr/bin/env bash

#: Sets up cloudflared tunnel with a specified tunnel token on ovh VPS's.  Patches systemd service file to use http2 because quic tunnels don't play well with
#: ovh's public firewall (https://community.cloudflare.com/t/tunnel-not-working-when-behind-ovh-public-cloud-firewall/544886).
#:
#: ARGUMENTS:
#:      $1 - The Cloudflare tunnel token to use
#: 
#: Author: Fastily

set -e

if (( $# < 1 )); then
    echo "usage: ${0##*/} <CLOUDFLARE_TUNNEL_TOKEN>"
    exit 1
fi

sudo cloudflared service install "$1"
sudo sed -i "s/tunnel/tunnel --protocol http2/" "/etc/systemd/system/cloudflared.service"
sudo systemctl daemon-reload
sudo systemctl restart cloudflared