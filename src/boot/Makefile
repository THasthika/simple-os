SRC := entry.asm

OBJ := $(patsubst %.asm, %.o, $(SRC))

.PHONY: all clean

all: ${BOOT_BIN}

clean:
	rm -f ${OBJ} ${BOOT_BIN}

%.o: %.asm
	nasm -f bin $< -o $@

${BOOT_BIN}: ${OBJ}
	cat $^ > $@
