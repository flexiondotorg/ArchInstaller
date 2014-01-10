#!/usr/bin/env bash

if [ `id -u` -ne 0 ]; then
    echo "ERROR! `basename ${0}` must be executed as root."
    exit 1
fi

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS="btsync-autoconfig"

IS_INSTALLED=$(pacman -Qqm ${CORE_PKG})
if [ $? -ne 0 ]; then
    packer -S --noedit --noconfirm ${CORE_PKG} ${MORE_PKGS}
else
    echo "${CORE_PKG} is already installed."
fi

systemctl --system daemon-reload

if [ -n "${SUDO_USER}" ]; then
    systemctl enable btsync@${SUDO_USER}
    systemctl enable btsync-autoconfig@${SUDO_USER}
fi

if [ -f /usr/bin/ufw ]; then
    ufw allow 8888/tcp
fi
