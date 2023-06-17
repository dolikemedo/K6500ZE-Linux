#!/bin/bash

# Set local variables
YEL='\033[0;33m'
NC='\033[0m' # No Color

show_help () {
    echo "Usage:"
    echo -e "run ${YEL}max-battery 60${NC} if you are using the laptop from AC a lot.\nrun ${YEL}max-battery 100${NC} if you need more capacity"
    echo "Please provide a number between 60 and 100"s
    echo "After setting max-battery please reconnect the charger"
}

# Check for previliges!
if [ "$EUID" != 0 ]; then 
    echo -e "${YEL}Please run with sudo or as root${NC}"
    exit 1
fi

re='^[0-9]+$'
if ! [[ $1 =~ $re ]] ; then
   echo "error: Not a number"
   show_help
   exit 1
fi

if [ $1 -le 100 ] && [ $1 -ge 60 ]; then
    echo $1 | tee /etc/max-battery.value
    systemctl restart max-battery
else
    show_help
    exit 1
fi

exit 0