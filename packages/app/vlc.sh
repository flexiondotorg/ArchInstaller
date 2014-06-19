#!/usr/bin/env bash

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS="libaacs libbluray libdvdcss libdvdnav libdvdread"

pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}

mkdir -p ${HOME}/.config/aacs/
wget -c http://vlc-bluray.whoknowsmy.name/files/KEYDB.cfg -O ${HOME}/.config/aacs/KEYDB.cfg
