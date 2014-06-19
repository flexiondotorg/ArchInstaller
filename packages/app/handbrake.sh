#!/usr/bin/env bash

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS="gst-libav gst-plugins-good"

pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}
