#!/usr/bin/env bash

CORE_PKG=$(basename ${0} .sh)-themes-archblue
MORE_PKGS="numix-circle-icon-theme-git"
pacaur -S --needed --noconfirm  --noedit ${CORE_PKG} ${MORE_PKGS}
