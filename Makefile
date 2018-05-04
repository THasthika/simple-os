# ROOT_DIR = ${PWD}
# SRC_DIR = ${ROOT_DIR}/src
# BUILD_DIR = ${ROOT_DIR}/build
# MOUNT_DIR = ${BUILD_DIR}/disk

# GRUB_CFG = $(BUILD_DIR)/grub.cfg
# OS_IMG = ${BUILD_DIR}/os.img
# MAP_FILE = ${BUILD_DIR}/kernel.map

# BIN=${BUILD_DIR}/kernel.bin

# QEMU_RUN=qemu-system-i386 -machine q35 -drive format=raw,file=${OS_IMG},if=ide

# export

# .PHONY: all clean ${BIN} mount unmount copy debug run clean-img

# all: ${BIN}

# kernel: ${SRC_DIR}

# clean:
# 	rm -f ${MAP_FILE} ${BIN}
# 	@make -C ${SRC_DIR} clean

# ${BIN}:
# 	@make -C ${SRC_DIR}

# mount: ${OS_IMG}
# 	./tools/mount.sh ${OS_IMG} ${MOUNT_DIR}

# unmount:
# 	./tools/umount.sh ${MOUNT_DIR}

# ${OS_IMG}:
# 	./tools/mkdisk.sh ${OS_IMG}

# copy: ${BIN} mount
# 	cp ${GRUB_CFG} ${MOUNT_DIR}/boot/grub/
# 	cp ${BIN} ${MOUNT_DIR}/boot/
# 	@make unmount

# debug: copy
# 	${QEMU_RUN} -gdb tcp::26000 -S

# run:  copy
# 	${QEMU_RUN}

ROOT_DIR = ${PWD}
SRC_DIR = ${ROOT_DIR}/src
BOOT_DIR = ${SRC_DIR}/boot
KERNEL_DIR = ${SRC_DIR}/kernel
BUILD_DIR = ${ROOT_DIR}/build

BOOT_BIN=${BUILD_DIR}/boot.bin
KERNEL_BIN=${BUILD_DIR}/kernel.bin

OS_IMG=${BUILD_DIR}/os.img

QEMU_RUN=qemu-system-i386 -drive format=raw,file=${OS_IMG},if=ide

export

.PHONY: all clean run ${OS_IMG}

all: ${OS_IMG}

${OS_IMG}: boot
	@./tools/mkdisk.sh ${OS_IMG} ${BOOT_BIN} ${BOOT_BIN}

run: ${OS_IMG}
	@${QEMU_RUN}

boot: ${SRC_DIR}
	@make -C ${SRC_DIR} boot

clean:
	@make -C ${SRC_DIR} clean
	rm -f ${OS_IMG}