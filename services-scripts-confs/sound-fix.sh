#!/bin/bash

#wait some time after boot for the commands to take effect
#would be more elegant to wait for some sound service?

uptime=$(awk '{
    if($1<120)
        print "too short"
    else
        print "enough"
}' /proc/uptime)

if [[ $uptime != "enough" ]]; then
    sleep 30
fi

hda-verb /dev/snd/hwC0D0 0x20 0x500 0xf
hda-verb /dev/snd/hwC0D0 0x20 0x400 0x7774

exit 0