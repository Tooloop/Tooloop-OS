# Tooloop OS

![](https://img.shields.io/github/license/Tooloop/Tooloop-OS)
[![Matrix](https://img.shields.io/matrix/tooloop-os:matrix.org?label=Chat&logo=matrix)](https://app.element.io/#/room/#tooloop-os:matrix.org)

# About

[Tooloop OS](https://www.tooloop-os.org) is a platform for media artists to safely and easily develop and deploy multimedia installations.

Tooloop OS is based on [Ubuntu Server 24.04 LTS](https://www.ubuntu.com/download/server) and the super lightweight window manager [Openbox](https://en.wikipedia.org/wiki/Openbox). Both are customized to fit the needs of live and public multimedia installations.

Many ideas of Tooloop OS are based on [this article](http://openframeworks.cc/ofBook/chapters/installation_up_4evr_linux.html) in the openframeworks book on keeping a linux installation up forever. However Tooloop tries to take the aproach one step further. 

Tooloop OS comes with a set of [management and maintenance tools](https://github.com/tooloop/Tooloop-Control) and a set of [bundled apps](https://github.com/tooloop/Tooloop-Packages). You can configure and control it over the network and get built-in health and confidence monitoring.


# Who should use it?

Tooloop is designed for any kind of public, live system such as museum installations, digital signage, kiosks, etc.

Being Ubuntu based, Tooloop OS can run pretty much any Linux software. However it’s specifically designed with these frameworks in mind:

- [Unity](https://unity3d.com)
- [openframeworks](http://openframeworks.cc/)
- [Processing](https://processing.org)
- [Kivy](https://kivy.org/)

If you have written an application using one of these, Tooloop might just be what you need to stop worrying about deploying your live system.


# Status

The system is stable and usable. We are using it exclusivly for all our clients projects for years and you are warmly invited to give it a go and contribute.

Please check out [the project documentation](https://www.tooloop-os.org) if you want to learn more.


# Get involved

Help is very much welcome! If you want to have a look, install it in a virtual machine. Even better, if you have spare hardware or a project ongoing, use it and share your experience!

Open an issue here if you want to discuss ideas or changes.  
You're also very welcome in the [Tooloop OS Matrix chat room](https://app.element.io/#/room/#tooloop-os:matrix.org).


# Installation

1. Download and install [Ubuntu Server 24.04 LTS](https://ubuntu.com/download/server)
2. Name the user `tooloop`
3. SSH into your machine
    ```bash
    ssh tooloop@<IP_ADDRESS>
    ```
4. Install [Git LFS](https://git-lfs.com/)
    ```
    sudo apt install git-lfs
    ```
5. Clone the repo  
    ```bash
    git clone https://github.com/Tooloop/Tooloop-OS
    ```
6. Run the install script
    ```bash
    cd Tooloop-OS
    sudo ./install-tooloop-os.sh
    ```

You can get your Tooloop Box up and running in about 30 minutes ;-).
