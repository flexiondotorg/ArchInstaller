#!/usr/bin/env bash

CORE_PKG=""
MORE_PKGS="cifs-utils btrfs-progs dosfstools jfsutils f2fs-tools exfat-utils \
ntfsprogs ntfs-3g reiserfsprogs xfsprogs nilfs-utils gpart mtools"

pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}
