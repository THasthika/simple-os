DISK_IMAGE=./build/main_floppy.img
MOUNT_POINT=/Volumes/osmount

# attach the image
DISK=$(hdiutil attach -imagekey diskimage-class=CRawDiskImage -nomount $DISK_IMAGE)

hdiutil mount $DISK -mountpoint $MOUNT_POINT

echo "Mounted: $DISK"