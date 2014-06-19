#!/usr/bin/env bash

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
MORE_PKGS="${CORE_PKG}-i18n-${LOCALE_TB} thunderbird-enigmail-bin"

pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}
