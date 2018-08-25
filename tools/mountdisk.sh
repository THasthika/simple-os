#!/bin/bash

if [[ $# -lt 6 ]]
then
    echo "$0 [disk image] [mount folder] [loop device] [start sector] [end sector] [sector size]"
    exit 1
fi

DISK_IMG=$1
FOLDER=$2
LOOP=$3
SS=$4
ES=$5
SSIZE=$6

SPOSITION=$((SS*SSIZE))
EPOSITION=$((ES*SSIZE))

sudo losetup -o $SPOSITION --sizelimit $EPOSITION $LOOP $DISK_IMG
if [[ $? -ne 0 ]]
then
    echo "Could not mount"
    exit 1
fi

sudo mount -o uid=1000 $LOOP $FOLDER
