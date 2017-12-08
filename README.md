# Tooloop OS

![](https://img.shields.io/badge/status-pre--release-red.svg)
![](https://img.shields.io/github/license/vollstock/tooloop-os.svg)

![](https://github.com/vollstock/Tooloop-OS/wiki/images/tooloop-header.jpg)

*Tooloop OS* is based on a minimal installation of [Ubuntu Server 16.04.3 LTS](https://www.ubuntu.com/download/server) with some post-install customization to fit the needs of public multimedia installations.

*Tooloop OS* is for media artists. It is supposed to provide a platform that is reliable, lightweight and unobtrusive. It's also easy to maintain even for those with little experience. You focus on your art. Let *Tooloop OS* present it in the best possible way!

Many ideas for Tooloop OS are based on [this article](http://openframeworks.cc/ofBook/chapters/installation_up_4evr_linux.html) in the openframeworks book on keeping a linux installation up forever. However Tooloop OS tries to take the aproach one step further. It defines conventions for apps made for it and a set of standardized hardware.


# Features

**Lightweight**  
*Tooloop OS* boots into your running application in seconds and all the power of your machine is used to display your application and for nothing else.  

- Very low memory footprint
- No unnecessary system services
- Only bare minimum of [installed packages](https://github.com/vollstock/Tooloop-OS/wiki/overview)


**Stable**  
Debian Linux is known for its stability and it’s used all over the world as a power workhorse. It’s the solid foundation that you can trust. [Others](http://store.steampowered.com/steamos/) do, too and so does [Ubuntu](http://www.ubuntu.com), the base for Tooloop OS.


**Compatibility**
Ubuntu linux is well known for it’s good support for hardware and was chosen for this reason as a basis. Linux is great but fighting with graphics drivers and getting your wifi chip up and running is no fun at all.


**Easy to manage**  
There's certain management tasks we repeatedly have to do with our live systems. Managing assets or configuring machines and software. *Tooloop OS* provides some features so you can always reach out to your machines over the network that will make your life easier.

- Remote management using SSH
- Confidence monitoring using VNC
- Network folder to manage assets
- Tooloop Settings server to manage your Tooloop Box from your browser.

**Distraction free**  
*Tooloop OS* is there for you to ensure your audience will only get to see your application. Nothing will stop the show or present anything that shouldn’t be there.

- Quiet boot
- No popup messages, no notifications, no balloon bubbles
- No automatic updates
- No (visible) mouse cursor


**Hardware**


-----------------------------------------------------

Please check out [the docs](https://github.com/vollstock/Tooloop-OS/wiki) if you want to learn more.



# Who should use it?

*Tooloop OS* is designed for any kind of public, live system such as museum installations, digital signage, kiosks, etc.

Being an Ubunto Linux, *Tooloop OS* can run pretty much any Linux software. However it specifically supports these frameworks:

- [openframeworks](http://openframeworks.cc/)
- [Processing](https://processing.org)
- [Gstreamer](https://gstreamer.freedesktop.org/)
- [Kivy](https://kivy.org/)


# Status

The project is in an early, pre-release state. Nothing here is final. It is however already used successfully in live installations and growing from there.

Please check the [roadmap](https://github.com/vollstock/Tooloop-OS/wiki/roadmap) for future development.


# Installation

In short:

    git clone https://github.com/vollstock/Tooloop-OS.git && sudo Tooloop-OS/install-tooloop-os.sh

If you're curious, please follow the [step by step guide](https://github.com/vollstock/Tooloop-OS/wiki/Manual-installation).

You can get your *Tooloop Box* up and running in about 30 minutes ;-).

[^1]: 