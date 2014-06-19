#!/usr/bin/env bash

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS="${CORE_PKG}-host-modules ${CORE_PKG}-ext-oracle"
pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}

# Configure
sudo gpasswd -a ${SUDO_USER} vboxusers
sudo modprobe -a vboxdrv vboxnetadp vboxnetflt
sudo cat << MODULES > /etc/modules-load.d/virtualbox-host.conf
vboxdrv
vboxnetadp
vboxnetflt
MODULES
