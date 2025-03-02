#!/bin/bash

if xrandr | grep -q "DisplayPort-1"; then

xrandr --output DisplayPort-0 --off --output DisplayPort-1 --mode 1920x1080 --pos 1366x0 --rotate normal --output HDMI-A-0 --mode 1366x768 --pos 0x321 --rotate normal --output HDMI-A-1 --mode 1920x1080 --pos 1366x0 --rotate normal --output HDMI-A-1-2 --off

else

 xrandr --output DisplayPort-0 --off --output DisplayPort-1 --mode 1920x1080 --pos 1366x0 --rotate normal --output HDMI-A-0 --mode 1366x768 --pos 0x156 --rotate normal --output HDMI-A-1 --off --output HDMI-A-1-2 --off
fi

feh --randomize --bg-fill ~/Bilder/backgrounds/*