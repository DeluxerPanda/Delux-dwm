#!/bin/sh
xrandr --output eDP --scale 0.5x0.5
xwallpaper --zoom $HOME/Bilder/Wallpapers/wallpaper1.jpg
xcompmgr &
slstatus &
exec dwm
