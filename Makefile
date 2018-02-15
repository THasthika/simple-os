ROOT_DIR = ${PWD}
SRC_DIR = ${ROOT_DIR}/src
BUILD_DIR = ${ROOT_DIR}/build
OS_IMG = ${BUILD_DIR}/disk.img

BOOTLOADER_DIR = ${SRC_DIR}/bootloader
KERNEL_DIR = ${SRC_DIR}/kernel

BOOTLOADER_O=${BOOTLOADER_DIR}/bootloader.o
KERNEL_O=${KERNEL_DIR}/kernel.o

QEMU_RUN=qemu-system-i386 -machine q35 -drive format=raw,file=${OS_IMG},if=ide

export

.PHONY: all clean ${BOOTLOADER_O} ${KERNEL_O}

all: ${OS_IMG}

clean:
	rm -f ${OS_IMG}
	@make -C ${BOOTLOADER_DIR} clean
	@make -C ${KERNEL_DIR} clean

${BOOTLOADER_O}:
	@make -C ${BOOTLOADER_DIR}

${KERNEL_O}:
	@make -C ${KERNEL_DIR}

${OS_IMG}: ${BOOTLOADER_O} ${KERNEL_O}
	@echo -n "creating disk image..."
	@dd if=/dev/zero of=${OS_IMG} bs=512 count=2880 2> /dev/null
	@dd conv=notrunc if=${BOOTLOADER_O} of=${OS_IMG} bs=512 count=1 seek=0 2> /dev/null
	@dd conv=notrunc if=${KERNEL_O} of=${OS_IMG} bs=512 count=1 seek=1 2> /dev/null
	@echo " done!"

debug: ${OS_IMG}
	${QEMU_RUN} -gdb tcp::26000 -S

run: ${OS_IMG}
	${QEMU_RUN}
