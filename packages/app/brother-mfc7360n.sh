#!/usr/bin/env bash

CORE_PKG=$(basename ${0} .sh)-lpr
MORE_PKGS="$(basename ${0} .sh)-cups brscan4"

pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}
