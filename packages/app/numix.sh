#!/usr/bin/env bash

if [ `id -u` -ne 0 ]; then
    echo "ERROR! `basename ${0}` must be executed as root."
    exit 1
fi

CORE_PKG=$(basename ${0} .sh)-themes
pacman -S --noconfirm --needed ${CORE_PKG}

for EXTRA_PKG in numix-themes-archblue numix-icon-theme-git numix-circle-icon-theme-git numix-shine-icon-theme-git
do
    packer -S --noedit --noconfirm ${EXTRA_PKG}
done
