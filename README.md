# Tooloop OS

![](https://img.shields.io/badge/status-kinda%20works-blue)
![](https://img.shields.io/github/license/Tooloop/Tooloop-OS)
[![Matrix](https://img.shields.io/matrix/tooloop-os:matrix.org?label=Chat&logo=matrix)](https://matrix.to/#/%23tooloop-os:matrix.org)

![tooloop-logo](https://user-images.githubusercontent.com/4962676/169491947-b66f02e3-7a0b-4df1-9ac8-969760c730c0.png)

# About

[Tooloop OS](http://tooloop.org) is a platform for media artists to safely and easily develop and deploy multimedia installations.

Tooloop OS is based on [Ubuntu Server 22.04 LTS](https://www.ubuntu.com/download/server) and the super lightweight window manager [Openbox](http://openbox.org). Both are customized to fit the needs of live and public multimedia installations.

Many ideas of Tooloop OS are based on [this article](http://openframeworks.cc/ofBook/chapters/installation_up_4evr_linux.html) in the openframeworks book on keeping a linux installation up forever. However Tooloop tries to take the aproach one step further. 

Tooloop OS comes with a set of [management and maintenance tools](https://github.com/tooloop/Tooloop-Control) and a set of [default/example apps](https://github.com/tooloop/Tooloop-Packages). You can configure and control it over the network and get built-in health and confidence monitoring.


# Who should use it?

Tooloop is designed for any kind of public, live system such as museum installations, digital signage, kiosks, etc.

Being Ubuntu based, Tooloop OS can run pretty much any Linux software. However it’s specifically designed with these frameworks in mind:

- [Unity](https://unity3d.com)
- [openframeworks](http://openframeworks.cc/)
- [Processing](https://processing.org)
- [Kivy](https://kivy.org/)

If you have written an application using one of these, Tooloop might just be what you need to stop worrying about deploying your live system.


# Status

The system is stable and usable. In fact I am using it exclusivly for all my clients projects for years and you are warmly invited to give it a go and contribute.

Please check out [the project website](http://tooloop.org) if you want to learn more. The [manual](http://tooloop.org/Manual) and [developer docs](http://tooloop.org/Development) are a little outdated and incomplete, though.


# Get involved

Help is very much welcome! If you want to have a look, install it in a virtual machine. Even better, if you have spare hardware or a project ongoing, use it and share your experience!

Open an issue here if you want to discuss ideas or changes.  
You're also very welcome in the [Tooloop OS Matrix chat room](https://matrix.to/#/%23tooloop-os:matrix.org).


# Installation

1. Download and install [Ubuntu Server 22.04 LTS](https://ubuntu.com/download/server)
2. Name the user `tooloop`
3. SSH into your machine
    ```bash
    ssh tooloop@<IP_ADDRESS>
    ```
4. Clone the repo  
    ```bash
    git clone https://github.com/Tooloop/Tooloop-OS
    ```
5. Run the install script
    ```bash
    cd Tooloop-OS
    sudo ./install-tooloop-os.sh
    ```

You can get your Tooloop Box up and running in about 30 minutes ;-).
