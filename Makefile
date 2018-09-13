export AS:=as
export CC:=gcc
export LD:=ld

export CFLAGS:=-m32 -std=gnu99 -ffreestanding -O2 -Wall -Wextra -nostdlib -nostartfiles -nodefaultlibs -fno-builtin
export LDFLAGS:=-melf_i386

KERNEL_BIN:=src/kernel.bin
OS_ISO:=os.iso

.PHONEY: all clean iso run-qemu $(KERNEL_BIN)

all: $(KERNEL_BIN)

$(KERNEL_BIN):
	$(MAKE) -C src

clean:
	rm -rf isodir
	rm -f $(OS_ISO)
	$(MAKE) -C src clean

iso: $(OS_ISO)

isodir isodir/boot isodir/boot/grub:
	mkdir -p $@

isodir/boot/os.bin: $(KERNEL_BIN) isodir/boot
	cp $< $@

isodir/boot/grub/grub.cfg: grub/grub.cfg isodir/boot/grub
	cp $< $@

$(OS_ISO): isodir/boot/os.bin isodir/boot/grub/grub.cfg
	grub-mkrescue -o $@ isodir

run-qemu: $(OS_ISO)
	qemu-system-i386 -cdrom $(OS_ISO)
