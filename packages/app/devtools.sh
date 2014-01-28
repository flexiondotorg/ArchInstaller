#!/usr/bin/env bash

if [ `id -u` -ne 0 ]; then
    echo "ERROR! `basename ${0}` must be executed as root."
    exit 1
fi

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS=""

pacman -S --needed --noconfirm ${CORE_PKG} ${MORE_PKGS}

if [ ! -d /home/${SUDO_USER}/staging ]; then
    mkdir -p /home/${SUDO_USER}/staging/{community,community-testing,multilib}
    chown -Rv ${SUDO_USER}: /home/${SUDO_USER}/staging
fi

if [ "${SUDO_USER}" == "martin" ] || [ "${SUDO_USER}" == "wimpr1m" ]; then
    sed -i 's/#PACKAGER="John Doe <john@doe\.com>"/PACKAGER="Martin Wimpress <code@flexion\.org>"/' /usr/share/devtools/makepkg-i686.conf
    sed -i 's/#PACKAGER="John Doe <john@doe\.com>"/PACKAGER="Martin Wimpress <code@flexion\.org>"/' /usr/share/devtools/makepkg-x86_64.conf
    echo 'PACKAGER="Martin Wimpress <code@flexion.org>"' > /home/"${SUDO_USER}"/.makepkg.conf
    echo 'GPGKEY="0864983E"' >> /home/"${SUDO_USER}"/.makepkg.conf
    chown "${SUDO_USER}": /home/"${SUDO_USER}"/.makepkg.conf
fi
