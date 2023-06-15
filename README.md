# K6500ZE Win11 Ubuntu dualboot
Audio fix and tipps for Asus K6500ZE

dualboot: 
- win11 first.
- Ubuntu 22.04.3

-----------

### Win11 settings:
- For better touchpad experience, set touchpad speed higher
- For better touchpad scrolling change Friction and Inertia in Computer\HKEY_CURRENT_USER\Software\Microsoft\Wisp\Touch\ to your liking. (Friction decimal 10 seems ok)
[superuser.com](https://superuser.com/questions/1209746/increase-precision-touchpad-two-finger-scrolling-speed)

#### Battery:
- Download myAsus app, go to customization and set "Battery Health Charging" according to your use.
  - Alway on desk pluged in? Max lifespan mode
  - Go on the road for a few days? Full capacity mode.

-----------

### Ubuntu

#### No sound issue:
(Tested: Ubuntu22.04, Kernel 5.19.17)
- Download the repo and run setup.sh to:
  - create a service which runs a few lines to make the ALC294 work on Ubuntu
  - edit the alsa conf to make headset microphone work (and provide a little better bass sound.. maybe)

-----------

### Oled:
- The usual OLED warnings apply.
  - Do not display static image for long period of time on the built-in display.
  - Close the lid and use external monitors (would be a shame not to use the nice oled display though :-) )
  - Use auto-hide for taskbar
  - Choose a folder with different background and set 5-10mins for change
  - AVOID SUN LIGHT!!! Minimize the exposure to sunlight. (even with OLED smartphones/tablets yes)
  - There are smart function in both linux and win11, and manufacturer provided apps (myAsus)
  - etc.
