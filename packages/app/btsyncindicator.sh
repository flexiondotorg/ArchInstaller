#!/usr/bin/env bash

if [ `id -u` -ne 0 ]; then
    echo "ERROR! `basename ${0}` must be executed as root."
    exit 1
fi

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS=""

IS_INSTALLED=$(pacman -Qqm ${CORE_PKG})
if [ $? -ne 0 ]; then
    packer -S --noedit --noconfirm ${CORE_PKG} ${MORE_PKGS}
else
    echo "${CORE_PKG} is already installed."
fi

AUTO_DIR="/home/${SUDO_USER}/.config/autostart"
mkdir -p "${AUTO_DIR}"
echo "[Desktop Entry]" > "${AUTO_DIR}"/btsyncindicator.desktop
echo "Name=Bittorrent Sync Indicator" >> "${AUTO_DIR}"/btsyncindicator.desktop
echo "Comment=Bittorrent Sync indicator for Linux desktops" >> "${AUTO_DIR}"/btsyncindicator.desktop
echo "Exec=btsyncindicator --config /home/${SUDO_USER}/.config/btsync/btsync.conf --iconpath /usr/share/pixmaps/btsyncindicator" >> "${AUTO_DIR}"/btsyncindicator.desktop
echo "Icon=/usr/share/pixmaps/btsyncindicator/btsync.png" >> "${AUTO_DIR}"/btsyncindicator.desktop
echo "Terminal=false" >> "${AUTO_DIR}"/btsyncindicator.desktop
echo "Type=Application" >> "${AUTO_DIR}"/btsyncindicator.desktop
echo "Categories=Network;" >> "${AUTO_DIR}"/btsyncindicator.desktop
echo "StartupNotify=false" >> "${AUTO_DIR}"/btsyncindicator.desktop
echo "X-MATE-Autostart-enabled=true" >> "${AUTO_DIR}"/btsyncindicator.desktop
chown -R "${SUDO_USER}": "${AUTO_DIR}"
