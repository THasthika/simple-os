SRC := entry.asm stage2.asm

OBJ := $(patsubst %.asm, %.o, $(SRC))

.PHONY: all clean

all: ${OBJ}
	cat $^ > $@

all: ${BOOT_BIN}

clean:
	rm -f ${OBJ} ${BOOT_BIN}

%.o: %.asm
	nasm -f bin $< -o $@

# ${BOOT_BIN}: ${OBJ}
# 	cat $^ > $@
