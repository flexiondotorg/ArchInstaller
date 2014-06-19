#!/usr/bin/env bash

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS="python-pip python-setuptools python-virtualenv \
python2-pip python2-distribute python2-virtualenv python-virtualenvwrapper"

pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}
