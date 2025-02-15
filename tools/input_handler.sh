#!/bin/bash

#####################################################################
# Script Name: Input Handler
# Description: This script takes a user-provided input string as a parameter.
# Usage: ./input_handler.sh <input_string>
# Author: Ngoc Ho
# Date: 2025
# Version: 1.0
#####################################################################

#####################################################################
# Variables
#####################################################################
BUILD_OPT=0
CLEAN_OPT=0

#####################################################################
# Main Script
#####################################################################
while [ $# != 0 ]; do
    case $1 in
        -b | --build)
            BUILD_OPT=$2
            shift 2
            ;;
        -c | --clean)
            CLEAN_OPT=$2
            shift 2
            ;;
        *)
            echo "Invalid input."
            exit 1
            ;;
    esac
done
