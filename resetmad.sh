#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

DEVICE=`lsusb \
	| grep 'Mad Catz' \
	| sed -e 's|^Bus \([0-9][0-9]*\) Device \([0-9][0-9]*\).*$|/dev/bus/usb/\1/\2|g'`

echo "executing: $DIR/usbreset $DEVICE"
$DIR/usbreset $DEVICE
