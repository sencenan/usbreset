#!/usr/bin/env bash

DIR="$(dirname "$(readlink -f "$0")")"

DEVICE=`lsusb \
	| grep 'Mad Catz' \
	| sed -e 's|^Bus \([0-9][0-9]*\) Device \([0-9][0-9]*\).*$|/dev/bus/usb/\1/\2|g'`

echo "executing: $DIR/usbreset $DEVICE"
$DIR/usbreset $DEVICE

# this is switches the power off and on
# very complicated bash script here
find \
	-L /sys/bus/usb/devices/*/product \
	-type f -name "product" -print0 \
	| xargs --null grep --with-filename "Mad" \
	| sed -e 's/^\(\/.*\)product:.*$/\1\/power\/autosuspend/g' \
	| xargs -I % sh -c 'sudo chmod o+x %; echo 0 > %; echo 2 > %';
