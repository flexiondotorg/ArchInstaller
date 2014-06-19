#!/usr/bin/env bash

CORE_PKG="devtools"

if [ `uname -m` == "x86_64" ]; then
    MORE_PKGS="multilib-devel"
else
    MORE_PKGS="base-devel"
fi

pacaur -S --needed --noedit ${CORE_PKG} ${MORE_PKGS}
