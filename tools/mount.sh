#!/bin/bash

if [ $# -lt 2 ]
then
	echo must specify device and mount directory
	exit 1
fi

uid=$(id -u)
gid=$(id -g)

DISK=$1

sudo umount $2 2> /dev/null
mkdir -p $2
sudo umount $1 2> /dev/null

# sudo losetup /dev/loop0 ${DISK} -o 1048576

sudo mount -o loop,offset=1048576,gid=$gid,uid=$uid ${DISK} $2
