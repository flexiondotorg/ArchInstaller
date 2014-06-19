#!/usr/bin/env bash

CORE_PKG=""
MORE_PKGS="cvs bzr bzr-fastimport git mercurial subversion"

pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}
