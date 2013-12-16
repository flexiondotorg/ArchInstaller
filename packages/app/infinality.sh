#!/usr/bin/env bash

if [ `id -u` -ne 0 ]; then
    echo "ERROR! `basename ${0}` must be executed as root."
    exit 1
fi

# Reference
#  - https://wiki.archlinux.org/index.php/Infinality-bundle%2Bfonts

echo '[infinality-bundle]' >> /etc/pacman.conf
echo 'Server = http://ibn.net63.net/infinality-bundle/$arch' >> /etc/pacman.conf

echo '[infinality-bundle-multilib]' >> /etc/pacman.conf
echo 'Server = http://ibn.net63.net/infinality-bundle-multilib/$arch' >> /etc/pacman.conf

echo '[infinality-bundle-fonts]' >> /etc/pacman.conf
echo 'Server = http://ibn.net63.net/infinality-bundle-fonts' >> /etc/pacman.conf

pacman-key -r 962DDE58
pacman-key --lsign-key 962DDE58
pacman -Syyu --noconfirm
pacman -S infinality-bundle infinality-bundle-multilib ibfonts-meta-base
