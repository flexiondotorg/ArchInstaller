#!/usr/bin/env bash

if [ `id -u` -eq 0 ]; then
    echo "ERROR! `basename ${0}` must be executed as a regular user."
    exit 1
fi

THEME="eighties"

CORE_PKG="ruby"
MORE_PKGS="git unzip"

echo "About to install : ${CORE_PKG} ${MORE_PKGS}"
pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}

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

# dircolors
#  - https://github.com/seebi/dircolors-solarized
wget -q "https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark" -O ${BASE16_DIR}/dircolors-dark
wget -q "https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-light" -O ${BASE16_DIR}/dircolors-light
rm -f ${HOME}/.dircolors
ln -s ${BASE16_DIR}/dircolors-dark ${HOME}/.dircolors
eval $(dircolors ${HOME}/.dircolors)

# Shell
echo "base16 for Bash"
chmod +x ${BASE16_DIR}/shell/*.sh
. ${BASE16_DIR}/shell/base16-${THEME}.dark.sh


# Geany
echo "base16 for Geany"
mkdir -p ${HOME}/.config/geany/colorschemes
cp ${BASE16_DIR}/geany/*.conf ${HOME}/.config/geany/colorschemes

# MATE Terminal
echo "base16 for MATE Terminal"
chmod +x ${BASE16_DIR}/mate-terminal/*.sh
#for SH in ${BASE16_DIR}/mate-terminal/*.sh
#do
#    ${SH}
#done
${BASE16_DIR}/mate-terminal/base16-${THEME}.dark.sh

# X resources
echo "base16 for X resources"
cp ${BASE16_DIR}/xresources/base16-${THEME}.dark.xresources ${HOME}/.Xresources
rm -f ${HOME}/.Xdefaults
ln -s ${HOME}/.Xresources ${HOME}/.Xdefaults
echo >> ${HOME}/.Xresources

# Pluma
echo "base16 for Pluma"
if [ ! -d ${HOME}/.local/share/gtksourceview-2.0/styles ]; then
    mkdir -p ${HOME}/.local/share/gtksourceview-2.0/styles
fi
rm -f ${HOME}/.local/share/gtksourceview-2.0/styles/*.xml
cp ${BASE16_DIR}/gedit/*.xml ${HOME}/.local/share/gtksourceview-2.0/styles

# Terminator
echo "base16 for Terminator"
if [ ! -d ${HOME}/.config/terminator/ ]; then
    mkdir -p ${HOME}/.config/terminator/
fi
cp ${BASE16_DIR}/terminator/base16-${THEME}.dark.config ${HOME}/.config/terminator/config

# HexChat
#  - http://hexchat.github.io/themes.html
#  - http://www.ultrabug.fr/switching-from-xchat-to-hexchat/
if [ ! -d ${HOME}/.config/hexchat ]; then
    mkdir -p ${HOME}/.config/hexchat
fi
wget -q "http://dl.hexchat.net/themes/Cool.hct" -O /tmp/cool.hct
cd ${HOME}/.config/hexchat
unzip -o /tmp/cool.hct
rm -f ${HOME}/.config/hexchat/\[Content_Types\].xml

cd /tmp
rm -rf nanorc
git clone https://github.com/nanorc/nanorc.git
cd nanorc
make
make install

