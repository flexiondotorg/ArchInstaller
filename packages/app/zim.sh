#!/usr/bin/env bash

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS="scrot python2-gtkspell"

pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}
