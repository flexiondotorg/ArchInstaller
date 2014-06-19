#!/usr/bin/env bash

# Reference
#  - https://wiki.archlinux.org/index.php/Infinality-bundle%2Bfonts

if [ `id -u` -ne 0 ]; then
	echo "ERROR! Must be root to run this script."
	exit 1
fi

REPO_PRESENT=$(egrep "^\[infinality-bundle\]$" /etc/pacman.conf)
if [ $? -ne 0 ]; then
    echo '[infinality-bundle]' >> /etc/pacman.conf
    echo 'Server = http://bohoomil.com/repo/$arch' >> /etc/pacman.conf
fi

REPO_PRESENT=$(egrep "^\[infinality-bundle-fonts\]$" /etc/pacman.conf)
if [ $? -ne 0 ]; then
    echo '[infinality-bundle-fonts]' >> /etc/pacman.conf
    echo 'Server = http://bohoomil.com/repo/fonts' >> /etc/pacman.conf
fi


if [ `uname -m` == "x86_64" ]; then
	REPO_PRESENT=$(egrep "^\[infinality-bundle-multilib\]$" /etc/pacman.conf)
	if [ $? -ne 0 ]; then
		echo '[infinality-bundle-multilib]' >> /etc/pacman.conf
		echo 'Server = http://bohoomil.com/repo/multilib/$arch' >> /etc/pacman.conf
	fi
fi

pacman-key -r 962DDE58
pacman-key --lsign-key 962DDE58
pacman -Syyu --noconfirm
if [ `uname -m` == "x86_64" ]; then
	#echo -en "\n\nY\nY\nY\nY\nY\nY\nY\nY\nY\n"
	pacman -S --needed infinality-bundle infinality-bundle-multilib ibfonts-meta-base ibfonts-meta-extended
else
	#echo -en "\nY\nY\nY\nY\nY\nY\nY\nY\nY\n"
	pacman -S --needed infinality-bundle ibfonts-meta-base ibfonts-meta-extended
fi

echo "Configure your fonts to use the following DPI."
xdpyinfo | grep "dots per inch"
