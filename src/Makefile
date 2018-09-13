.PHONY: all clean

SRC:=\
	boot.s\
	kmain.c
OBJ=$(patsubst %.c,%.o,$(SRC))
FOBJ=$(patsubst %.s,%.o,$(OBJ))

kernel.bin: linker.ld $(FOBJ)
	$(LD) $(LDFLAGS) -T $< -o $@ $(FOBJ)

%.o: %.c
	$(CC) -c $< -o $@ $(CFLAGS)

%.o: %.s
	$(AS) $< -o $@ --32

clean:
	rm -f $(FOBJ)
	rm -f kernel.bin
