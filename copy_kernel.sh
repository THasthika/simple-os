DISK_IMAGE=./build/main_floppy.img
KERNEL_FILE=./build/kernel.bin
KERNEL_NAME="::kernel.bin"

MOUNT_POINT=/Volumes/osmount

# attach the image
DISK=$(hdiutil attach -imagekey diskimage-class=CRawDiskImage -nomount $DISK_IMAGE)

hdiutil mount $DISK -mountpoint $MOUNT_POINT

echo "Disk Mounted!"

cp $KERNEL_FILE $MOUNT_POINT/$KERNEL_NAME
echo "Copied the kernel"

hdiutil unmount $DISK

# detach the disk
hdiutil detach $DISK

echo "Disk Unmounted!"