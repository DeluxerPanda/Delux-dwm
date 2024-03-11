#!/bin/sh
xwallpaper --zoom $HOME/Bilder/Wallpapers/Wallpaper1.png
xset s off -dpms
xcompmgr &
slstatus &
exec dwm
