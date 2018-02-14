SRC := bootloader.asm

OBJ := $(patsubst %.asm, %.o, $(SRC))

.PHONY: all clean

all: bootloader.o

clean:
	rm -f ${OBJ}

%.o: %.asm
	nasm -f bin $< -o $@
