#!/usr/bin/env bash

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS=""

pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}

ufw limit tcp/22
ufw default deny
ufw logging off
systemctl enable ufw
systemctl start ufw
ufw enable
