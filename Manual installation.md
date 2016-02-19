# Tooloop OS – Manual installation


## Debian installer

Download and use *Debian Jessie netinst*.

When asked, set up 4 partitions:

    #1  primary  10.0 GB  ext4  /
    #5  logical   8.0 GB  swap  swap
    #6  logical  20.0 GB  ext4  /home
    #6  logical  76.0 GB  ext4  /assets

In *Software selection* (tasksel) deselect averything except **SSH server**


## Post install


### Enable non-free and contrib packages

In `/etc/apt/sources.list` add to each line

    <... jessie main> contrib non-free

Also add backports

    # jessie backports
    deb http://ftp.de.debian.org/debian/ jessie-backports main contrib non-free
    deb-src http://ftp.de.debian.org/debian/ jessie-backports main contrib non-free

Update the apt cache

    apt update


## Silent boot

Change the GRUB config file `/etc/default/grub`

    GRUB_DEFAULT=0
    GRUB_TIMEOUT=0
    GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
    GRUB_CMDLINE_LINUX_DEFAULT="quiet"
    GRUB_CMDLINE_LINUX="console=tty12"

Afterwards call:

    update-grub2

This will make sure, that the GRUB menu never shows. Also all GRUB messages are printed to tty12, so we don't get to see them in tty1.


## Auto login

    mkdir /etc/systemd/system/getty\@tty1.service.d
    nano /etc/systemd/system/getty\@tty1.service.d/autologin.conf

Content:

    [Service]
    ExecStart=
    ExecStart=/sbin/agetty --autologin "tooloop" %I


## Make the assets partition readable for the tooloop user

    chown tooloop:tooloop /assets/


## Install additional Packages

    apt-get update && apt-get install --no-install-recommends ssh sudo xorg x11-xserver-utils openbox obmenu obconf compton hsetroot x11vnc pulseaudio unclutter git unzip make gcc


## Openbox and session

Copy these files

| File / folder    | Location                    |
|:-----------------|:----------------------------|
| Openbox config   | ~/.config/openbox/rc.xml    |
| Right-click menu | ~/.config/openbox/menu.xml  |
| Autostart        | ~/.config/openbox/autostart |
| Theme            | /usr/share/themes/Tooloop/  |
| Icons            | ~/.config/icons/*           |
|                  | ~/.profile                  |
|                  | ~/.bashrc                   |

**TODO** check proper way for aliases so they are available for
* tooloop user local
* tooloop user via ssh
* su


## Allow shutdown commands for everyone

Edit the file `/etc/sudoers` to allow the normal user to shutdown and restart.

    nano /etc/sudoers

Add this line to the very end of the file so it doesn't get overwritten by other rules

    tooloop     ALL=(ALL) NOPASSWD: /sbin/poweroff, /sbin/reboot, /sbin/shutdown

Now you can simply add execute commands to the menu calling one of these calls

    sudo shutdown -h now
    sudo shutdown -r now

    # or

    sudo poweroff
    sudo reboot


## Disable screen saver

Put this in ~/.config/openbox/autostart

    # turn screen saver off
    xset s 0
    xset s blank
    xset s off

    # disable DPMS (Energy Star) features
    xset dpms 0 0 0
    xset -dpms

    # disable bell
    xset b off

We can always turn the screen on and with these commands:

    xset dpms force off
    xset dpms force standby
    xset dpms force on && xset -dpms
    # xset dpms force on will implicitly enable DPMS features, we hence turn it back off at the same time


## Graphics driver

### AMD Radeon

Download the driver, and unzip it

Install Kernel headers

    apt-cache search linux-headers-$(uname -r)
    apt-get install linux-headers-$(uname -r)

Run the installer

    ./amd-driver-installer-15.201.2401-x86.x86_64.run

Create initial xorg config using it

    aticonfig --initial
