#!/usr/bin/env bash

LOCALE=$(echo ${LANG} | cut -d'.' -f1)
if [ "${LOCALE}" == "pt_BR" ] || [ "${LOCALE}" == "en_GB" ] ||
   [ "${LOCALE}" == "en_US" ] || [ "${LOCALE}" == "zh_CN" ]]; then
    LOCALE_LO=$(echo ${LOCALE} | sed 's/_/-/')
else
    LOCALE_LO=$(echo ${LOCALE} | cut -d\_ -f1)
fi

CORE_PKG=""
MORE_PKGS="artwiz-fonts libreoffice-calc libreoffice-common libreoffice-gnome \
libreoffice-impress libreoffice-math libreoffice-writer libreoffice-${LOCALE_LO} \
ttf-dejavu unoconv hunspell-en hyphen-en mythes-en"

# If you want the database tool uncomment this.
#MORE_PKGS="${MORE_PKS} libreoffice-base"

# If you want the drawing tool uncomment this.
#MORE_PKGS="${MORE_PKS} libreoffice-draw"

pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}
