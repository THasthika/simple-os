# make -C bootloader
# make -C os
# dd if=/dev/zero of=disk.img bs=512 count=2880
# dd conv=notrunc if=bootloader/bootloader.o of=disk.img bs=512 count=1 seek=0
# dd conv=notrunc if=os/kernel.o of=disk.img bs=512 count=1 seek=1

BOOTLOADER_SRC := bootloader/bootloader.asm

OS_ASM_SRC := os/kernel.asm

OS_C_SRC :=

BOOTLOADER_OBJ := $(patsubst %.asm, %.o, $(BOOTLOADER_SRC))
OS_ASM_OBJ := $(patsubst %.asm, %.o, $(OS_ASM_SRC))
OS_C_OBJ := $(patsubst %.c, %.o, $(OS_C_SRC))

.PHONY: all clean

all: ${OS_IMG}

clean:
	rm -f ${BOOTLOADER_OBJ} ${OS_ASM_OBJ} ${OS_C_OBJ}

%.o: %.asm
	nasm -f bin $< -o $@

# bootloader/bootloader.o: ${BOOTLOADER_OBJ}

# os/kernel.o: ${OS_ASM_OBJ} ${OS_C_OBJ}

${OS_IMG}: bootloader/bootloader.o os/kernel.o
	dd if=/dev/zero of=${OS_IMG} bs=512 count=2880
	dd conv=notrunc if=bootloader/bootloader.o of=${OS_IMG} bs=512 count=1 seek=0
	dd conv=notrunc if=os/kernel.o of=${OS_IMG} bs=512 count=1 seek=1
