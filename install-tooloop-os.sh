#!/bin/bash

# Say hi
echo "-------------------------------------------------------------------------"
echo "Tooloop OS"
echo "-------------------------------------------------------------------------"
echo " "

# get the path to the script
SCRIPT_PATH="`dirname \"$0\"`"                  # relative
SCRIPT_PATH="`( cd \"$SCRIPT_PATH\" && pwd )`"  # absolutized and normalized
if [ -z "$SCRIPT_PATH" ] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi

# exit if we’re not root
if [ $EUID != 0 ]; then
  echo "This script must be run as root."
  exit $exit_code
    exit 1
fi

# Set restart mode to list only so the installations can run unattended
sed -i "s/#\$nrconf{restart} = 'i';/\$nrconf{restart} = 'l';/" /etc/needrestart/needrestart.conf


# ------------------------------------------------------------------------------
# Update
# ------------------------------------------------------------------------------
echo " "
echo "-------------------------------------------------------------------------"
echo "1/3 --- Updating system"
echo "-------------------------------------------------------------------------"
echo " "

# Updating system first
apt update -y
apt dist-upgrade -y


# ------------------------------------------------------------------------------
# Packages
# ------------------------------------------------------------------------------
echo " "
echo "-------------------------------------------------------------------------"
echo "2/3 --- Installing base packages"
echo "-------------------------------------------------------------------------"
echo " "

# Install base packages
apt install -y --no-install-recommends \
  arandr \
  augeas-doc \
  augeas-lenses \
  augeas-tools \
  avahi-daemon \
  bash-completion \
  chromium-browser \
  curl \
  dpkg-dev \
  gcc \
  git \
  git-lfs \
  hsetroot \
  htop \
  libnss-mdns \
  make \
  nano \
  netatalk \
  obconf \
  openbox \
  pavucontrol \
  pcregrep \
  psmisc \
  pulseaudio \
  scrot \
  ssh \
  tree \
  unclutter-startup \
  unclutter-xfixes \
  unzip \
  vainfo \
  x11-xserver-utils \
  x11vnc \
  xorg \
  xterm \
  zip


# ------------------------------------------------------------------------------
# Config
# ------------------------------------------------------------------------------
echo " "
echo "-------------------------------------------------------------------------"
echo "3/3 --- Configuring system"
echo "-------------------------------------------------------------------------"
echo " "

# Allow shutdown commands without password and add tooloop scripts path to sudo
cat >/etc/sudoers.d/tooloop <<EOF
# find and autocomplete tooloop scripts using sudo
Defaults  secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/opt/tooloop/scripts"
# make an alias for x11vnc start and stop commands
Cmnd_Alias VNC_CMNDS = /bin/systemctl start x11vnc, /bin/systemctl stop x11vnc
# allow these commands without using a password
tooloop     ALL=(ALL) NOPASSWD: /sbin/poweroff, /sbin/reboot, /sbin/shutdown, VNC_CMNDS
EOF

# Auto login
mkdir -p /etc/systemd/system/getty\@tty1.service.d
cat >/etc/systemd/system/getty\@tty1.service.d/autologin.conf <<EOF
[Service]
ExecStart=
ExecStart=/sbin/agetty --skip-login --noissue --autologin "tooloop" %I
EOF

# Create the /assets folder sctructure
mkdir -p /assets/data
mkdir -p /assets/logs
mkdir -p /assets/packages
mkdir -p /assets/presentation
mkdir -p /assets/screenshots

# Mount /assets folder to /media/assets so snaps have access to it
# https://askubuntu.com/questions/1228899/how-to-access-files-outside-of-home-in-snap-apps
mkdir /media/assets
echo "/assets /media/assets none bind,rw 0 0" | tee -a /etc/fstab

# Silent boot
augtool<<EOF
set /files/etc/default/grub/GRUB_DEFAULT 0
set /files/etc/default/grub/GRUB_TIMEOUT 0
set /files/etc/default/grub/GRUB_CMDLINE_LINUX_DEFAULT \""console=tty12 quiet loglevel=3 rd.systemd.show_status=false rd.udev.log-priority=3\""
save
EOF

