ASM_SRC := kernel.asm
C_SRC :=

ASM_OBJ := $(patsubst %.asm, %.o, $(ASM_SRC))
C_OBJ := $(patsubst %.c, %.o, $(C_SRC))

.PHONY: all clean

all: kernel.o

clean:
	rm -f ${ASM_OBJ} ${C_OBJ}

%.o: %.asm
	nasm -f bin $< -o $@
