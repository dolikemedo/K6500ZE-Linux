#!/bin/bash

# This script is created to help setup the SSDU project on an individual RPI

# Set local variables
YEL='\033[0;33m'
NC='\033[0m' # No Color

show_help () {
    echo "sound should be fixed shortly after next boot"
    echo "max-battery usage after setup.sh finished: "
    echo -e "run ${YEL}max-battery 60${NC} if you are using the laptop from AC a lot.\nrun ${YEL}max-battery 100${NC} if you need more capacity"
    echo "After setting max-battery please reconnect the charger"
}

show_help_kernel () {
    echo -e "Please update your kernel with mainline. Recommended: ${YEL}5.19.17${NC}"
    echo "Follow this: https://ubuntuhandbook.org/index.php/2020/08/mainline-install-latest-kernel-ubuntu-linux-mint/"
    echo "Come back and run setup.sh again"
}

# Check for previliges!
if [ "$EUID" != 0 ]; then 
        echo -e "${YEL}Please run with sudo or as root${NC}"
    exit 1
fi

if uname -r | grep -q "5.15."; then
    show_help_kernel
    exit 1
fi

echo -e "${YEL}\nChecking internet connection...${NC}"

wget -q --spider http://google.com
if [ $? -eq 0 ]; then
    echo "We are online"
else
    echo "We are offline, please enable internet connection"
    exit 1
fi


Install the neccessery part in the system
echo -e "${YEL}\nInstalling sys requirements...\n${NC}"
apt-get update && apt-get install -y alsa-tools


# Setting up sound-fix service
echo -e "${YEL}\nSetting up sound-fix service...${NC}"
cp  "$PWD"/services-scripts-confs/sound-fix.sh /usr/local/bin/sound-fix.sh
cp "$PWD"/services-scripts-confs/sound-fix.service /lib/systemd/system/sound-fix.service
systemctl enable sound-fix


# Setting up sound-fix service
echo -e "${YEL}\nSetting up max-battery service...${NC}"
cp "$PWD"/services-scripts-confs/max-battery.service /lib/systemd/system/max-battery.service
echo 60 | tee /etc/max-battery.value
ln -s "$PWD"/services-scripts-confs/max-battery.sh /usr/local/bin/max-battery
systemctl enable max-battery
systemctl start max-battery


# Setting up headset mic to work
echo -e "${YEL}\nSetting up headset mic to work in alsa-base.conf...${NC}"
cat "$PWD"/services-scripts-confs/alsa-base-addition.txt | tee -a /etc/modprobe.d/alsa-base.conf


show_help
echo -e "\nPlease reboot for all things to take effect and to check if it's working\n"
exit 0