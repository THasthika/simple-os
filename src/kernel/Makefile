ASM_SRC := entry.asm

KERNEL_C_SRC := kmain.c\
		io.c\
		util.c

DRIVERS_C_SRC := \
		drivers/screen.c

C_SRC := ${KERNEL_C_SRC} ${DRIVERS_C_SRC}

ASM_OBJ := $(patsubst %.asm, %.asmo, $(ASM_SRC))
C_OBJ := $(patsubst %.c, %.o, $(C_SRC))

EXEC_ADDR := 0x1000

.PHONY: all clean

all: ${KERNEL_BIN}

clean:
	rm -f ${ASM_OBJ} ${C_OBJ} ${KERNEL_BIN}

${KERNEL_BIN}: ${ASM_OBJ} ${C_OBJ}
	ld -m elf_i386 -o $@ -Ttext ${EXEC_ADDR} $^ --oformat binary

%.asmo: %.asm
	nasm -f elf $< -o $@

%.o: %.c
	gcc -ffreestanding -m32 -c $< -o $@
