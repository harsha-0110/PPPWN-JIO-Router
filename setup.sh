#!/bin/bash

set -e

# Set executable permissions for required files
chmod +x pppwn-armv7l pppwn-mipsel run.sh

CONFIG_FILE="./config.conf"
STAGE1_PREFIX="./stage1/stage1_"
STAGE2_PREFIX="./stage2/stage2_"
EXTENSION=".bin"

echo "PPPWN Setup Script"

# Prompt user for interface without validation and default
read -p "Enter interface: " interface

# Prompt user for firmware version with a default value
read -p "Enter firmware version (options: 900, 960, 1000, 1001, 1050, 1070, 1071 and 1100; default: 1100): " firmware
firmware=${firmware:-1100}

# Prompt user for timeout with a default value
read -p "Enter timeout (default: 5 seconds): " timeout
timeout=${timeout:-5}

# Construct the paths for stage1 and stage2 based on the firmware version
stage1="${STAGE1_PREFIX}${firmware}${EXTENSION}"
stage2="${STAGE2_PREFIX}${firmware}${EXTENSION}"

# Determine the architecture and set the appropriate pppwn executable
case $(uname -m) in
    armv7l)
        pppwn_executable="./pppwn-armv7l"
        ;;
    mips | mipsel)
        pppwn_executable="./pppwn-mipsel"
        ;;
    *)
        echo "Unsupported architecture: $(uname -m)" >&2
        exit 1
        ;;
esac

# Write the configuration to the file atomically
{
    echo "interface=$interface"
    echo "firmware=$firmware"
    echo "stage1=$stage1"
    echo "stage2=$stage2"
    echo "pppwn_executable=$pppwn_executable"
    echo "timeout=$timeout"
} > "$CONFIG_FILE"

echo "Configuration saved to $CONFIG_FILE"
