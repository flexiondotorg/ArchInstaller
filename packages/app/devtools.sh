#!/usr/bin/env bash

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS=""

pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}

#if [ "${SUDO_USER}" == "martin" ] || [ "${SUDO_USER}" == "wimpr1m" ]; then
#    sed -i 's/#PACKAGER="John Doe <john@doe\.com>"/PACKAGER="Martin Wimpress <code@flexion\.org>"/' /usr/share/devtools/makepkg-i686.conf
#    sed -i 's/#PACKAGER="John Doe <john@doe\.com>"/PACKAGER="Martin Wimpress <code@flexion\.org>"/' /usr/share/devtools/makepkg-x86_64.conf
#    echo 'PACKAGER="Martin Wimpress <code@flexion.org>"' > /home/"${SUDO_USER}"/.makepkg.conf
#    echo 'GPGKEY="0864983E"' >> /home/"${SUDO_USER}"/.makepkg.conf
#    chown "${SUDO_USER}": /home/"${SUDO_USER}"/.makepkg.conf
#fi
