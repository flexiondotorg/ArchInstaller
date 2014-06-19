#!/usr/bin/env bash

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS=""

pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}

echo "fs.inotify.max_user_watches = 131072" > /etc/sysctl.d/98-fs.inotify.max_user_watches.conf