update-grub2

# Nice SSH banner
augtool<<EOF
set /files/etc/ssh/sshd_config/Banner /etc/issue.net
save
EOF

cat >/etc/issue.net <<EOF


     |                         |
   --|--     _____     _____   |       _____     _____     _____
     |      /     \   /     \  |      /     \   /     \   /     \\
     |     |       | |       | |     |       | |       | |       |
     |     |       | |       | |     |       | |       | |       |
      \___  \____ /   \____ /   \___  \____ /   \____ /  |  ____/
                                                         |
                              based on Ubuntu 24.04 LTS  |


Hint: There's a bunch of convenient aliases starting with tooloop-...
E.g. tooloop-presentation-stop, tooloop-settings

-------------------------------------------------------------------------

EOF

# Get rid of the last login message
touch /home/tooloop/.hushlogin
chown tooloop:tooloop /home/tooloop/.hushlogin

# Hide verbose kernel messages
cat >/etc/sysctl.d/20-quiet-printk.conf <<EOF
kernel.printk = 3 3 3 3
EOF

# Disable wait-online service to prevent the system from waiting forever on a 
# network connection. This will disable the following services:
# open-iscsi.service cloud-final.service cloud-config.service iscsid.service
# https://askubuntu.com/questions/972215/a-start-job-is-running-for-wait-for-network-to-be-configured-ubuntu-server-17-1
systemctl disable systemd-networkd-wait-online.service
systemctl mask systemd-networkd-wait-online.service

# Copy bash config
cp "$SCRIPT_PATH"/files/bashrc /home/tooloop/.bashrc
chown tooloop:tooloop /home/tooloop/.bashrc

