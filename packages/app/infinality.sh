#!/usr/bin/env bash

if [ `id -u` -ne 0 ]; then
    echo "ERROR! `basename ${0}` must be executed as root."
    exit 1
fi

# Reference
#  - https://wiki.archlinux.org/index.php/Infinality-bundle%2Bfonts

REPO_PRESENT=$(egrep "^\[infinality-bundle\]$" /etc/pacman.conf)
if [ $? -ne 0 ]; then
    echo '[infinality-bundle]' >> /etc/pacman.conf
    echo 'Server = http://ibn.net63.net/infinality-bundle/$arch' >> /etc/pacman.conf
fi

REPO_PRESENT=$(egrep "^\[infinality-bundle-multilib\]$" /etc/pacman.conf)
if [ $? -ne 0 ]; then
    echo '[infinality-bundle-multilib]' >> /etc/pacman.conf
    echo 'Server = http://ibn.net63.net/infinality-bundle-multilib/$arch' >> /etc/pacman.conf
fi

REPO_PRESENT=$(egrep "^\[infinality-bundle-fonts\]$" /etc/pacman.conf)
if [ $? -ne 0 ]; then
    echo '[infinality-bundle-fonts]' >> /etc/pacman.conf
    echo 'Server = http://ibn.net63.net/infinality-bundle-fonts' >> /etc/pacman.conf
fi

pacman-key -r 962DDE58
pacman-key --lsign-key 962DDE58
pacman -Syyu --noconfirm
echo -en "\n\nY\nY\nY\nY\nY\nY\nY\nY\nY\nY\nY\n" | pacman -S --needed infinality-bundle infinality-bundle-multilib ibfonts-meta-base ibfonts-meta-extended

echo "Configure your fonts to use the following DPI."
xdpyinfo | grep "dots per inch"
