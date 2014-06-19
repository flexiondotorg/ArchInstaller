#!/usr/bin/env bash

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS=""

pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}

wget -c ftp://ftp.supermicro.com/CDR-0010_2.10_IPMI_Server_Managment/res/smcc.ico -O /opt/SUPERMICRO/IPMIView/smcc.ico

cat << DESKTOP > /usr/share/applications/ipmiview.desktop
[Desktop Entry]
Version=1.0
Exec=/opt/IPMIView/IPMIView20.sh
Icon=/opt/SUPERMICRO/IPMIView/smcc.ico
Name=IPMI View
Comment=IPMI View
Encoding=UTF-8
Terminal=false
Type=Application
Categories=System;
DESKTOP
