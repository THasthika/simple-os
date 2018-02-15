SRC := bootloader.asm

OBJ := $(patsubst %.asm, %.o, $(SRC))

.PHONY: all clean

all: bootloader.bin

clean:
	rm -f ${OBJ} bootloader.bin

%.o: %.asm
	nasm -f bin $< -o $@

bootloader.bin: ${OBJ}
	cat $^ > $@
