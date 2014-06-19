#!/usr/bin/env bash

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS="${CORE_PKG}-config"

pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}
