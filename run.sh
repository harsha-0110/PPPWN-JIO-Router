#!/bin/bash

echo "PPPWN - Designed for JIO Fiber Routers"
interface=eth3.1
firmware=1100
stage1=/home/PPPWN-JIO-Router-main/stage1_1100.bin
stage2=/home/PPPWN-JIO-Router-main/stage2_1100.bin
cd /home/PPPWN-JIO-Router-main

# Determine the architecture and set the appropriate pppwn executable
arch=$(uname -m)
if [ "$arch" = "armv7l" ]; then
    pppwn_executable="./pppwn-armv7l"
elif [ "$arch" = "mips" ]; then
    pppwn_executable="./pppwn-mipsel"
else
    echo "Unsupported architecture: $arch"
    exit 1
fi

chmod +x $pppwn_executable

# Function to keep the LED in blue fast blink
keep_led_blue_fast_blink() {
    while true; do
        ledctl1 ALL off
        ledctl1 BLUE fastBlink
        sleep 1
    done
}

# Trap to ensure LED is turned off when the script exits
cleanup() {
    kill $led_blink_pid
    ledctl1 ALL off
    ledctl1 BLUE on
}

# Execute the cleanup function when the script exits or is interrupted
trap cleanup EXIT

# Start the LED blinking in the background
keep_led_blue_fast_blink &
led_blink_pid=$!

# Execute the pppwn command
$pppwn_executable --interface $interface --fw $firmware --stage1 $stage1 --stage2 $stage2 --auto-retry

# Stop the LED blinking loop (cleanup function will handle this)
cleanup
trap - EXIT