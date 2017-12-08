#!/bin/bash

# ------------------------------------------------------------------------------
# Install a standard Raspbian Stretch light first
# get it here: https://www.raspberrypi.org/downloads/raspbian/
# ------------------------------------------------------------------------------

# Create temp user
sudo adduser temp-user
sudo usermod -a -G sudo temp-user
# Change the username
usermod -l tooloop pi
# Rename home directory
mv /home/pi /home/tooloop
# Change home
usermod -d /home/tooloop tooloop
# Change group name
groupmod -n tooloop pi
# Change password
echo "tooloop:tooloop" | chpasswd








# Hi
echo "-------------------------------------------------------------------------"
echo "Tooloop OS"
echo "-------------------------------------------------------------------------"
echo " "

# TODO: check path
# right now this only works when called 
# sudo ./install-tooloop-os.sh
# This does not work
#     sh install-tooloop-os.sh
#     /somepath/install-tooloop-os.sh
if [ $EUID != 0 ]; then
  echo "This script must be run using sudo"
  echo ""
  echo "usage:"
  echo "sudo "$0
  exit $exit_code
    exit 1
fi

echo " "
echo "1/4 --- Installation base packages"

# Updating system
apt-get update
apt-get dist-upgrade

# Install base packages
apt-get install -y --no-install-recommends ssh git unzip make gcc curl htop augeas-doc augeas-lenses augeas-tools


# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------
echo "2/4 --- Configuring system"

# Allow shutdown commands without password
cat >/etc/sudoers.d/tooloop-shutdown <<EOF
tooloop     ALL=(ALL) NOPASSWD: /sbin/poweroff, /sbin/reboot, /sbin/shutdown
EOF
