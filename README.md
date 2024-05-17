# PPPWN-JIO-Router for fw900 & fw1100
A method of executing PPPwn through hacked JIO Fiber Router.This Repo uses [PPPwn_cpp](https://github.com/xfangfang/PPPwn_cpp)(arm-linux-musleabi(mpcorenovfp)), made by xfangfang.

## Requirements
- JIO Router with root access
- Ethernet cable
- PC to connect to the router via telnet
- A Pendrive or a Portable HDD/SSD that can be plugged into your router

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

Thanks to the JFC-Group for the JIO Router Jailbreak.
Also a thanks to everyone in the PS4 jailbreaking community that gave us the exploits!
