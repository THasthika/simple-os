ASM_SRC := start.asm

KERNEL_C_SRC := kmain.c\
		common.c

DRIVERS_C_SRC := drivers/screen.c

C_SRC := ${KERNEL_C_SRC} ${DRIVERS_C_SRC}

ASM_OBJ := $(patsubst %.asm, %.asm.o, $(ASM_SRC))
C_OBJ := $(patsubst %.c, %.c.o, $(C_SRC))

CCFLAGS := -m32 -ffreestanding -nostdlib -nostdinc -fno-builtin -fno-stack-protector
LDFLAGS := -Tmain.ld -m elf_i386
ASFLAGS := -f elf32

CC=gcc
AS=nasm
LD=ld

.PHONY: all clean

all: ${BIN}

clean:
	rm -f ${ASM_OBJ} ${C_OBJ} ${BIN}

${BIN}: ${ASM_OBJ} ${C_OBJ}
	$(LD) ${LDFLAGS} -o $@ $^

%.asm:

%.asm.o: %.asm
	$(AS) ${ASFLAGS} -o $@ $<

%.c.o: %.c
	$(CC) ${CCFLAGS} -o $@ -c $<
