#!/bin/sh
set -e
. ./build.sh

mkdir -p isodir
mkdir -p isodir/boot
mkdir -p isodir/boot/grub

cp sysroot/boot/kernel.bin isodir/boot/kernel.bin
cat > isodir/boot/grub/grub.cfg << EOF
menuentry "os" {
	multiboot /boot/kernel.bin
}
EOF
grub-mkrescue -o os.iso isodir
