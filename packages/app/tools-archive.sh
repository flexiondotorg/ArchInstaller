#!/usr/bin/env bash

CORE_PKG=""
MORE_PKGS="arj cabextract bzip2 fastjar gzip lha lz4 lzo2 lzop rpmextract \
sharutils tar unace unrar unzip uudeview xz zip"

pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}
