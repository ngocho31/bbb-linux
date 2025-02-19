#!/bin/bash

# Exit on any error
set -e

#####################################################################
# Variables
#####################################################################
# Working source dir
WS_DIR=$(pwd)
SRC_DIR=$WS_DIR/platform
KERNEL_SRC=$SRC_DIR/kernel
BUSYBOX_SRC=$SRC_DIR/busybox

# Orginal source dir
ORG_BOOTLOADER=$WS_DIR/bootloader
ORG_KERNEL=$WS_DIR/kernel
ORG_BUSYBOX=$WS_DIR/busybox

#####################################################################
# Customize
#####################################################################
# Install kernel source
cp -v $KERNEL_SRC/config/bbb_defconfig $ORG_KERNEL/arch/arm/configs
# Install busybox source
cp -v $BUSYBOX_SRC/config/bbb_defconfig $ORG_BUSYBOX/configs
