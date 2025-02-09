#!/bin/bash

#####################################################################
# Script Name: Cleaning workspace
# Description: This script removes build artifacts, temporary files, and generated output.
# Usage: ./clean.sh
# Author: Ngoc Ho
# Date: 2025
# Version: 1.0
#####################################################################

clean_bootloader() {
    echo "Cleaning up bootloader source code directory..."

    cd $ORG_BOOTLOADER
    make distclean
}

clean_kernel() {
    echo "Cleaning up kernel source code directory..."

    cd $ORG_KERNEL
    make distclean
}

clean_platform() {
    echo "Cleaning up output of platform..."

    rm -rf $WS_DIR/output
}

clean() {
    echo "Cleaning up all source code directory..."

    clean_bootloader ;
    clean_kernel ;
    clean_platform ;
}

if [ $CLEAN == 0 ]; then
    echo "No cleaning workspace..."
elif [ $CLEAN == 1 ]; then
    clean ;
elif [ $CLEAN == 2 ]; then
    clean_bootloader ;
elif [ $CLEAN == 3 ]; then
    clean_kernel ;
elif [ $CLEAN == 4 ]; then
    clean_platform ;
else
    echo "Invalid cleaning input value."
    exit 1
fi
