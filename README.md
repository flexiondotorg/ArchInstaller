# Introduction

ArchInstaller is a suite a bash scripts to automate the installation and
initial confiugration of [Arch Linux](http://www.archlinux.org).

  * `arch-installer.sh` should be run from the [Arch Linux install ISO](https://www.archlinux.org/download/).
  * `gnome-desktop.sh` should be run from a Arch Linux system that was installed using `arch-installer`.

## Features

  * It works for me.
  * Automated installation of base Arch Linux OS. Minimal install option, `-m`, available.
  * `arch-installer.sh` works on PCs (x86 and x86_64) and Raspberry Pi.
  * On x86_64 the `multi-lib` repository is automatically enabled and `multilib-devel` automatically installed.
  * Automated installation/update of GNOME desktop OS.
  * Automatically correct my screw ups (but you have to tell me I've screwed up first).
  * Installations can be sped up via the use of an NFS cache. See below.
  * Power management *"out of the box"*.
  * Adheres to the Arch principle of K.I.S.S.

## Limitations

  * Heavily biased toward my own preferences and may not suit your needs.
  * Do not support UEFI. I don't have any UEFI hardware to test on.
  * Only supports Open Source graphics drivers such as i915, Nouveau and Radeon.
  * Only simple partition recipes are available.

# Install Arch Linux

Boot the [Arch Linux install ISO](https://www.archlinux.org/download/) and clone
ArchInstaller.

    loadkeys uk
    wifi-menu
    dhcpcd
    pacman -Syy git
    git clone https://github.com/flexiondotorg/ArchInstaller.git
    cd ArchInstaller

Edit the `users.csv` file to suite your requirements. Run the installer script,
for example.

## PC

    ./arch-installer.sh -d sda -p bsrh -w pA55w0rd -n myhost.example.org

## Raspberry Pi

The Raspberry Pi mode doesn't do any disk partitioning and the image to
ready to go, that the partition options are redundant on the Pi.

    ./arch-installer.sh -w pA55w0rd -n myhost.example.org

You can get help with the following.

    ./arch-instaler.sh -h

The `arch-installer.sh` will install a base system with some essential tools. It
doesn't install X11 or any desktop environment.

## FONT and FONT_MAP

Read the following to understand how to tweak the `FONT` and `FONT_MAP`
settings in `arch-installer.sh`.

  * <https://wiki.archlinux.org/index.php/Fonts#Console_fonts>
  * <http://en.wikipedia.org/wiki/ISO/IEC_8859>
  * <http://alexandre.deverteuil.net/consolefonts/consolefonts.html>

## NFS Cache

`arch-installer.sh` can use an existing `pacman` cache on an existing host to
speed up the installation time. If you already have a host running Arch Linux
this is how you can share your `pacman` cache via NFS.

    sudo pacman -S nfs-utils

Add the following to `/etc/exports`.

    /var/cache/pacman/pkg   *(rw,no_root_squash)

To start the NFS server, use:

    systemctl start rpc-idmapd.service rpc-mountd.service

To start NFS automatically on every boot, use:

    systemctl enable rpc-idmapd.service rpc-mountd.service

When you execute `arch-installer.sh` pass in the `-c` argument, for example:

    ./arch-installer.sh -d sda -p bsrh -w pA55w0rd -n myhost.example.org -c myexistinghost:/var/cache/pacman/pkg

If you provide `arch-installer.sh` and NFS cache it will enable that cache in
the installed system.

# Install GNOME

Once the system has been installed using `arch-installer.sh` a [GNOME](http://www.gnome.org)
desktop can be installed.

    sudo wifi-menu
    sudo dhcpcd
    cd ~/Source/Mine/ArchInstaller
    sudo ./gnome-desktop.sh

There are no command line switches to control how `gnome-desktop.sh` operates,
but you can edit the script and toogle the following.

    INSTALL_BROWSERS=0
    INSTALL_LIBREOFFICE=0
    INSTALL_GENERAL_DEVELOPMENT=0
    INSTALL_ANDROID_DEVELOPMENT=0
    INSTALL_GOOGLE_EARTH=0
    INSTALL_VIRTUALBOX=0
    INSTALL_CHAT_APPS=0
    INSTALL_GRAPHIC_APPS=0
    INSTALL_3D_APPS=0
    INSTALL_PHOTO_APPS=0
    INSTALL_MUSIC_APPS=0
    INSTALL_VIDEO_PLAYER_APPS=0
    INSTALL_VIDEO_EDITOR_APPS=0
    INSTALL_VIDEO_RIPPER_APPS=0
    INSTALL_REMOTE_DESKTOP_APPS=0
    INSTALL_DOWNLOAD_APPS=0
    INSTALL_ZIMBRA_DESKTOP=0
    INSTALL_IPMIVIEW=0
    INSTALL_RAIDAR=0
    INSTALL_WINE=0
    INSTALL_CRYPTO_APPS=0
    INSTALL_BACKUP_APPS=0

`gnome-desktop.sh` can be run multiple times. It will not re-install anything
that is already present, so subsequent runs are quicker.

# TODO

  * Add automated root partition resizing magic to `arch-installer.sh` for Raspberry Pi.
    * <http://michael.otacoo.com/manuals/raspberry-pi/>
  * Add support for multiple desktop environments.
  * Add support for desktop environment installation profiles that determine what components to install.
  * Detect locale for dictionaries in desktop environment installs.
  * When the script changes something in a user home directory, make that change for all users.
  * Fix Thinkpad hotkeys keys.
    * Run one of the following on system start up.
    * `echo enable,0x00ffffff > /proc/acpi/ibm/hotkey`
    * `cp /sys/devices/platform/thinkpad_acpi/hotkey_all_mask /sys/devices/platform/thinkpad_acpi/hotkey_mask`
    * <http://www.thinkwiki.org/wiki/Thinkpad-acpi>
    * <https://github.com/torvalds/linux/blob/master/Documentation/laptops/thinkpad-acpi.txt>
    * <http://ubuntuforums.org/showthread.php?t=1328016>
    * <https://bbs.archlinux.org/viewtopic.php?id=147160>
  * Review the links below, see if there is anything I can re-use.
    * <https://github.com/helmuthdu/aui>
    * <http://www.winpe.com/page04.html>
    * <http://blog.burntsushi.net/lenovo-thinkpad-t430-archlinux>
    * <http://worldofgnome.org/speed-up-gnome-in-systemd-distributions/>
  * UEFI support - waiting for UEFI support in SYSLINUX.
  * Maybe add putting `/home` on a different disk.
  * Maybe add LVM and LUKS capability to disk partitioning.
  * Investigate zRAM and zSWAP.

## Power Management

Power management is fairly complete right now.

I've opted to use [TLP](http://linrunner.de/en/tlp/tlp.html) for power
management as it provides a comprehensive collection of power management
scripts. `pm-utils` is still being used for suspend/hibernate and resume
functions, but its `power.d` scripts are disabled by `gnome-desktop.sh`.

The following are useful sources of reference.

  * <http://kernel.ubuntu.com/~cking/power-benchmarking/>
  * <http://crunchbang.org/forums/viewtopic.php?id=11954>
  * <http://crunchbang.org/forums/viewtopic.php?id=23456>
  * <https://bbs.archlinux.org/viewtopic.php?id=134109>
  * <http://www.thinkwiki.org/wiki/How_to_reduce_power_consumption>
  * <http://linrunner.de/en/tlp/docs/tlp-faq.html>

### Power Management - TODO

The following still needs attention.

  * Suspend hook for `/dev/mmcblk0`
  * SATA ALPM is disabled by `gnome-desktop.sh` due to the risk of data corruption.
    * <https://bugs.launchpad.net/ubuntu/+source/linux/+bug/539467>
    * <https://wiki.ubuntu.com/Kernel/PowerManagementALPM>
  * Active State Power Management.
    * Add capability to set `pcie_aspm=force`.
      * <https://bbs.archlinux.org/viewtopic.php?id=120640>
      * <http://smackerelofopinion.blogspot.co.uk/2011/03/making-sense-of-pcie-aspm.html>
      * <http://crunchbang.org/forums/viewtopic.php?id=23445>
    * I've submitted a pull request to `laptop-mode-tools`.
      * <https://github.com/rickysarraf/laptop-mode-tools/pull/7>
    * TLP has this capability.
  * Nouveau power management, see below.

#### i915

Power management is implemented.

  * <http://www.kubuntuforums.net/showthread.php?57279-How-to-Enable-power-management-features>
  * <http://www.phoronix.com/scan.php?page=article&item=intel_i915_power&num=1>
  * <http://www.scribd.com/doc/73071712/Intel-Linux-Graphics>

#### Radeon

Power management is implemented.

  * <http://www.x.org/wiki/RadeonFeature#KMS_Power_Management_Options>
  * <https://wiki.archlinux.org/index.php/ATI#Powersaving>
  * <http://www.overclock.net/t/731469/how-to-power-saving-with-the-radeon-driver>

#### Nouveau

Power management is not done yet, waiting on a stable kernel implementation.

  * <http://nouveau.freedesktop.org/wiki/PowerManagement>
  * <http://ubuntuforums.org/showthread.php?t=1718929>
  * <http://www.phoronix.com/scan.php?page=article&item=nouveau_reclocking_one&num=1>

#### Unichrome or OpenChrome

No power management stuff at the moment, just figure out how to get it working.

  * <https://wiki.archlinux.org/index.php/Via_Unichrome>
  * <https://bbs.archlinux.org/viewtopic.php?pid=1104036>
  * <https://bbs.archlinux.org/viewtopic.php?pid=1201986>
  * <http://www.openchrome.org/>
  * <http://unichrome.sourceforge.net/>
