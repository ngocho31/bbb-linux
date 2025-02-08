# The U-Boot source directory
UBOOT_DIR := $(CURDIR)/bootloader
# The Kernel source directory
UBOOT_DIR := $(CURDIR)/kernel

# The output directory for compiled binaries
OUTPUT_DIR := $(CURDIR)/output

# The cross-compiler directory
export PATH := $(PATH):${HOME}/x-tools/arm-training-linux-musleabihf/bin/
# The target architecture and platform
export ARCH=arm

# Cross-compiler settings
export CROSS_COMPILE := ${HOME}/x-tools/arm-training-linux-musleabihf/bin/arm-linux-
CC := $(CROSS_COMPILE)gcc
AS := $(CROSS_COMPILE)as
LD := $(CROSS_COMPILE)ld

# U-Boot configuration for the target platform
UBOOT_CONFIG := am335x_evm_defconfig
UBOOT_DTB := am335x-boneblack

UBOOT_MAKE_FLAGS_EXTRA := DEVICE_TREE=${UBOOT_DTB}

# List of U-Boot targets to build
BOOTLOADER_TARGETS := bootloader_genconfig bootloader

# Default target
all: ${BOOTLOADER_TARGETS}

# Clean build directory
clean:
	$(MAKE) -C $(UBOOT_DIR) distclean

# Generate U-boot configuration
bootloader_genconfig:
	cd $(UBOOT_DIR) ; \
	make -j 4 $(UBOOT_CONFIG) ;

# Build U-Boot with specific configuration
bootloader:
	mkdir -p $(OUTPUT_DIR)/u-boot; \
	cd $(UBOOT_DIR); \
	make -j 4 $(BOOTLOADER_MAKE_FLAGS_EXTRA) ; \
	cp $(UBOOT_DIR)/u-boot.dtb $(UBOOT_DIR)/MLO $(UBOOT_DIR)/u-boot.img $(OUTPUT_DIR)/u-boot ;

.PHONY: all clean bootloader_genconfig bootloader
