#!/usr/bin/env bash

if [ `id -u` -ne 0 ]; then
    echo "ERROR! `basename ${0}` must be executed as root."
    exit 1
fi

# http://alucryd.deviantart.com/art/Stripes-ArchLinux-GDM-Wallpaper-282675061
# http://alucryd.deviantart.com/art/Stripes-ArchLinux-Wallpaper-265618193
mkdir -p /usr/local/share/backgrounds/stripes/
cp stripes_archlinux_gdm_by_alucryd.png /usr/local/share/backgrounds/stripes/stripes-gdm.png
cp stripes_archlinux_wallpaper_by_alucryd.png /usr/local/share/backgrounds/stripes/stripes-wallpaper.png
rm -f /usr/share/backgrounds/mate/desktop/Stripes.png
ln -s /usr/local/share/backgrounds/stripes/stripes-wallpaper.png /usr/share/backgrounds/mate/desktop/Stripes.png

sed -i 's/#background=/background=\/usr\/local\/share\/backgrounds\/stripes\/stripes-gdm\.png/' /etc/lightdm/lightdm-gtk-greeter.conf
