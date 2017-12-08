#!/bin/bash

# Hi
echo "-------------------------------------------------------------------------"
echo "Tooloop OS"
echo "-------------------------------------------------------------------------"
echo " "

SCRIPT_PATH="`dirname \"$0\"`"              # relative
SCRIPT_PATH="`( cd \"$SCRIPT_PATH\" && pwd )`"  # absolutized and normalized
if [ -z "$SCRIPT_PATH" ] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi

if [ $EUID != 0 ]; then
  echo "This script must be run as root."
  exit $exit_code
    exit 1
fi


# ------------------------------------------------------------------------------
# Update
# ------------------------------------------------------------------------------
echo " "
echo "1/5 --- Updating system"

# Updating system
apt-get update -y
apt-get dist-upgrade -y


# ------------------------------------------------------------------------------
# Packages
# ------------------------------------------------------------------------------
echo " "
echo "2/5 --- Installing base packages"

# Install base packages
apt-get install -y --no-install-recommends \
  xorg \
  x11-xserver-utils \
  openbox \
  obmenu \
  obconf \
  firefox \
  compton \
  ssh \
  x11vnc \
  pulseaudio \
  pavucontrol \
  unclutter \
  scrot \
  git \
  unzip \
  make \
  gcc \
  curl \
  htop \
  vainfo \
  augeas-doc \
  augeas-lenses \
  augeas-tools

# ------------------------------------------------------------------------------
# Config
# ------------------------------------------------------------------------------
echo " "
echo "3/5 --- Configuring system"

#Defaults secure_path="<default value>:/usr/local/bin"
# Allow shutdown commands without password
cat >/etc/sudoers.d/tooloop-shutdown <<EOF
tooloop     ALL=(ALL) NOPASSWD: /sbin/poweroff, /sbin/reboot, /sbin/shutdown
EOF

# Auto login
mkdir -p /etc/systemd/system/getty\@tty1.service.d
cat >/etc/systemd/system/getty\@tty1.service.d/autologin.conf <<EOF
[Service]
ExecStart=
ExecStart=/sbin/agetty --skip-login --noissue --autologin "tooloop" %I
EOF

# Create the /assets folder sctructure
mkdir -p /assets/presentation
mkdir -p /assets/data
mkdir -p /assets/screenshots
mkdir -p /assets/logs
mkdir -p /assets/apps

# Silent boot
augtool<<EOF
set /files/etc/default/grub/GRUB_DEFAULT 0
set /files/etc/default/grub/GRUB_TIMEOUT 0
set /files/etc/default/grub/GRUB_CMDLINE_LINUX \""console=tty12\""
set /files/etc/default/grub/GRUB_CMDLINE_LINUX_DEFAULT \""quiet loglevel=3 vga=current rd.systemd.show_status=false rd.udev.log-priority=3\""
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
                      Tooloop OS 0.9  |  Ubuntu 16.04.3  |


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


# Copy Bash config
cp "$SCRIPT_PATH"/files/bashrc /home/tooloop/.bashrc
chown tooloop:tooloop /home/tooloop/.bashrc

# Copy Openbox theme
cp -R "$SCRIPT_PATH"/files/openbox-theme/* /usr/share/themes/

# Copy Openbox config
mkdir -p /home/tooloop/.config
mkdir -p /home/tooloop/.config/openbox
cp -R "$SCRIPT_PATH"/files/openbox-config/* /home/tooloop/.config/openbox/

# Copy Openbox menu icons
mkdir -p /home/tooloop/.config/icons
cp -R "$SCRIPT_PATH"/files/openbox-menu-icons/* /home/tooloop/.config/icons/

# Copy start- and stop-presentation scripts
cp "$SCRIPT_PATH"/files/start-presentation.sh /assets/presentation/
cp "$SCRIPT_PATH"/files/stop-presentation.sh /assets/presentation/

# Copy Clear Sans font
cp -R "$SCRIPT_PATH"/include/clearsans /usr/share/fonts/truetype

# Copy scripts
mkdir -p /opt/tooloop
cp -R "$SCRIPT_PATH"/files/scripts /opt/tooloop
chmod +x /opt/tooloop/scripts/*.sh


# Get settings server
git clone https://github.com/vollstock/Tooloop-Settings-Server.git /opt/tooloop/settings-server

# install dependencies
/bin/bash /opt/tooloop/settings-server/install-dependencies.sh

# Create a systemd service for settings server
mkdir -p /usr/lib/systemd/system/
cat > /usr/lib/systemd/system/tooloop-settings-server.service <<EOF
[Unit]
Description=Tooloop settings server

[Service]
Environment=DISPLAY=:0
Environment=XAUTHORITY=/home/tooloop/.Xauthority
ExecStart=/usr/bin/python /opt/tooloop/settings-server/tooloop-settings-server.py
Restart=always

[Install]
WantedBy=graphical.target
EOF

# Enable the service
systemctl enable tooloop-settings-server

# Start the service
systemctl start tooloop-settings-server

# Create a systemd service for the VNC server
mkdir -p /usr/lib/systemd/system
cat > /usr/lib/systemd/system/x11vnc.service <<EOF
[Unit]
Description=x11vnc remote session for login.
After=network.target

[Service]
Type=simple
ExecStart=/bin/sh -c '/usr/bin/x11vnc -forever'
Restart=on-success
SuccessExitStatus=3

[Install]
WantedBy=multi-user.target
EOF


# Create a cronjob to take a screenshot every minute
(crontab -u tooloop -l ; echo "* * * * * env DISPLAY=:0.0 /opt/tooloop/scripts/screenshot.sh") | crontab -u tooloop -

# Create a cronjob to clean up screenshots every day at 00:00
(crontab -u tooloop -l ; echo "0 0 * * * /opt/tooloop/scripts/clean-screenshots.sh") | crontab -u tooloop -


# make Enttec USB DMX devices accessable to the tooloop user
usermod -aG tty tooloop
usermod -aG dialout tooloop
cat > /etc/udev/rules.d/75-permissions-enttec.rules <<EOF
SUBSYSTEM=="usb", ACTION=="add|change", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", "MODE="0666"
EOF


# Chown things to the tooloop user
chown -R tooloop:tooloop /assets/
chown -R tooloop:tooloop /home/tooloop/
chown -R tooloop:tooloop /opt/tooloop/scripts/


echo " "
echo "Done."
echo " "
sleep 1

echo "We will reboot now into your Tooloop OS installation."
echo "Enjoy ;-)"
sleep 5

reboot