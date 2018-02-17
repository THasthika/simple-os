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

clean-img: clean
	rm -f ${OS_IMG}

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

#${OS_IMG}: ${BOOT_BIN} ${KERNEL_BIN}
#	@echo -n "creating disk image..."
#	@dd if=/dev/zero of=${OS_IMG} bs=512 count=2880 2> /dev/null
#	@dd conv=notrunc if=${BOOT_BIN} of=${OS_IMG} bs=512 count=1 seek=0 2> /dev/null
#	@dd conv=notrunc if=${KERNEL_BIN} of=${OS_IMG} bs=512 seek=1 2> /dev/null
#	@cat ${BOOT_BIN} ${KERNEL_BIN} > ${OS_IMG}
#	@echo " done!"

debug: copy
	${QEMU_RUN} -gdb tcp::26000 -S

run: copy
	${QEMU_RUN}
