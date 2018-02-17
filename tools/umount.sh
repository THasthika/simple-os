#!/bin/bash

if [ $# -lt 1 ]
then
	echo must specify the mount directory
	exit 1
fi

sudo umount $1 2> /dev/null
