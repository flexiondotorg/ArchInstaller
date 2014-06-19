#!/usr/bin/env bash

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS="wine-mono wine_gecko winetricks samba"

if [ `uname -m` == "x86_64" ]; then
    MORE_PKGS="${MORE_PKGS} lib32-giflib lib32-libpng lib32-libldap lib32-gnutls lib32-lcms lib32-libxml2
         lib32-mpg123 lib32-openal lib32-v4l-utils lib32-libpulse lib32-alsa-plugins
         lib32-alsa-lib lib32-libjpeg-turbo lib32-libxcomposite lib32-libxinerama
         lib32-ncurses lib32-libcl"
else
    MORE_PKGS="${MORE_PKGS} giflib libpng libldap gnutls lcms libxml2 mpg123 openal v4l-utils libpulse
    alsa-plugins alsa-lib libjpeg-turbo libxcomposite libxinerama ncurses libcl"
fi

pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}
