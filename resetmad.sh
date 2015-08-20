#!/usr/bin/env bash

DIR="$(dirname "$(readlink -f "$0")")"

DEVICE=`lsusb \
	| grep 'Mad Catz' \
	| sed -e 's|^Bus \([0-9][0-9]*\) Device \([0-9][0-9]*\).*$|/dev/bus/usb/\1/\2|g'`

echo "executing: $DIR/usbreset $DEVICE"
$DIR/usbreset $DEVICE
