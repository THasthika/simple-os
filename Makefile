ROOT_DIR = ${PWD}
SRC_DIR = ${ROOT_DIR}/src
BUILD_DIR = ${ROOT_DIR}/build
OS_IMG = ${BUILD_DIR}/disk.img

export

.PHONY: all clean

all: os

clean:
	rm -f ${OS_IMG}
	@make -C src clean

os:
	@make -C src

debug: os
	qemu-system-i386 -machine q35 -drive format=raw,file=${OS_IMG},if=floppy -gdb tcp::26000 -S

run: os
	qemu-system-i386 -machine q35 -drive format=raw,file=${OS_IMG},if=floppy

