#!/bin/bash

if xrandr | grep -q "^HDMI-A-1 connected"; then
    xrandr --output DisplayPort-0 --off \
           --output DisplayPort-1 --mode 1920x1080 --pos 0x0 --rotate normal \
           --output HDMI-A-0 --mode 1366x768 --pos 1920x199 --rotate normal \
           --output HDMI-A-1 --mode 1920x1080 --pos 0x0 --rotate normal \
           --output HDMI-A-1-2 --off
else
    xrandr --output DisplayPort-0 --off \
           --output DisplayPort-1 --mode 1920x1080 --pos 0x0 --rotate normal \
           --output HDMI-A-0 --mode 1366x768 --pos 1920x199 --rotate normal \
           --output HDMI-A-1 --off \
           --output HDMI-A-1-2 --off
fi

feh --randomize --bg-fill ~/Bilder/backgrounds/*