# Copy Openbox theme
cp -R "$SCRIPT_PATH"/files/openbox-theme/* /usr/share/themes/

# Copy Openbox config
mkdir -p /home/tooloop/.config
mkdir -p /home/tooloop/.config/openbox
cp -R "$SCRIPT_PATH"/files/openbox-config/* /home/tooloop/.config/openbox/

# Copy Openbox menu icons
mkdir -p /home/tooloop/.config/openbox-menu-icons
cp -R "$SCRIPT_PATH"/files/openbox-menu-icons/* /home/tooloop/.config/openbox-menu-icons/

# Copy Clear Sans font
cp -R "$SCRIPT_PATH"/include/clearsans /usr/share/fonts/truetype

# Copy scripts
mkdir -p /opt/tooloop
cp -R "$SCRIPT_PATH"/files/scripts /opt/tooloop
chmod +x /opt/tooloop/scripts/*

# Get control center
git clone --branch dev https://github.com/tooloop/Tooloop-Control.git /opt/tooloop/control-center

# Install dependencies
/bin/bash /opt/tooloop/control-center/install.sh

# Create a systemd service for control center
mkdir -p /usr/lib/systemd/system/
cat > /usr/lib/systemd/system/tooloop-control.service <<EOF
[Unit]
Description=Tooloop control center
After=network.target

[Service]
Environment=DISPLAY=:0
Environment=XAUTHORITY=/home/tooloop/.Xauthority
ExecStart=/opt/tooloop/control-center/venv/bin/python /opt/tooloop/control-center/app.py
Restart=always

[Install]
WantedBy=graphical.target
EOF

# Enable and start the service
systemctl enable tooloop-control
systemctl start tooloop-control

# Create a systemd target for Xorg
# info here: https://superuser.com/a/1128905
mkdir -p /usr/lib/systemd/user
cat > /usr/lib/systemd/user/xsession.target <<EOF
[Unit]
Description=XSession
BindsTo=graphical-session.target
EOF

# Create a systemd service for the VNC server
cat > /usr/lib/systemd/user/x11vnc.service <<EOF
[Unit]
Description=x11vnc screen sharing service

[Service]
Environment=DISPLAY=:0
Environment=XAUTHORITY=/home/tooloop/.Xauthority
Type=simple
ExecStart=/bin/sh -c '/usr/bin/x11vnc -shared -forever -passwd tooloop'
Restart=on-success
SuccessExitStatus=3

[Install]
WantedBy=xsession.target
EOF


# Create a cronjob to take a screenshot every minute
# and one to clean up screenshots every day at 00:00
if ! crontab -u tooloop -l | grep -q tooloop-screenshot; then
  (crontab -u tooloop -l ; echo "* * * * * env DISPLAY=:0.0 /opt/tooloop/scripts/tooloop-screenshot") | crontab -u tooloop -
  (crontab -u tooloop -l ; echo "0 0 * * * /opt/tooloop/scripts/tooloop-screenshots-clean") | crontab -u tooloop -
fi


# make Enttec USB DMX devices accessable to the tooloop user
usermod -aG tty tooloop
usermod -aG dialout tooloop
cat > /etc/udev/rules.d/75-permissions-enttec.rules <<EOF
SUBSYSTEM=="usb", ACTION=="add|change", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", "MODE="0666"
EOF

# Create local deb repository
mkdir -p /assets/packages/media/
mkdir -p /assets/packages/conf/
cat > /assets/packages/conf/distributions <<EOF
Origin: Tooloop_Local_Repo
Label: Tooloop_Local_Repo
Codename: jammy
Architectures: amd64
Components: main
Description: Local repository for Tooloop presentations and addons
EOF

# Add to apt source list
if ! grep -q file:/assets/packages /etc/apt/sources.list; then
  echo "deb [allow-insecure=yes] file:/assets/packages ./" | tee -a /etc/apt/sources.list
fi

# Stop apt from removing empty folders when uninstalling stuff
touch /assets/data/.keep
touch /assets/presentation/.keep
touch /opt/tooloop/control-center/installed_app/.keep

# Get bundled packages
# TODO: download release from github
# https://github.com/Tooloop/Tooloop-Packages/issues/2
git clone --branch dev https://github.com/Tooloop/Tooloop-Packages.git /home/tooloop/Tooloop-Packages
cd /home/tooloop/Tooloop-Packages
./build.sh
./deploy.sh

# Install Onboarding App
apt install -y --allow-unauthenticated tooloop-onboarding

# Chown things to the tooloop user
chown -R tooloop:tooloop /assets/
chown -R tooloop:tooloop /home/tooloop/
chown -R tooloop:tooloop /opt/tooloop/

# Configure netatalk so we can see the assets and home folders on a Macs Finder
cat > /etc/netatalk/afp.conf <<EOF
;
; Netatalk 3.x configuration file
;

[Global]
; Global server settings

[Homes]
basedir regex = /home

[Assets]
path = /assets
EOF

# Publish services over Avahi/Bonjour
cp /usr/share/doc/avahi-daemon/examples/sftp-ssh.service /etc/avahi/services
cp /usr/share/doc/avahi-daemon/examples/ssh.service /etc/avahi/services

cat > /etc/avahi/services/vnc.service <<EOF
<?xml version="1.0" standalone='no'?><!--*-nxml-*-->
<!DOCTYPE service-group SYSTEM "avahi-service.dtd">
<service-group>
 <name replace-wildcards="yes">%h</name>
 <service>
 <type>_rfb._tcp</type>
 <port>5900</port>
 </service>
</service-group>
EOF

# Enable wake on lan for all ethernet interfaces
for i in $(ls /sys/class/net/ | grep en)
do
    netplan set network.ethernets.$i.wakeonlan=true
done


echo " "
echo "-------------------------------------------------------------------------"
echo "Done."
echo "-------------------------------------------------------------------------"
echo " "

sleep 1

echo "We will reboot now into your Tooloop OS installation."
echo "Enjoy ;-)"

sleep 5

reboot
