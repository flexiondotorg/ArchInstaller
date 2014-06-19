#!/usr/bin/env bash

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS="${CORE_PKG}-notifier"

pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}
