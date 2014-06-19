#!/usr/bin/env bash

CORE_PKG=""
MORE_PKGS="hwinfo lshw  memconf"

pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}
