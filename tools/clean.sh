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

clean_busybox() {
    echo "Cleaning up kernel source code directory..."

    cd $ORG_BUSYBOX
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
    clean_busybox ;
    clean_platform ;
}

#####################################################################
# Main Script
#####################################################################
if [ $CLEAN_OPT == 0 ]; then
    echo "No cleaning workspace..."
elif [ $CLEAN_OPT == "all" ]; then
    clean ;
elif [ $CLEAN_OPT == "bootloader" ]; then
    clean_bootloader ;
elif [ $CLEAN_OPT == "kernel" ]; then
    clean_kernel ;
elif [ $CLEAN_OPT == "busybox" ]; then
    clean_busybox ;
elif [ $CLEAN_OPT == "platform" ]; then
    clean_platform ;
else
    echo "Invalid clean option."
    exit 1
fi
