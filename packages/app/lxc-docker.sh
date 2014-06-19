#!/usr/bin/env bash

CORE_PKG=$(basename ${0} .sh)
MORE_PKGS=""

pacaur -S --needed --noconfirm --noedit ${CORE_PKG} ${MORE_PKGS}

systemctl enable docker
# Enable the forwarding and make it persist.
sysctl net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/docker.conf


