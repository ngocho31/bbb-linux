#!/bin/bash

#####################################################################
# Script Name: Cleaning workspace
# Description: This script removes build artifacts, temporary files, and generated output.
# Usage: ./clean.sh
# Author: Ngoc Ho
# Date: 2025
# Version: 1.0
#####################################################################

#####################################################################
# Static functions
#####################################################################
build_bootloader() {
    echo "Compiling bootloader..."

    make bootloader
}

build_kernel() {
    echo "Compiling kernel..."

    make kernel
}

build_rootfs() {
    echo "Compiling rootfs..."

    make rootfs
}

build() {
    echo "Compiling all..."
    make all
}

#####################################################################
# Main Script
#####################################################################
if [ $BUILD_OPT == "all" ]; then
    build ;
elif [ $BUILD_OPT == "bootloader" ]; then
    build_bootloader ;
elif [ $BUILD_OPT == "kernel" ]; then
    build_kernel ;
elif [ $BUILD_OPT == "rootfs" ]; then
    build_rootfs ;
else
    echo "Invalid build option."
    exit 1
fi

# Check if the build was successful
if [ $? -eq 0 ]; then
    echo "Build completed successfully!"
else
    echo "Build failed!" >&2
    exit 1
fi
