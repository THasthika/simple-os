#!/bin/bash

if [[ $# -lt 2 ]]
then
    echo "$0 [disk file] [bootloader binary]"
    exit 1
fi

DISK=$1
BOOT=$2

BOOT_SIZE=$(stat -c%s "$BOOT")

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

dd if=${DISK} of=tmp bs=1 skip=440 count=72 > /dev/null
dd if=${BOOT} of=${DISK} bs=${BYTESIZE} count=1 conv=notrunc > /dev/null
dd if=tmp of=${DISK} bs=1 seek=440 count=72 conv=notrunc > /dev/null
dd if=${BOOT} of=${DISK} bs=${BYTESIZE} ibs=512 obs=512 skip=1 seek=1 conv=notrunc > /dev/null

rm tmp