# PPPWN-JIO-Router for fw900 & fw1100
A method of executing PPPwn through hacked JIO Fiber Router.This Repo uses [PPPwn_cpp](https://github.com/xfangfang/PPPwn_cpp)(arm-linux-musleabi(mpcorenovfp)), made by xfangfang.

## Requirements
- JIO Router with root access, preferably routers with firmware version less than or equal 2.3(as 2.3 is the highest tested firmware)
- Ethernet cable
- PC to connect to the router via telnet
- A Pendrive or a Portable HDD/SSD that can be plugged into your router

## Note
- May not work with new firmwares as Jio made the file-sytem readonly. This is confirmed on latest firmware but not sure on which firmware this change was implemented. Also, firmware downgrade maybe possible as I was able to downgrade from 2.3 to 1.5.
- Not receommended on main router, because the router will try to auto update the fw. 
- May not work on other models as some router model use mips architecture.(Can be supported in future)
- Boot time of this router is around 50sec, so you will have to wait for it + the exploit runtime.
- The router will start blinking in blue color while the exploit is running and solid blue color after executed successfully.

## Tested Model
- JCOW404 (armv7l)

## Steps
1. Get root access to your JIO Fiber Router by following instructions in this repo [JFC-Group/JF-Customisation](https://github.com/JFC-Group/JF-Customisation).

2. Download this repo as zip and extract it, open `run.sh` and modify firmware, stage1, stage2 based on your ps4 firmware version.

3. Copy `PPPWN-JIO-Router-main` to root of the usb drive.

4. Plug the usb drive in router, now connect ps4 and the router via lan cable. Plug the lan cable in the last lan port(Left-Right). And setup the internet connection in ps4 using lan and PPPoE.

5. Now in pc, connect to the router via wifi and open cmd and run `telnet 192.168.29.1 23`, enter `root as username` and `password as Password`.

6. Run the following commands in the telnet:
    ```bash
    #Replace <usblable> with the name of your usb drive
    cp -r /mnt/vfs/admin/<usblable>/PPPWN-JIO-Router-main /home
    cd /home/PPPWN-JIO-Router-main
    chmod +x ./run.sh
    ./run.sh
    ```
7. To make it auto run during the router boot up, execute the following commands to open `rcS` file
   ```bash
   cd /etc/init.d
   vi rcS
   ```
   and append the following lines in the end of the file.
   ```bash
   cd /home/PPPWN-JIO-Router-main
   ./run.sh
   ```
   

Thanks to the JFC-Group for the JIO Router Jailbreak.
Also a thanks to everyone in the PS4 jailbreaking community that gave us the exploits!
