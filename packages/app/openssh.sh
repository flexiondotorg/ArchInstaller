#!/usr/bin/env bash

if [ `id -u` -ne 0 ]; then
    echo "ERROR! `basename ${0}` must be executed as root."
    exit 1
fi

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS="fail2ban syslog-ng"

pacman -S --needed --noconfirm ${CORE_PKG} ${MORE_PKGS}

systemctl enable syslog-ng
systemctl start syslog-ng

sudo systemctl enable fail2ban.service
sudo systemctl start fail2ban.service
