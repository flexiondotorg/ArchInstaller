#!/usr/bin/env bash

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS="id3v2 mp3gain vorbisgain"

pacaur -S --needed --noconfirm --noedit ${MORE_PKGS}

