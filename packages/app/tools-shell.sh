#!/usr/bin/env bash

CORE_PKG=""
MORE_PKGS="aria2 bash-completion colordiff curl dfc ddrescue glances \
hexedit htop laptop-detect lesspipe powertop screen tree"

pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}
