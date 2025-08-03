xset s off
xset -dpms
~/scripts/screenlayout_default.sh &
~/scripts/GoXLR_loopback.sh &
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
slstatus &
feh --randomize --bg-fill ~/Bilder/backgrounds/* &
picom &
flameshot &
nm-applet &
goxlr-daemon &
kdeconnectd &
exec dwm
