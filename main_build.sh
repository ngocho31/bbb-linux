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
TOOLS_DIR=$WS_DIR/tools

# Orginal source dir
ORG_BOOTLOADER=$WS_DIR/bootloader
ORG_KERNEL=$WS_DIR/kernel
ORG_BUSYBOX=$WS_DIR/busybox

#####################################################################
# Customize
#####################################################################
# Install kernel source
cp $KERNEL_SRC/config/bbb_defconfig $ORG_KERNEL/arch/arm/configs
# Install busybox source
cp $BUSYBOX_SRC/config/bbb_defconfig $ORG_BUSYBOX/configs

#####################################################################
# Input
#####################################################################
source $TOOLS_DIR/input_handler.sh

#####################################################################
# Cleaning
#####################################################################
source $TOOLS_DIR/clean.sh

#####################################################################
# Build
#####################################################################
source $TOOLS_DIR/build.sh
