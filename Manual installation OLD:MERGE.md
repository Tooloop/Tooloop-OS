# Merg this to the other file

**Compton**

Start it with these options in the Openbox autostart file to have vsync enabled (also for fullscreen video)

    compton --backend glx --vsync opengl-swc --refresh-rate 60 --glx-no-stencil
--glx-no-rebind-pixmap &

(i) Compton can do a benchmark to check performance influence of each parameter.

GLX backend is needed for the used vsync option. The last parameters (`--refresh-rate 60 --glx-no-stencil --glx-no-rebind-pixmap`), however work but are to be examined in terms of performance.

**Desktop background**

Add this line to to the Openbox autostart file

    # set black background
    hsetroot -solid '#000000' &

**x11vnc**

Follow [this guide](https://www.debian-administration.org/article/135/Remotely_administering_machines_graphically_with_VNC) for configuration and put it in the Openbox autostart file

    # start VNC server
    x11vnc -shared -forever &



**Auto start Openbox**

Edit or create a `.bash_profile`

    nano .bash_profile

Add this line

    # make every GUI tool appear on display 0, even from SSH export DISPLAY=:0

    #[[ $fgconsole 2>/dev/null) == 1 ]] && exec startx -- vtl &> /dev/null
    startx


**Configure Openbox**

| File           | Path                          |
|:---------------|:------------------------------|
| Config file    | `~/.config/openbox/rc.xml`    |
| Menu file      | `~/.config/openbox/menu.xml`  |
| Autostart file | `~/.config/openbox/autostart` |
| Theme          | `~/.themes/Tooloop-OS/*`      |
| Icons          | `~/.config/icons/*`           |

For easier access use the gui tools: `obconf` and `obmenu`.
