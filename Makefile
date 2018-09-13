AS:=as
CC:=gcc
LD:=ld

CFLAGS:=-ffreestanding -O2 -Wall -Wextra -nostdlib -nostartfiles -nodefaultlibs -fno-builtin
LDFLAGS:=-melf_i386

OBJS:=\
	boot.o\
	kernel.o\



.PHONEY: all clean iso run-qemu

all: os.bin

os.bin: linker.ld $(OBJS)
	$(LD) $(LDFLAGS) -T $< -o $@ $(OBJS)

%.o: %.c
	$(CC) -m32 -c $< -o $@ -std=gnu99 $(CFLAGS)

%.o: %.s
	$(AS) $< -o $@ --32

clean:
	rm -rf isodir
	rm -f os.bin os.iso $(OBJS)

iso: os.iso

isodir isodir/boot isodir/boot/grub:
	mkdir -p $@

isodir/boot/os.bin: os.bin isodir/boot
	cp $< $@

isodir/boot/grub/grub.cfg: grub.cfg isodir/boot/grub
	cp $< $@

os.iso: isodir/boot/os.bin isodir/boot/grub/grub.cfg
	grub-mkrescue -o $@ isodir

run-qemu: os.iso
	qemu-system-i386 -cdrom os.iso
