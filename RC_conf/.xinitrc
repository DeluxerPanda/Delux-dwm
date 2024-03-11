#!/bin/sh
xwallpaper --zoom $HOME/Bilder/Bakgrundsbilder/Wallpaper1.png
xset s off -dpms
xcompmgr &
slstatus &
exec dwm
