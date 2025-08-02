
xset s off
xset -dpms
bash /home/deluxerpanda/.screenlayout/default.sh &
slstatus &
feh --randomize --bg-fill ~/Bilder/backgrounds/* &
/usr/lib/polkit-kde-authentication-agent-1 &
picom &
flameshot &
nm-applet &
goxlr-daemon &
kdeconnectd &
exec dwm
