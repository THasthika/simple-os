ROOT_DIR = ${PWD}
SRC_DIR = ${ROOT_DIR}/src
BUILD_DIR = ${ROOT_DIR}/build
OS_IMG = ${BUILD_DIR}/os.img

BOOTLOADER_DIR = ${SRC_DIR}/boot
KERNEL_DIR = ${SRC_DIR}/kernel

BOOTLOADER_BIN=${BOOTLOADER_DIR}/bootloader.bin
KERNEL_BIN=${KERNEL_DIR}/kernel.bin

QEMU_RUN=qemu-system-i386 -machine q35 -drive format=raw,file=${OS_IMG},if=floppy

export

.PHONY: all clean ${BOOTLOADER_BIN} ${KERNEL_BIN}

all: ${OS_IMG}

clean:
	rm -f ${OS_IMG}
	@make -C ${BOOTLOADER_DIR} clean
	@make -C ${KERNEL_DIR} clean

${BOOTLOADER_BIN}:
	@make -C ${BOOTLOADER_DIR}

${KERNEL_BIN}:
	@make -C ${KERNEL_DIR}

${OS_IMG}: ${BOOTLOADER_BIN} ${KERNEL_BIN}
	@echo -n "creating disk image..."
# @dd if=/dev/zero of=${OS_IMG} bs=1M count=128 2> /dev/null
# @dd conv=notrunc if=${BOOTLOADER_BIN} of=${OS_IMG} bs=512 count=1 seek=0 2> /dev/null
# @dd conv=notrunc if=${KERNEL_BIN} of=${OS_IMG} bs=512 count=1 seek=1 2> /dev/null
	cat ${BOOTLOADER_BIN} ${KERNEL_BIN} > ${OS_IMG}
	@echo " done!"

debug: ${OS_IMG}
	${QEMU_RUN} -gdb tcp::26000 -S

run: ${OS_IMG}
	${QEMU_RUN}
