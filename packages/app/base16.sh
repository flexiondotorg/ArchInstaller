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
mkdir -p /templates/terminator/
cat << 'TERMINATOR' > /templates/terminator/dark.config.erb
[global_config]
  title_transmit_bg_color = "#<%= @base["08"]["hex"] %>"
  title_inactive_bg_color = "#<%= @base["03"]["hex"] %>"
  focus = system
[keybindings]
[profiles]
  [[default]]
    use_system_font = False
    font = Ubuntu Mono Bold 13
    background_image = None
    copy_on_selection = True
    allow_bold = False
    palette = "#<%= @base["00"]["hex"] %>:#<%= @base["08"]["hex"] %>:#<%= @base["0B"]["hex"] %>:#<%= @base["0A"]["hex"] %>:#<%= @base["0D"]["hex"] %>:#<%= @base["0E"]["hex"] %>:#<%= @base["0C"]["hex"] %>:#<%= @base["05"]["hex"] %>:#<%= @base["03"]["hex"] %>:#<%= @base["09"]["hex"] %>:#<%= @base["01"]["hex"] %>:#<%= @base["02"]["hex"] %>:#<%= @base["04"]["hex"] %>:#<%= @base["06"]["hex"] %>:#<%= @base["0F"]["hex"] %>:#<%= @base["07"]["hex"] %>"
    foreground_color = "#<%= @base["05"]["hex"] %>"
    background_color = "#<%= @base["00"]["hex"] %>"
    cursor_color = "#<%= @base["05"]["hex"] %>"

  [[Base16 <%= @scheme %> Dark]]
    use_system_font = False
    font = Ubuntu Mono Bold 13
    background_image = None
    copy_on_selection = True
    allow_bold = False
    palette = "#<%= @base["00"]["hex"] %>:#<%= @base["08"]["hex"] %>:#<%= @base["0B"]["hex"] %>:#<%= @base["0A"]["hex"] %>:#<%= @base["0D"]["hex"] %>:#<%= @base["0E"]["hex"] %>:#<%= @base["0C"]["hex"] %>:#<%= @base["05"]["hex"] %>:#<%= @base["03"]["hex"] %>:#<%= @base["09"]["hex"] %>:#<%= @base["01"]["hex"] %>:#<%= @base["02"]["hex"] %>:#<%= @base["04"]["hex"] %>:#<%= @base["06"]["hex"] %>:#<%= @base["0F"]["hex"] %>:#<%= @base["07"]["hex"] %>"
    foreground_color = "#<%= @base["05"]["hex"] %>"
    background_color = "#<%= @base["00"]["hex"] %>"
    cursor_color = "#<%= @base["05"]["hex"] %>"

[layouts]
  [[default]]
    [[[child1]]]
      type = Terminal
      parent = window0
      profile = Base16 <%= @scheme %> Dark
    [[[window0]]]
      type = Window
      parent = ""
[plugins]
TERMINATOR

# Build base16
./base16

BASE16_DIR="${HOME}/.base16/base16-builder/output"

# Shell
echo "base16 for Bash"
chmod +x ${BASE16_DIR}/shell/*.sh

# Geany
echo "base16 for Geany"
# Patch incorrent background color
for CONF in ${BASE16_DIR}/geany/*.conf ${HOME}/.config/geany/colorschemes/*.conf
do
    sed -i 's/202020/151515/g' ${CONF}
done
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
