# K6500ZE Win11 Ubuntu dualboot
Audio fix and tipps for Asus K6500ZE

# Specs
Hardware | Device
-------- | ------
CPU | Intel i7-12700H
GPU | Nvidia RTX 3050 Ti Mobile 65W
RAM | 16 GB LPDDR5
SSD | NVME TEAM TM8FPD001T 1 TB
Screen | 15.6' 1920x1080 OLED

#### [Geekbench with default CPU throttle behaviour](https://browser.geekbench.com/v6/cpu/1541041)
#### [Geekbench with "throttled" program's solution](https://browser.geekbench.com/v6/cpu/1611323)

-----------

### [Dualboot:](https://www.linuxtechi.com/dual-boot-ubuntu-22-04-and-windows-11/) 
- win11 first.
  - Use rufus and allow it disable TPM and secure boot stuff when writing the bootable pendrive when it asks for it (usually when you click start). 
  - One C partition is enough if you are using ubuntu mainly
- Create free space by srinking C
- follow boot - root - home - swap - efi scheme (in the tutorial above its home - root, but whatever, you can choose "install beside win11", and you don't even have create a separate home if don't want to install additional linux OSs, I just follow this for historical reasons. If you don't want to think about it follow this or "install along side win11")
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
  - Disconnect the charging cable when you turn off and leave the laptop. (obviously, if you need capacity, leave it in.)
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
    - the service runs these lines after 10seconds of booting:
      ```
      #!/bin/bash
      sudo hda-verb /dev/snd/hwC0D0 0x20 0x500 0xf
      sudo hda-verb /dev/snd/hwC0D0 0x20 0x400 0x7774
      ```
  - edit the alsa conf to make headset microphone work (and provide a little better bass sound.. maybe)
    - in /etc/modprobe.d/alsa-base.conf
      ```
      #try for no headset mic:
      options snd-hda-intel position fix=1
      options snd-hda-intel model=aspire-headset-mic
      ```

  - throttling issue:
    - The CPU is throttled and will only usee 29-30W of power by default. 
    - Use throttled to solve the issue:
      1. install stress and s-tui [https://github.com/amanusk/s-tui](https://github.com/amanusk/s-tui)
      2. See if you are throttled (only 2400MHz freq and 30W power)
      3. install throttled [https://github.com/erpalma/throttled](https://github.com/erpalma/throttled)
      4. set /etc/throttled.conf as the sample provided. Conf might change, so set the values by hand.
         - Under AC section:
         - PL1_Tdp_W: 115
         - PL2_Tdp_W: 115
         - Trip_Temp_C: 85
        ### My recommendation:
        - Only set Tdp to 115 under AC section. 
        - It's likely when you are using battery, you won't run computation heavy tasks and would still be good with the default throttling  with 30W of power, thus prolonging battery life. (still 11350 geekbench score)
        - WARNING: Do not set higher values! Do not set ANY OTHER values if you don't know what you are doing. (exmpl. undervolting)
        - This is not overclocking! This just allows the CPU to use its intended power maximum usually during peaks at normal usage.
        - DO NOT set the trip temp above 85. This will again thermal throttle the CPU but its safer and still better. IF you have a laptop stand with fans and normal roomtemp environment you can set it to 95˚C but dont stress it for long periods of time. 
        - At 85˚C the machine still got 12536 geekbench score, which is pretty good for a laptop. 
    


#### Battery:

  - after setup.sh you can use **max-battery** command with battery percentage as argument.
    ```
      #alway on AC usage:
      max-battery 60
      #more capacity needed:
      max-battery 100
    ``` 
  - Manually:     
    ```
      echo 60 | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold
    ```

  ### **After setting max-battery please reconnect the charger**
  - Please also disconnect the charger when you turn off and leave the laptop.
  - The OS (win or linux) might be able to handle charging but what happens when you turn off? 
  - Storing is best at 50-60% accord to manufacturer.

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


-----------
[My answer at askUbuntu](https://askubuntu.com/questions/1451235/almost-no-sound-alc294-in-vivobook-pro-15-ubuntu-22-04/1471708#1471708)
### Credits:
Inspiration from:     
- [https://github.com/atimonder1/asusk6500ze-linux](https://github.com/atimonder1/asusk6500ze-linux)     
- [https://github.com/goldarte/alc294_soundfix](https://github.com/goldarte/alc294_soundfix)
- [https://bugzilla.kernel.org/show_bug.cgi?id=206289](https://bugzilla.kernel.org/show_bug.cgi?id=206289)