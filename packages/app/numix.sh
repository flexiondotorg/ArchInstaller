#!/usr/bin/env bash

if [ `id -u` -ne 0 ]; then
    echo "ERROR! `basename ${0}` must be executed as root."
    exit 1
fi

CORE_PKG=$(basename ${0} .sh)-themes-git
MORE_PKGS="numix-icon-theme-git"

IS_INSTALLED=$(pacman -Qqm ${CORE_PKG})
if [ $? -ne 0 ]; then
    packer -S --noedit --noconfirm ${CORE_PKG} ${MORE_PKGS}
else
    echo "${CORE_PKG} is already installed."
fi

for EXTRA_PKG in numix-circle-icon-theme-git gtk-theme-numix-blue
do
    IS_INSTALLED=$(pacman -Qqm ${EXTRA_PKG})
    if [ $? -ne 0 ]; then
        packer -S --noedit --noconfirm ${EXTRA_PKG}
    else
        echo "${EXTRA_PKG} is already installed."
    fi
done
