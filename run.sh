#!/bin/bash
cd /home/PPPWN-JIO-Router-main

# Source the configuration file
source ./config.conf

# Create a lock file
touch /tmp/pppwn.lock

echo "PPPWN - Designed for JIO Fiber Routers"

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

# Function to keep the LED in blue fast blink
keep_led_blue_fast_blink() {
    while true; do
        ledctl1 ALL off
        ledctl1 BLUE fastBlink
        sleep 1
    done
}

# Trap to ensure LED is turned off when the script exits or is interrupted
cleanup() {
    rm /tmp/pppwn.lock
    kill $led_blink_pid 2>/dev/null
    ledctl1 ALL off
    ledctl1 BLUE on
}

# Execute the cleanup function when the script exits or is interrupted
trap cleanup EXIT SIGTERM SIGINT

# Start the LED blinking in the background
keep_led_blue_fast_blink &
led_blink_pid=$!

# Execute the pppwn command and store its PID
$pppwn_executable --interface $interface --fw $firmware --stage1 $stage1 --stage2 $stage2 --auto-retry &
pppwn_pid=$!

# Wait for the pppwn executable to finish
wait $pppwn_pid

# Stop the LED blinking loop (cleanup function will handle this)
cleanup
trap - EXIT SIGTERM SIGINT
