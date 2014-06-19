#!/usr/bin/env bash

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS="pygtksourceview2 python2-dbus"

pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}
