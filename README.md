# Tooloop OS

![](https://img.shields.io/badge/status-pre--release-red.svg)
![](https://img.shields.io/github/license/vollstock/tooloop-os.svg)

![](https://github.com/vollstock/Tooloop-OS/wiki/images/tooloop-header.jpg)

# About

*Tooloop OS* is based on a minimal installation of [Ubuntu Server 16.04.3 LTS](https://www.ubuntu.com/download/server) with some post-install customization to fit the needs of public multimedia installations.

*Tooloop OS* is for media artists. It is supposed to provide a platform that is reliable, lightweight and unobtrusive. It's also easy to maintain, even for those with little experience. You focus on your art. Let *Tooloop OS* present it in the best possible way!

Many ideas for *Tooloop OS* are based on [this article](http://openframeworks.cc/ofBook/chapters/installation_up_4evr_linux.html) in the openframeworks book on keeping a linux installation up forever. However *Tooloop OS* tries to take the aproach one step further. It defines conventions for apps made for it and a set of [standardized hardware](https://github.com/vollstock/Tooloop-OS/wiki/hardware).

![](https://github.com/vollstock/Tooloop-OS/wiki/images/easy.svg)



# Features and goals

**Lightweight**  
*Tooloop OS* boots into your running application in seconds and all the power of your machine is used to display your application and for nothing else.  

- Low memory footprint
- No unnecessary system services
- Only bare minimum of [installed packages](https://github.com/vollstock/Tooloop-OS/wiki/overview)


**Stable**  
Debian Linux is known for its stability and it’s used all over the world as a power workhorse. It’s the solid foundation that you can trust. [Others](http://store.steampowered.com/steamos/) do, too and so does [Ubuntu](http://www.ubuntu.com), the base for Tooloop OS.


**Compatible**
Ubuntu linux is well known for it’s good support for hardware and was chosen for this reason as a basis. Linux is great but fighting with graphics drivers and getting your wifi chip up and running is no fun at all.

But let's not stop there, just yet. The goal ist to maintain a [list of compatible hardware](https://github.com/vollstock/Tooloop-OS/wiki/overview) covering all the range from small and cheap to full-blown and powerful.

Don't waste your time on researching hardware. Choose an option from the shopping list and trust it will work just fine.


**Easy to manage**  
There's certain management tasks we repeatedly have to do with our live systems. Managing assets or configuring machines and software. *Tooloop OS* provides some features so you can always reach out to your machines over the network that will make your life easier.

- Remote management using SSH
- Confidence monitoring using VNC
- [Tooloop Settings server](https://github.com/vollstock/Tooloop-Settings-Server) to manage your Tooloop Box from a browser.


**Distraction free**  
*Tooloop OS* is there for you to ensure your audience will only get to see your application. Nothing will stop the show or present anything that shouldn’t be there.

- Quiet boot
- No popup messages, no notifications, no balloon bubbles
- No automatic updates
- No (visible) mouse cursor


**Opinionated**
*Tooloop OS* is supposed to make your live easier. Many times it does that by defining conventions of how an app *should* work.  

The idea is to create an eco system of apps, that you can load on a tooloop box and you will always know how to install, start and stop them, where to look for log files etc.


# Who should use it?

*Tooloop OS* is designed for any kind of public, live system such as museum installations, digital signage, kiosks, etc.

Being an Ubunto Linux, *Tooloop OS* can run pretty much any Linux software. However it specifically supports these frameworks:

- [openframeworks](http://openframeworks.cc/)
- [Processing](https://processing.org)
- [Gstreamer](https://gstreamer.freedesktop.org/)
- [Kivy](https://kivy.org/)

If you have written an application using one of these, *Tooloop OS* might just be what you need to stop worrying about deploying your live system.


# Status

The project is in an early state. Nothing here is final. It is however already used successfully in live installations and growing from there.  

Please check out [the project wiki](https://github.com/vollstock/Tooloop-OS/wiki) if you want to learn more. Also have a look at the [roadmap](https://github.com/vollstock/Tooloop-OS/wiki/roadmap) for future ideas.

# Get involved

Help is very much welcome! If you want to have a look, install it in a virtual machine. Even better, if you have spare hardware or a project ongoing, use it and share your experience!

Open an issue here if you want to discuss ideas or changes.  


# Installation

Install the base system following [this guide](https://github.com/vollstock/Tooloop-OS/wiki/installation).

Then Download and install the *Tooloop OS* repo:  

    git clone https://github.com/vollstock/Tooloop-OS.git && sudo Tooloop-OS/install-tooloop-os.sh``

You can get your *Tooloop Box* up and running in about 30 minutes ;-).