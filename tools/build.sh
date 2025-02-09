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

# Orginal source dir
ORG_KERNEL=$WS_DIR/kernel

#####################################################################
# Customize
#####################################################################
# Install customize source
cp $KERNEL_SRC/config/bbb_defconfig $ORG_KERNEL/arch/arm/configs

#####################################################################
# Main Build
#####################################################################
# Run Makefile
echo "Starting build process..."
make clean  # Clean previous builds
make all    # Build the project

# Check if the build was successful
if [ $? -eq 0 ]; then
    echo "Build completed successfully!"
else
    echo "Build failed!" >&2
    exit 1
fi
