echo "PPPWN - Designed for JIO Fiber Routers"
interface=eth3.1
firmware=900
stage1=/home/PPPwn-JIO-Router-main/stage1_900.bin
stage2=/home/PPPwn-JIO-Router-main/stage2_900.bin
cd /home/PPPwn-JIO-Router-main
chmod +x ./pppwn

./pppwn --interface $interface --fw $firmware --stage1 $stage1 --stage2 $stage2 --auto-retry
