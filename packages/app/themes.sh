#!/usr/bin/env bash

if [ `id -u` -ne 0 ]; then
    echo "ERROR! `basename ${0}` must be executed as root."
    exit 1
fi

CORE_PKG="faenza-icon-theme"
MORE_PKGS="xcursor-flatbed"

pacman -S --needed --noconfirm ${CORE_PKG} ${MORE_PKGS}

mkdir -p /home/"${SUDO_USER}"/.icons

# Dark
url="http://ubuntuone.com/p/133Z/"
if [ ! -e /home/"${SUDO_USER}"/.icons/faenza-pidgin-dark.zip ]; then
    curl -Lo /home/"${SUDO_USER}"/.icons/faenza-pidgin-dark.zip ${url}
fi

mkdir -p /home/"${SUDO_USER}"/.icons/Faenza-Darkest/status/{16,22}
for size in 16 22; do
    unzip -xj /home/"${SUDO_USER}"/.icons/faenza-pidgin-dark.zip \
        -d /home/"${SUDO_USER}"/.icons/Faenza-Darkest/status/${size} \
        dark/${size}x${size}/status/pidgin\*
done

# Lite
url="http://ubuntuone.com/p/133X/"
if [ ! -e /home/"${SUDO_USER}"/.icons/faenza-pidgin-lite.zip ]; then
    curl -Lo /home/"${SUDO_USER}"/.icons/faenza-pidgin-lite.zip ${url}
fi

mkdir -p /home/"${SUDO_USER}"/.icons/Faenza/status/{16,22}
for size in 16 22; do
    unzip -xj /home/"${SUDO_USER}"/.icons/faenza-pidgin-lite.zip \
        -d /home/"${SUDO_USER}"/.icons/Faenza/status/${size} \
        lite/${size}x${size}/status/pidgin\*
done

chown -R "${SUDO_USER}": /home/"${SUDO_USER}"/.icons


for EXTRA_PKG in gtk-theme-shiki-colors-flat gtk-theme-numix-blue ubuntu-themes
do
    IS_INSTALLED=$(pacman -Qqm ${EXTRA_PKG})
    if [ $? -ne 0 ]; then
        packer -S --noedit --noconfirm ${EXTRA_PKG}
    else
        echo "${EXTRA_PKG} is already installed."
    fi
done
