#!/usr/bin/env bash

if [ `id -u` -ne 0 ]; then
    echo "ERROR! `basename ${0}` must be executed as root."
    exit 1
fi

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS="xcursor-flatbed xcursor-neutral xcursor-pinux xcursor-premium xcursor-simpleandsoft xcursor-vanilla-dmz xcursor-vanilla-dmz-aa"

pacman -S --needed --noconfirm ${CORE_PKG} ${MORE_PKGS}
