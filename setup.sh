#!/bin/bash

chmod +x pppwn-armv7l
chmod +x pppwn-mipsel
chmod +x run.sh

CONFIG_FILE="./config.conf"
DEFAULT_STAGE1_PREFIX="/home/PPPWN-JIO-Router-main/stage1_"
DEFAULT_STAGE2_PREFIX="/home/PPPWN-JIO-Router-main/stage2_"
DEFAULT_EXTENSION=".bin"

echo "PPPWN Setup Script"

# Prompt user for interface with a default value
read -p "Enter interface (default: eth3.1): " interface
interface=${interface:-eth3.1}

# Prompt user for firmware version with a default value
read -p "Enter firmware version (default: 1100): " firmware
firmware=${firmware:-1100}

# Construct the paths for stage1 and stage2 based on the firmware version
stage1="${DEFAULT_STAGE1_PREFIX}${firmware}${DEFAULT_EXTENSION}"
stage2="${DEFAULT_STAGE2_PREFIX}${firmware}${DEFAULT_EXTENSION}"

# Write the configuration to the file
echo "interface=$interface" > $CONFIG_FILE
echo "firmware=$firmware" >> $CONFIG_FILE
echo "stage1=$stage1" >> $CONFIG_FILE
echo "stage2=$stage2" >> $CONFIG_FILE

echo "Configuration saved to $CONFIG_FILE"
