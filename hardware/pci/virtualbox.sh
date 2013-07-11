#!/usr/bin/env bash

exit 0

# NEED IMPLEMENTING

UNAME_M=`uname -m`
KMS="radeon"
KMS_OPTIONS="modeset=1"
DRI="ati-dri"
DDX="xf86-video-ati"
DECODER="libva-vdpau-driver"

pacman -S --noconfirm --needed ${DRI} ${DECODER}
if [ "${UNAME_M}" == "x86_64" ]; then
    pacman -S --noconfirm --needed lib32-${DRI} lib32-mesa-libgl
fi
echo "options ${KMS} ${KMS_OPTIONS}" > "${KMS}.conf"
