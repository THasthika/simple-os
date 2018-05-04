#!/bin/bash

if [[ $# -lt 3 ]]
then
    echo "$0 [image file] [bootloader binary] [kernel binary]"
    exit 1
fi

DISK=$1
BOOT=$2
KERN=$3

BOOT_SIZE=$(stat -c%s "$BOOT")
KERN_SIZE=$(stat -c%s "$KERN")

# SIZE=512			# size in MB
BYTESIZE=512			# byte size

COUNT=$(( BOOT_SIZE / BYTESIZE ))
if [[ $(( BOOT_SIZE % BYTESIZE )) != 0 ]]
then
    COUNT=$(( COUNT += 1 ))
fi

KERN_START=$COUNT

COUNT=$(( COUNT += (KERN_SIZE / BYTESIZE) ))
if [[ $(( KERN_SIZE % BYTESIZE )) != 0 ]]
then
    COUNT=$(( COUNT += 1 ))    
fi

dd if=/dev/zero of=${DISK} bs=${BYTESIZE} count=${COUNT}
dd if=${BOOT} of=${DISK} bs=${BYTESIZE} conv=notrunc
dd if=${KERN} of=${DISK} bs=${BYTESIZE} seek=${KERN_START} conv=notrunc