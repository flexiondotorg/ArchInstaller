#!/usr/bin/env bash

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS="gstreamer0.10-base-plugins gstreamer0.10-good-plugins gstreamer0.10-bad-plugins gstreamer0.10-ugly-plugins gvfs-mtp"

pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}
