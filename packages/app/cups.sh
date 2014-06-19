#!/usr/bin/env bash

CUPS=""
if [ -f ../desktop/cups.txt ]; then
    CUPS="../desktop/cups.txt"
elif [ -f packages/desktop/cups.txt ]; then
    CUPS="packages/desktop/cups.txt"
fi

if [ -f ${CUPS} ]; then
    pacaur -S --needed --noconfirm --noedit `cat ${CUPS}`

    if [ `uname -m` == "x86_64" ]; then
		pacaur -S --needed --noconfirm --noedit lib32-libcups
    fi
else
    echo "Something went wrong."
fi

systemctl enable cups
