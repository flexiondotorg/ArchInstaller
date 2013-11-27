#!/usr/bin/env bash

if [ `id -u` -eq 0 ]; then
    echo "ERROR! `basename ${0}` must be executed as a regular user."
    exit 1
fi

CORE_PKG="ruby"
MORE_PKGS="git unzip"

echo "About to install : ${CORE_PKG} ${MORE_PKGS}"
sudo pacman -S --needed --noconfirm ${CORE_PKG} ${MORE_PKGS}

if [ ! -d ${HOME}/.base16 ]; then
    mkdir ${HOME}/.base16
fi
cd ${HOME}/.base16

if [ -d base16-builder/.git ]; then
    rm -rf base16-builder
fi

git clone https://github.com/chriskempson/base16-builder.git
cd base16-builder
./base16

BASE16_DIR="${HOME}/.base16/base16-builder/output"

# Shell
echo "base16 for Bash"
chmod +x ${BASE16_DIR}/shell/*.sh

# Geany
echo "base16 for Geany"
# Patch incorrent background color
#for CONF in ${BASE16_DIR}/geany/*.conf ${HOME}/.config/geany/colorschemes/*.conf
#do
#    sed -i 's/202020/151515/g' ${CONF}
#done
mkdir -p ${HOME}/.config/geany/colorschemes
cp ${BASE16_DIR}/geany/*.conf ${HOME}/.config/geany/colorschemes

# MATE Terminal
echo "base16 for MATE Terminal"
chmod +x ${BASE16_DIR}/mate-terminal/*.sh
for SH in ${BASE16_DIR}/mate-terminal/*.sh
do
    ${SH}
done

# X resources
echo "base16 for X resources"
cp ${BASE16_DIR}/xresources/base16-default.dark.xresources ${HOME}/.Xresources
echo >> ${HOME}/.Xresources

# Pluma
echo "base16 for Pluma"
if [ ! -d ${HOME}/.local/share/gtksourceview-2.0/styles ]; then
    mkdir -p ${HOME}/.local/share/gtksourceview-2.0/styles
fi
cp ${BASE16_DIR}/gedit/*.xml ${HOME}/.local/share/gtksourceview-2.0/styles

# Terminator
echo "base16 for Terminator"
if [ ! -d ${HOME}/.config/terminator/ ]; then
    mkdir -p ${HOME}/.config/terminator/
fi

cp ${BASE16_DIR}/terminator/base16-default.dark.config ${HOME}/.config/terminator/config

# HexChat
