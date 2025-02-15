# The U-Boot source directory
UBOOT_DIR := $(CURDIR)/bootloader
# The Kernel source directory
KERNEL_DIR := $(CURDIR)/kernel
# The Busybox source directory
BUSYBOX_DIR := $(CURDIR)/busybox
# The App source directory
APP_DIR := $(CURDIR)/platform/app

# The output directory for compiled binaries
OUTPUT_DIR := $(CURDIR)/output
ROOTFS_DIR := $(CURDIR)/platform/nfsroot

# The cross-compiler directory
export PATH := $(PATH):${HOME}/x-tools/arm-bbb-linux-musleabihf/bin/
# The target architecture and platform
export ARCH := arm

# Cross-compiler settings
export CROSS_COMPILE := ${HOME}/x-tools/arm-bbb-linux-musleabihf/bin/arm-linux-
export CC := $(CROSS_COMPILE)gcc
export AS := $(CROSS_COMPILE)as
export LD := $(CROSS_COMPILE)ld

# U-Boot configuration for the target platform
UBOOT_CONFIG := am335x_evm_defconfig
UBOOT_DTB := am335x-boneblack

# Kernel configuration for the target platform
KERNEL_CONFIG := bbb_defconfig
KERNEL_DTB_PATH := ${KERNEL_DIR}/build/arch/arm/boot/dts/ti/omap/am335x-boneblack.dtb
KERNEL_IMAGE_PATH := ${KERNEL_DIR}/build/arch/arm/boot/zImage

# Busybox configuration for the target platform
BUSYBOX_CONFIG := bbb_defconfig

# Default target
all: bootloader kernel rootfs

# Clean build directory
clean:
	$(MAKE) -C $(UBOOT_DIR) distclean

# Generate U-boot configuration
bootloader_genconfig:
	cd $(UBOOT_DIR) ; \
	make $(UBOOT_CONFIG) O=build ;

# Build U-Boot with specific configuration
bootloader:
	mkdir -p $(OUTPUT_DIR)/u-boot ; \
	cd $(UBOOT_DIR) ; \
	[ ! -f build/.config ] && make $(UBOOT_CONFIG) O=build ; \
	make -j 8 DEVICE_TREE=${UBOOT_DTB} O=build || exit ; \
	cp $(UBOOT_DIR)/build/u-boot.dtb $(UBOOT_DIR)/build/MLO $(UBOOT_DIR)/build/u-boot.img $(OUTPUT_DIR)/u-boot ;

# Generate Kernel configuration
kernel_genconfig:
	cd $(KERNEL_DIR) ; \
	make $(KERNEL_CONFIG) O=build ;

# Build Kernel with specific configuration
kernel:
	mkdir -p $(OUTPUT_DIR)/kernel; \
	cd $(KERNEL_DIR); \
	[ ! -f build/.config ] && make $(KERNEL_CONFIG) O=build ; \
	make -j 8 O=build || exit ; \
	cp ${KERNEL_DTB_PATH} $(KERNEL_IMAGE_PATH) $(OUTPUT_DIR)/kernel ;

# Generate Busybox configuration
busybox_genconfig:
	cd $(BUSYBOX_DIR) ; \
	make $(BUSYBOX_CONFIG) ;

# Generate rootfs from busybox
rootfs:
	mkdir -p ${ROOTFS_DIR} ; \
	cd $(BUSYBOX_DIR) ; \
	[ ! -f .config ] && make $(BUSYBOX_CONFIG) ; \
	make -j 8 install || exit ;

# Generate app
app:
	mkdir -p $(OUTPUT_DIR)/app; \
	mkdir -p ${ROOTFS_DIR}/oemapp; \
	cd $(APP_DIR) ; \
	make -j 8 all || exit ; \
	cp -r $(OUTPUT_DIR)/app/* ${ROOTFS_DIR}/oemapp

.PHONY: all clean bootloader kernel rootfs app
