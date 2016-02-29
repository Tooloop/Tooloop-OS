#!/bin/sh

# here comes everything, you need to stop the running presentation
# basically kill or stop everything you started in `start-presentation.sh`

kill $(pidof xeyes)
