# PPPWN-JIO-Router for fw900 & fw1100

This guide explains how to execute PPPwn using a hacked JIO Fiber Router. It leverages [PPPwn_cpp](https://github.com/xfangfang/PPPwn_cpp), created by xfangfang.

## Requirements
- **JIO Router**: Must have root access. Firmware version should be ≤ 2.3 (2.3 is the highest tested firmware).
- **Ethernet Cable**: For connecting your PS4 to the router.
- **PC**: To connect to the router via telnet.
- **USB Drive or Portable HDD/SSD**: To be plugged into the router.

## Notes
- **Compatibility**: May not work with newer firmware versions as Jio has made the file system read-only. This change is confirmed on the latest firmware, but the exact version when this was implemented is unknown.
- **Firmware Downgrade**: Downgrade maybe possible as downgrade from 2.3 to 1.5 is possible.
- **Main Router Warning**: Not recommended for your main router as it may auto-update the firmware.
- **Other Models**: Compatibility with other models is not confirmed.
- **Boot Time**: Approximately 50 seconds.
- **Performance**: Runs slower on MIPS routers compared to ARMv7l routers.

## Tested Models
- **JCOW404** (armv7l)
- **JCOW414** (mips)

## Setup Steps

### 1. Obtain Root Access
Follow the instructions in the [JFC-Group/JF-Customisation](https://github.com/JFC-Group/JF-Customisation) repository to gain root access to your JIO Fiber Router.

### 2. Download and Prepare Files
1. Download `PPPWN-JIO-Router-main.tar.gz` from latest release.

### 3. Transfer Files to USB
1. Copy the `PPPWN-JIO-Router-main.tar.gz` folder to the root directory of your USB drive.

### 4. Connect PS4 to Router
1. Plug the USB drive into the router.
2. Connect your PS4 to the router using an Ethernet cable. Plug the cable into the last LAN port (left-most port).
3. Set up the internet connection on your PS4 using LAN and PPPoE.

### 5. Connect PC to Router
1. Connect your PC to the router via Wi-Fi.
2. Open Command Prompt on your PC and run:
    ```bash
    telnet 192.168.29.1 23
    ```
3. Log in with `root` as the username and `Password` as the password.

### 6. Execute Commands via Telnet
Run the following commands in the telnet session, replacing `<usblable>` with the name of your USB drive:
```bash
cp /mnt/vfs/admin/<usblable>/PPPWN-JIO-Router-main.tar.gz /home
cd /home
tar -xzvf PPPWN-JIO-Router-main.tar.gz
cd PPPWN-JIO-Router-main
chmod +x setup.sh && ./setup.sh
```

### 7. Setup
1. Set interface to eth3.1.
2. Set firmware based on your ps4 fw(900, 1000, 1001, 1100).

### 8. WPS button setup
1. Open `wpsSessionUpdate.lua` file using the following command
    ```bash
    cd /pfrm2.0/bin
    vi wpsSessionUpdate.lua
    ```
    find for the following lines
    ```lua
    os.execute("/bin/touch /tmp/wpsON")
    os.execute("/bin/ledctl1 ALL off;/bin/ledctl1 GREEN slowBlink")
    ```
    and replace it with
    ```lua
    if (util.fileExists("/tmp/pppwn.lock")) then
        os.execute("pkill -f run.sh")
        os.execute("rm /tmp/pppwn.lock")
    else
        os.execute("/home/PPPWN-JIO-Router-main/run.sh &")
    end
    ```

### 9. Auto-Run Script on Boot (Optional)
To make the script run automatically during router boot-up:
1. Open the `rcS` file:
    ```bash
    cd /etc/init.d
    vi rcS
    ```
2. Append the following lines to the end of the file:
    ```bash
    cd /home/PPPWN-JIO-Router-main
    ./run.sh
    ```
## Tutorial 
[<img src="https://i.ytimg.com/vi/50wWXpNX-s0/maxresdefault.jpg" width="100%">](https://www.youtube.com/watch?v=50wWXpNX-s0) 

## Features
- Supports PS4 Firmware 9.00, 10.00, 10.01 & 11.00
- Stage 2 payload is GoldHen Loader by [Sistro](https://github.com/SiSTR0)
- Auto detection of router architecture
- LED indication: Blinking blue during exploit execution; solid blue after successful execution.
- WPS button can be used to start the exploit and terminate the exploit(this will be helpful if the exploit gets stuck).

## Acknowledgements
Thanks to the JFC-Group for the JIO Router Jailbreak and to everyone in the PS4 jailbreaking community who contributed to the exploits!
