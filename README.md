# Tooloop OS

Tooloop OS is a minimal, installation of [Debian](https://www.debian.org/), customized to fit the needs of public multimedia installations.

Tooloop OS is for media artists. It is supposed to provide a platform that is stable and easy to maintain even for those with little experience. Focus on your art!

**Tooloop OS is there for you**  to ensure your audience will only get to see your work. No balloon bubbles, no error messages, no unwanted updates, no blue screens.  
It is also very lightweight. It boots very fast and all the power of your machine is used to display your application and for nothing else.

All features on top of the base system are carefully chosen and configured to reflect this mission.


## Packages

| Package                                                             | Description                              |
|:--------------------------------------------------------------------|:-----------------------------------------|
| [Xorg](http://www.x.org/wiki/)                                      | X window system                          |
| [Openbox](http://openbox.org/wiki/Main_Page)                        | lightweight, configurable window manager |
| [Compton](https://github.com/chjj/compton)                          | OpenGL based compositor to enable vsync  |
| hsetroot                                                            | set the X background                     |
| OpenSSH                                                             | Remote access (command line)             |
| [x11vnc](http://www.karlrunge.com/x11vnc/)                          | Remote access (visual)                   |
| [PulseAudio](https://www.freedesktop.org/wiki/Software/PulseAudio/) | Linux sound system                       |
| unclutter                                                           | hides the mouse cursor                   |


## Installation

The goal is to provide ISOs ready for you to install. In the early stage of this project however, focus is still on selection of the right packages and smart configuration.

So for now, follow the steps in “[Manual installation.md](Manual installation.md)”.


## Status

The project is in an early state. I'm still researching and defining all components and how the overall system should work. What features I would want from it and could use in the future.


## Roadmap

**0.9**  
Make the system ready

**1.0**  
Create a Simple-CDD package and a default ISO

Get Graphics card installation (including hardware accelerated video)

**2.0**  
Tooloop OS Config Daemon and Tooloop Net Manager


## Configuration utilities

### Tooloop OS Config Tool

Software/Daemon on each Tooloop Box/OS to configure the player and system.

- Lightweight web server ([Mongoose?](https://github.com/cesanta/mongoose))
- Web interface for direct control of the unit
- Looks like an OSD
- Network API to be controlled by a Tooloop Management Server
- System configuration
  - Change root password
  - Network seetings
  - VNC
  - SSH
  - Media distribution (asset sync, rsync)
  - Avahi
  - Shutdown, reset
  - Choose autostart programs (and open box config)
- Control Plug-ins
  - ATI CCC
  - Nvidia settings
  - Tooloop Player
      - Playback control
      - Playlists
      - Boy groups
      - Log files (proof of play)
      - Configuration



### Tooloop Management Server

Software on a standard, lightweight LAMP server to configure multiple Tooloop Player using its’ network API.

- Webinterface
- Auto discovery of players in the network
- Media distribution to groups of Boxes (rsync? Bittorrent?)
- Playback control of groups (OSC API)
- Configuration single players (see above)
- WoL, shutdown reset


## Future Ideas

- Clever mounting of internal and external drive (external SATA or CFAST)
- Watchdog for the application
- Check this guide for some different methods (especially security)
- make an Installer using [Simple-CDD](Simple-CDD).
- Avahi?
- Check whether we can use stuff from Steam OS. E.g. Xcompmgr
- Kernal flags? SSD optimization? (check the [PC Engine dudes](https://github.com/ssinyagin/pcengines-apu-debian-cd))
