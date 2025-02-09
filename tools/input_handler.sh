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
CLEAN=0

#####################################################################
# Main Script
#####################################################################
while [ $# != 0 ]; do
    case $1 in
        -c | --clean)
            CLEAN=$2
            shift 2
            ;;
        *)
            echo "Invalid input."
            exit 1
            ;;
    esac
done
