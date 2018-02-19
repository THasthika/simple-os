ROOT_DIR = ${PWD}
SRC_DIR = ${ROOT_DIR}/src
BUILD_DIR = ${ROOT_DIR}/build
MOUNT_DIR = ${BUILD_DIR}/disk

GRUB_CFG = $(BUILD_DIR)/grub.cfg
OS_IMG = ${BUILD_DIR}/os.img

BIN=${BUILD_DIR}/kernel.bin

QEMU_RUN=qemu-system-i386 -machine q35 -drive format=raw,file=${OS_IMG},if=ide

export

.PHONY: all clean ${BIN} mount unmount copy debug run clean-img

all: ${BIN}

kernel: ${SRC_DIR}

clean:
	@make -C ${SRC_DIR} clean

${BIN}:
	@make -C ${SRC_DIR}

mount: ${OS_IMG}
	./tools/mount.sh ${OS_IMG} ${MOUNT_DIR}

unmount:
	./tools/umount.sh ${MOUNT_DIR}

${OS_IMG}:
	./tools/mkdisk.sh ${OS_IMG}

copy: ${BIN} mount
	cp ${GRUB_CFG} ${MOUNT_DIR}/boot/grub/
	cp ${BIN} ${MOUNT_DIR}/boot/
	@make unmount

debug: copy
	${QEMU_RUN} -gdb tcp::26000 -S

run:  copy
	${QEMU_RUN}
