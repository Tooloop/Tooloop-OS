#!/bin/bash

# 2017-02-06T09:52:55+0100
ISO_DATE=$(date --iso-8601=seconds)
# 2017-02-06T09:52:55+01:00
#ISO_DATE=${ISO_DATE:0:22}:${ISO_DATE:22}

scrot --silent "/assets/screenshots/$ISO_DATE.jpg" --quality 95 --thumb 20

exit 0
