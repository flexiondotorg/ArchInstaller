#!/usr/bin/env bash

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS="lib32-glibc"

pacaur -S --needed --noconfirm --noedit ${CORE_PKG}
if [ `uname -m` == "x86_64" ]; then
	pacaur -S --needed --noconfirm --noedit ${MORE_PKGS}
fi
