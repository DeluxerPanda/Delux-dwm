#!/bin/bash
titel_message="
 █████╗ ██████╗  ██████╗██╗  ██╗    ██████╗ ███████╗██╗     ██╗   ██╗██╗  ██╗
██╔══██╗██╔══██╗██╔════╝██║  ██║    ██╔══██╗██╔════╝██║     ██║   ██║╚██╗██╔╝
███████║██████╔╝██║     ███████║    ██║  ██║█████╗  ██║     ██║   ██║ ╚███╔╝
██╔══██║██╔══██╗██║     ██╔══██║    ██║  ██║██╔══╝  ██║     ██║   ██║ ██╔██╗
██║  ██║██║  ██║╚██████╗██║  ██║    ██████╔╝███████╗███████╗╚██████╔╝██╔╝ ██╗
╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ╚═════╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝
"
separator="-------------------------------------------------------------------------"

if [ "$(id -u)" -eq 0 ]; then
clear
titel_message_length=${#titel_message}
spaces=$(( (${#separator} - message_length) / 2 ))
printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$titel_message" ""

message="You can't run as root"
message_length=${#message}
spaces=$(( (${#separator} - message_length) / 2 ))
printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$message" "$separator"

exit 1
else
clear
titel_message_length=${#titel_message}
spaces=$(( (${#separator} - message_length) / 2 ))
printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$titel_message" ""

message="Script starting"
message_length=${#message}
spaces=$(( (${#separator} - message_length) / 2 ))
printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$message" "$separator"
echo -ne "
1: installing: xorg, xinit, xwallpaper, xcompmgr, arandr, flameshot, rofi, bat cat, pavucontrol
4: installing starship
5: Fixing dwm, st, slstatus. Så dom funkar!
6: Creates folder for background images and moves them to the folder!
7: Starting DWM
-------------------------------------------------------------------------"
sudo pacman -Sy --noconfirm --needed
sudo pacman -Syu --noconfirm --needed
fi
if [ -z "$work_dir" ]; then
    work_dir=$(pwd)
fi

#installing program!
clear

sudo pacman -S --noconfirm --needed xorg
clear
sudo pacman -S --noconfirm --needed xorg-xinit
clear
sudo pacman -S --noconfirm --needed xwallpaper
clear
sudo pacman -S --noconfirm --needed xcompmgr
clear
sudo pacman -S --noconfirm --needed arandr
clear
sudo pacman -S --noconfirm --needed flameshot
clear
sudo pacman -S --noconfirm --needed rofi
clear
sudo pacman -S --noconfirm --needed bat
clear
sudo pacman -S --noconfirm --needed pavucontrol
clear

cd $work_dir

#installing starship
clear
    sudo mv $work_dir/Starship_conf/starship.toml ~/.config/
    echo "Flyttar starship.toml"
    curl -sS https://starship.rs/install.sh | sh -s -- --yes

#Creates folder for background images and moves them to the folder!
clear

mkdir -p ~/Bilder/Wallpapers

mv $work_dir/Wallpapers/ ~/Bilder/

#Fxiing dwm
clear

mkdir -p ~/.config/suckless

cd $work_dir/suckless

for app in "dwm" "st" "slstatus"; do
    sudo mv "$app" ~/.config/suckless
    echo "Moving $app"
done

for app in "dwm" "st" "slstatus"; do
    cd ~/.config/suckless/"$app"
    echo "Installing $app"
    sudo make clean install
done

#Fxiing RC
clear

cd $work_dir/RC_conf
for app in ".bashrc" ".xinitrc" ".bash_profile"; do
    mv "$app" ~/
    echo "Moving $app"
done
cd $work_dir

sudo mkdir -p /usr/share/fonts/TTF
sudo mv $work_dir/Fonts/JetBrainsMonoNLNerdFontMono-Regular.ttf /usr/share/fonts/TTF/
fc-cache
#Starting DWM
startx
