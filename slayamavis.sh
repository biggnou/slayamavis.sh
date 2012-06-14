#!/bin/bash
# @author: ajb@zerospam.ca
# @purpose: copy working dir of amavis, slay user amavis, start amavis, when amavis is in pain.

# check for root privileges
if [ "$(id -u)" != "0" ]; then
    echo "You must be root in order to use this script."
    exit 1
fi

FILENAME=amavistemp.$(date +%d%m%Y-%s)

ps auxwwf | egrep '^amavis'
cp -r /var/lib/amavis/tmp/ /home/${SUDO_USER}/${FILENAME} && chown -R ${SUDO_USER}: /home/${SUDO_USER}/${FILENAME}
slay amavis && sleep 2 ; service amavis start
sleep 2
ps auxwwf | egrep '^amavis'
