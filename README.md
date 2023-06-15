# K6500ZE Win11 Ubuntu dualboot
Audio fix and tipps for Asus K6500ZE

### [Dualboot:](https://www.linuxtechi.com/dual-boot-ubuntu-22-04-and-windows-11/) 
- win11 first.
  - Use rufus and allow it disable TPM and secure boot stuff when writing the bootable pendrive when it asks for it (usually when you click start). 
  - One C partition is enough if you are using ubuntu mainly
- Create free space by srinking C
- follow boot - root - home - swap - efi scheme (in the tutorial above its home - root, but whatever)
- TURN OFF FAST BOOT in WIN11 !!! [Here's how.](https://www.windowscentral.com/software-apps/windows-11/how-to-enable-or-disable-fast-startup-on-windows-11)
  - win11 doesn't properly shuts down the kernel so it can boot faster. In dualboot this can cause problems.
- It can cause problems to use secure boot for many things. I usually don't even turn it on.
 
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

### Ubuntu settings

#### No sound issue:
(Tested: Ubuntu22.04, Kernel 5.19.17)    
(I describe the main steps of my setup, because it's kind of a magic solution)    
- Install mainline GUI app. [Here's how](https://ubuntuhandbook.org/index.php/2020/08/mainline-install-latest-kernel-ubuntu-linux-mint/)
- Install Kernel 5.19.17, restart
- Go to "Additional drivers" in ubuntu and install nvidia's 530 (proprietary), restart (make sure it's using X instead of wayland, see settings/about)
- Download the repo and run setup.sh to:
  - create a service which runs a few lines to make the ALC294 work on Ubuntu
  - edit the alsa conf to make headset microphone work (and provide a little better bass sound.. maybe)

-----------

### [Oled](https://www.asus.com/support/FAQ/1044809):
- The usual OLED warnings apply.
  - use dark mode in both win11 and ubuntu
  - Do not display static image for long period of time on the built-in display.
  - Close the lid and use external monitors (would be a shame not to use the nice oled display though :-) )
  - Use auto-hide for taskbar
  - Choose a folder with different background and set 5-10mins for change
  - **AVOID SUN LIGHT!!!** Minimize the exposure to sunlight. (even with OLED smartphones/tablets yes)
  - There are smart function in both linux and win11, and manufacturer provided apps (myAsus)
  - etc.
