ASM_SRC := $(wildcard *.s **/*.s)
C_SRC := $(wildcard *.c **/*.c)

ASM_OBJ := $(patsubst %.s, %.s.o, $(ASM_SRC))
C_OBJ := $(patsubst %.c, %.c.o, $(C_SRC))

CCFLAGS := -m32 -ffreestanding -nostdlib -nostdinc -fno-builtin -fno-stack-protector -I./
LDFLAGS := -Tmain.ld -m elf_i386 -XLinker -Map=${MAP_FILE}
ASFLAGS := -f elf32

CC=gcc
AS=nasm
LD=ld

.PHONY: all clean

all: ${BIN}

clean:
	rm -f ${ASM_OBJ} ${C_OBJ}

${BIN}: ${ASM_OBJ} ${C_OBJ}
	$(LD) ${LDFLAGS} -o $@ $^

%.s:

%.s.o: %.s
	$(AS) ${ASFLAGS} -o $@ $<

%.c.o: %.c
	$(CC) ${CCFLAGS} -o $@ -c $<
