#!/usr/bin/env bash

# Determine locale for Firefox
LOCALE=$(echo ${LANG} | cut -d'.' -f1)
if [ "${LOCALE}" == "pt_BR" ] || [ "${LOCALE}" == "pt_PT" ] ||
   [ "${LOCALE}" == "en_GB" ] || [ "${LOCALE}" == "en_US" ] ||
   [ "${LOCALE}" == "es_AR" ] || [ "${LOCALE}" == "es_CL" ] ||
   [ "${LOCALE}" == "es_ES" ] || [ "${LOCALE}" == "zh_CN" ]; then
    LOCALE_FF=`echo ${LOCALE} | tr '[:upper:]' '[:lower:]' | sed 's/_/-/'`
else
    LOCALE_FF=`echo ${LOCALE} | cut -d\_ -f1`
fi

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS="${CORE_PKG}-i18n-${LOCALE_FF} flashplugin"

pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}

if [ `uname -m` == "x86_64" ]; then
        pacaur -S --needed --noconfirm --noedit  lib32-flashplugin
fi
