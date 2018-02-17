#!/bin/bash

if [[ $# -lt 1 ]]
then
    echo "Specify Disk Image!"
    exit 1
fi

DISK=$1
SIZE=240			# size in MB
BYTESIZE=512			# byte size

COUNT=$(((SIZE * 1024 * 1024) / BYTESIZE))

dd if=/dev/zero of=$1 bs=${BYTESIZE} count=${COUNT}

# to create the partitions programatically (rather than manually)
# we're going to simulate the manual input to fdisk
# The sed script strips off all the comments so that we can 
# document what we're doing in-line with the actual commands
# Note that a blank line (commented as "defualt" will send a empty
# line terminated with a newline to take the fdisk default.
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk ${DISK}
  o # clear the in memory partition table
  n # new partition
  p # primary partition
  1 # partition number 1
    # default - start at beginning of disk 
    # default - end of the disk
  t # change partition type
  b # select FAT32
  a # make a partition bootable
  p # print the in-memory partition table
  w # write the partition table
  q # and we're done
EOF

sudo losetup /dev/loop0 ${DISK}
sudo losetup /dev/loop1 ${DISK} -o 1048576

sudo mkdosfs -F32 -f 2 /dev/loop1

sudo mount /dev/loop1 /mnt

sudo grub-install --root-directory=/mnt --target=i386-pc --no-floppy --modules="normal part_msdos ext2 multiboot" /dev/loop0

sync

sudo umount /mnt

sudo losetup -d /dev/loop1
sudo losetup -d /dev/loop0
