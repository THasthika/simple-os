ROOT_DIR = ${PWD}
SRC_DIR = ${ROOT_DIR}/src
BOOT_DIR = ${SRC_DIR}/boot
KERNEL_DIR = ${SRC_DIR}/kernel
BUILD_DIR = ${ROOT_DIR}/build

BOOT_BIN=${BUILD_DIR}/boot.bin
KERNEL_BIN=${BUILD_DIR}/kernel.bin

HDD_IMG=${BUILD_DIR}/hdd.img

QEMU_RUN=qemu-system-i386 -drive format=raw,file=${HDD_IMG},if=ide

export

# PARTITION INFORMATION
PART_START=2048
PART_END=524287
PART_SECTOR=512
LOOP_DEVICE=/dev/loop13
MOUNT_DIR=${ROOT_DIR}/mount/

.PHONY: all clean run ${HDD_IMG}

all: ${HDD_IMG}

${HDD_IMG}: boot
	@./tools/mkdisk.sh ${HDD_IMG} ${BOOT_BIN} ${BOOT_BIN}

mount: ${HDD_IMG}
	@./tools/mountdisk.sh ${HDD_IMG} ${MOUNT_DIR} ${LOOP_DEVICE} ${PART_START} ${PART_END} ${PART_SECTOR}

unmount:
	@./tools/unmountdisk.sh ${MOUNT_DIR} ${LOOP_DEVICE}

run: ${HDD_IMG}
	${QEMU_RUN}

debug: ${HDD_IMG}
	${QEMU_RUN} -gdb tcp::26000 -S

boot: ${SRC_DIR}
	@make -C ${SRC_DIR} boot

clean:
	@make -C ${SRC_DIR} clean