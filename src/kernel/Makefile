# gcc kmain.c -o kernel.bin --freestanding -fstrength-reduce -fomit-frame-pointer -finline-functions -fno-builtin -nostdlib -nostartfiles -nodefaultlibs -Wall -Werror -O0 -Iinc -m32 -fno-pic

ASM_SRC := $(wildcard *.s **/*.s)
C_SRC := $(wildcard *.c **/*.c)

ASM_OBJ := $(patsubst %.s, %.s.o, $(ASM_SRC))
C_OBJ := $(patsubst %.c, %.c.o, $(C_SRC))

CCFLAGS := -m32 -ffreestanding -nostdlib -nostdinc -fno-builtin -fno-stack-protector -fno-pic -I./
LDFLAGS := -Tmain.ld
ASFLAGS := -f bin

CC=gcc
AS=nasm
LD=ld

.PHONY: all clean

all: test

test: ${ASM_OBJ} ${C_OBJ}
	$(LD) ${LDFLAGS} -o $@ $^

# all: ${BIN}

clean:
	rm -f ${ASM_OBJ} ${C_OBJ}

${BIN}: ${ASM_OBJ} ${C_OBJ}
	$(LD) ${LDFLAGS} -o $@ $^

%.s:

%.s.o: %.s
	$(AS) ${ASFLAGS} -o $@ $<

%.c.o: %.c
	$(CC) ${CCFLAGS} -o $@ -c $<
