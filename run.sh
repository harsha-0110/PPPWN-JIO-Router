echo "PPPWN - Designed for JIO Fiber Routers"
interface=eth3.1
firmware=1100
stage1=/home/PPPWN-JIO-Router-main/stage1_1100.bin
stage2=/home/PPPWN-JIO-Router-main/stage2_1100.bin
cd /home/PPPWN-JIO-Router-main
chmod +x ./pppwn

./pppwn --interface $interface --fw $firmware --stage1 $stage1 --stage2 $stage2 --auto-retry
