#!/bin/bash

# install dependencies
sudo apt-get install libcppunit-dev libcppunit-1.13-0v5 uuid-dev pkg-config libncurses5-dev libtool autoconf automake g++ libmicrohttpd-dev libmicrohttpd10 protobuf-compiler libprotobuf-lite9v5 python-protobuf libprotobuf-dev libprotoc-dev zlib1g-dev bison flex make libftdi-dev libftdi1 libusb-1.0-0-dev liblo-dev libavahi-client-dev python-numpy

# download latest tarball
wget https://github.com/OpenLightingProject/ola/releases/download/0.10.5/ola-0.10.5.tar.gz

# extract it
tar -zxf ola-0.10.5.tar.gz
cd ola-0.10.5
autoreconf -i

# enable python and java libs for Kivy and Processing
./configure --enable-python-libs --enable-java-libs

# build it
make -j 4
make check
sudo make install
sudo ldconfig


# Create a systemd service
mkdir -p /usr/lib/systemd/system/
cat > /usr/lib/systemd/system/olad.service <<EOF
[Unit]
Description=Open Lighting Architecture daemon
After=network.target

[Service]
User=tooloop
ExecStart=/usr/local/bin/olad
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Enable the service
systemctl enable olad

# Start the service
systemctl start olad