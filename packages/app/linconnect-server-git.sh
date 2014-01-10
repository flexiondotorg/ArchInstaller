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

if [ -f /usr/bin/ufw ]; then
    ufw allow 9090/tcp
fi

AUTO_DIR="/home/${SUDO_USER}/.config/autostart"
mkdir -p "${AUTO_DIR}"
echo "[Desktop Entry]" > "${AUTO_DIR}"/linconnect-server.desktop
echo "Type=Application" >> "${AUTO_DIR}"/linconnect-server.desktop
echo "Exec=/usr/bin/linconnect-server" >> "${AUTO_DIR}"/linconnect-server.desktop
echo "Hidden=false">> "${AUTO_DIR}"/linconnect-server.desktop
echo "X-MATE-Autostart-enabled=true" >> "${AUTO_DIR}"/linconnect-server.desktop
echo "Name[en_GB]=Android Notification Server" >> "${AUTO_DIR}"/linconnect-server.desktop
echo "Name=Android Notification Server" >> "${AUTO_DIR}"/linconnect-server.desktop
echo "Comment[en_GB]=" >> "${AUTO_DIR}"/linconnect-server.desktop
echo "Comment=" >> "${AUTO_DIR}"/linconnect-server.desktop
chown -R "${SUDO_USER}": "${AUTO_DIR}"


