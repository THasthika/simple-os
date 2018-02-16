ROOT_DIR = ${PWD}
SRC_DIR = ${ROOT_DIR}/src
BUILD_DIR = ${ROOT_DIR}/build
OS_IMG = ${BUILD_DIR}/os.img

BOOT_DIR = ${SRC_DIR}/boot
KERNEL_DIR = ${SRC_DIR}/kernel

BOOT_BIN=${BUILD_DIR}/boot.bin
KERNEL_BIN=${BUILD_DIR}/kernel.bin

QEMU_RUN=qemu-system-i386 -machine q35 -drive format=raw,file=${OS_IMG},if=floppy

export

.PHONY: all clean ${BOOT_BIN} ${KERNEL_BIN}

all: boot kernel

kernel: ${KERNEL_BIN}

boot: ${BOOT_BIN}

os: ${OS_IMG}

clean:
	rm -f ${OS_IMG}
	@make -C ${BOOT_DIR} clean
	@make -C ${KERNEL_DIR} clean

${BOOT_BIN}:
	@make -C ${BOOT_DIR}

${KERNEL_BIN}:
	@make -C ${KERNEL_DIR}

${OS_IMG}: ${BOOT_BIN} ${KERNEL_BIN}
	@echo -n "creating disk image..."
	@dd if=/dev/zero of=${OS_IMG} bs=512 count=2880 2> /dev/null
	@dd conv=notrunc if=${BOOT_BIN} of=${OS_IMG} bs=512 count=1 seek=0 2> /dev/null
	@dd conv=notrunc if=${KERNEL_BIN} of=${OS_IMG} bs=512 count=1 seek=1 2> /dev/null
	@echo " done!"

debug: ${OS_IMG}
	${QEMU_RUN} -gdb tcp::26000 -S

run: ${OS_IMG}
	${QEMU_RUN}
