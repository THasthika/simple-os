#!/bin/bash

if [[ $# -lt 2 ]]
then
    echo "$0 [mount folder] [loop device]"
    exit 1
fi

FOLDER=$1
LOOP=$2

sudo umount $FOLDER
sudo losetup -d $LOOP