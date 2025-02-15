# The U-Boot source directory
UBOOT_DIR := $(CURDIR)/bootloader
# The Kernel source directory
KERNEL_DIR := $(CURDIR)/kernel
# The Busybox source directory
BUSYBOX_DIR := $(CURDIR)/busybox

# The output directory for compiled binaries
OUTPUT_DIR := $(CURDIR)/output

# The cross-compiler directory
export PATH := $(PATH):${HOME}/x-tools/arm-bbb-linux-musleabihf/bin/
# The target architecture and platform
export ARCH := arm

# Cross-compiler settings
export CROSS_COMPILE := ${HOME}/x-tools/arm-bbb-linux-musleabihf/bin/arm-linux-
CC := $(CROSS_COMPILE)gcc
AS := $(CROSS_COMPILE)as
LD := $(CROSS_COMPILE)ld

# U-Boot configuration for the target platform
UBOOT_CONFIG := am335x_evm_defconfig
UBOOT_DTB := am335x-boneblack

UBOOT_MAKE_FLAGS_EXTRA := DEVICE_TREE=${UBOOT_DTB}

# Kernel configuration for the target platform
KERNEL_CONFIG := bbb_defconfig
KERNEL_DTB_PATH := ${KERNEL_DIR}/arch/arm/boot/dts/ti/omap/am335x-boneblack.dtb
KERNEL_IMAGE_PATH := ${KERNEL_DIR}/arch/arm/boot/zImage

KERNEL_MAKE_FLAGS_EXTRA := 

# Busybox configuration for the target platform
BUSYBOX_CONFIG := bbb_defconfig

# Default target
all: bootloader kernel rootfs
bootloader: bootloader_genconfig bootloader_build
kernel: kernel_genconfig kernel_build
rootfs: busybox_genconfig rootfs_build

# Clean build directory
clean:
	$(MAKE) -C $(UBOOT_DIR) distclean

# Generate U-boot configuration
bootloader_genconfig:
	cd $(UBOOT_DIR) ; \
	make $(UBOOT_CONFIG) ;

# Build U-Boot with specific configuration
bootloader_build:
	mkdir -p $(OUTPUT_DIR)/u-boot; \
	cd $(UBOOT_DIR); \
	make -j 8 $(BOOTLOADER_MAKE_FLAGS_EXTRA) ; \
	cp $(UBOOT_DIR)/u-boot.dtb $(UBOOT_DIR)/MLO $(UBOOT_DIR)/u-boot.img $(OUTPUT_DIR)/u-boot ;

# Generate Kernel configuration
kernel_genconfig:
	cd $(KERNEL_DIR) ; \
	make $(KERNEL_CONFIG) ;

# Build Kernel with specific configuration
kernel_build:
	mkdir -p $(OUTPUT_DIR)/kernel; \
	cd $(KERNEL_DIR); \
	make -j 8 $(KERNEL_MAKE_FLAGS_EXTRA) ; \
	cp ${KERNEL_DTB_PATH} $(KERNEL_IMAGE_PATH) $(OUTPUT_DIR)/kernel ;

# Generate Busybox configuration
busybox_genconfig:
	cd $(BUSYBOX_DIR) ; \
	make $(BUSYBOX_CONFIG) ;

# Generate rootfs from busybox
rootfs_build:
	cd $(BUSYBOX_DIR) ; \
	make -j 8 install ;

.PHONY: all clean bootloader kernel rootfs
