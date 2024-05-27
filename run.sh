#!/bin/bash

set -e

# Create a lock file and ensure it is removed on exit
lockfile=/tmp/pppwn.lock
touch "$lockfile"

# Clean up function
cleanup() {
    if [ -f "$lockfile" ]; then
        rm -f "$lockfile"
    fi
    [ -n "$led_blink_pid" ] && kill "$led_blink_pid" 2>/dev/null || true
    ledctl1 ALL off
    ledctl1 BLUE on
}

# Trap to ensure cleanup function is called on script exit or interruption
trap cleanup EXIT SIGTERM SIGINT

# Change to the working directory or exit with an error message
cd /home/PPPWN-JIO-Router-main || { echo "Failed to change directory to /home/PPPWN-JIO-Router-main"; exit 1; }

# Source the configuration file if it exists
config_file=./config.conf
if [ ! -f "$config_file" ]; then
    echo "Configuration file not found!" >&2
    exit 1
fi
source "$config_file"

echo "PPPWN - Designed for JIO Fiber Routers"

# Verify the presence of required commands
if ! command -v ledctl1 &>/dev/null; then
    echo "ledctl1 command not found!" >&2
    exit 1
fi

if [ ! -x "$pppwn_executable" ]; then
    echo "PPPWN executable not found or not executable for architecture $(uname -m)!" >&2
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

# Start the LED blinking in the background
keep_led_blue_fast_blink &
led_blink_pid=$!

# Execute the pppwn command
"$pppwn_executable" --interface "$interface" --fw "$firmware" --stage1 "$stage1" --stage2 "$stage2" --timeout "$timeout" --auto-retry

# Wait for the pppwn executable to finish
wait "$pppwn_pid"
