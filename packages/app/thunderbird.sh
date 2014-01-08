#!/usr/bin/env bash

if [ `id -u` -ne 0 ]; then
    echo "ERROR! `basename ${0}` must be executed as root."
    exit 1
fi

# Determine locale for Firefox
LOCALE=$(echo ${LANG} | cut -d'.' -f1)
if [ "${LOCALE}" == "pt_BR" ] || [ "${LOCALE}" == "pt_PT" ] ||
   [ "${LOCALE}" == "en_GB" ] || [ "${LOCALE}" == "en_US" ] ||
   [ "${LOCALE}" == "es_AR" ] || [ "${LOCALE}" == "es_CL" ] ||
   [ "${LOCALE}" == "es_ES" ] || [ "${LOCALE}" == "zh_CN" ]; then
    LOCALE_TB=`echo ${LOCALE} | tr '[:upper:]' '[:lower:]' | sed 's/_/-/'`
else
    LOCALE_TB=`echo ${LOCALE} | cut -d\_ -f1`
fi

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS="${CORE_PKG}-i18n-${LOCALE_TB}"

pacman -S --needed --noconfirm ${CORE_PKG} ${MORE_PKGS}

IS_INSTALLED=$(pacman -Qqm thunderbird-enigmail-bin)
if [ $? -ne 0 ]; then
    packer -S --noedit --noconfirm thunderbird-enigmail-bin
fi
