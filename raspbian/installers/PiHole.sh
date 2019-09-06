#!/bin/bash

#: Installs pi-hole (https://pi-hole.net) on Raspbian and schedules automatic updates. 
#: 
#: Author: Fastily

cd /tmp && \
git clone --depth 1 "https://github.com/pi-hole/pi-hole.git" && \
sudo bash "pi-hole/automated install/basic-install.sh"


# setup automatic updates via cron - Saturdays @ 14:00 UTC
CTF="/tmp/currctab"

if crontab -l &> /dev/null; then
	crontab -l > /tmp/currctab
else
	printf 'PATH=/home/pi/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games\nSHELL=/bin/bash\n\n' >> "$CTF"
fi

printf "0 14 * * 6 { date; pihole -up; echo; } >> ${HOME}/pihole-update-log.txt 2>&1\n" >> "$CTF"
crontab "$CTF"