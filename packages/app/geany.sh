#!/usr/bin/env bash

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS="$(basename ${0} .sh)-plugins markdown"

pacaur -S --needed --noedit --noconfirm ${CORE_PKG} ${MORE_PKGS}
