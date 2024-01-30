#!/bin/bash
titel_message="
██████╗ ███████╗██████╗ ██╗ █████╗ ███╗   ██╗    ██████╗ ███████╗██╗     ██╗   ██╗██╗  ██╗
██╔══██╗██╔════╝██╔══██╗██║██╔══██╗████╗  ██║    ██╔══██╗██╔════╝██║     ██║   ██║╚██╗██╔╝
██║  ██║█████╗  ██████╔╝██║███████║██╔██╗ ██║    ██║  ██║█████╗  ██║     ██║   ██║ ╚███╔╝ 
██║  ██║██╔══╝  ██╔══██╗██║██╔══██║██║╚██╗██║    ██║  ██║██╔══╝  ██║     ██║   ██║ ██╔██╗ 
██████╔╝███████╗██████╔╝██║██║  ██║██║ ╚████║    ██████╔╝███████╗███████╗╚██████╔╝██╔╝ ██╗
╚═════╝ ╚══════╝╚═════╝ ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝    ╚═════╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝
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
1: installerar: wget, libxft, libxinerama, xorg-xrandr, xwallpaper, rofi,
alsa-utils, base-devel, firefox, dolphin, xcompmgr, neofetch, 
noto-fonts-emoji, arandr, breeze-icons, bash-completion, xinit
3: installerar p7zip-gui
4: installerar starship
5: Fixar dwm, st, slstatus. Så dom funkar!
6: Skapar mapp för bakgrundsbilder och flyttar dom till mappen!
7: Startar DWM
-------------------------------------------------------------------------"
sudo pacman -Syu --noconfirm --needed
fi
if [ -z "$arbets_dir" ]; then
    arbets_dir=$(pwd)
fi

#Installerar program!
clear
titel_message_length=${#titel_message}
spaces=$(( (${#separator} - message_length) / 2 ))
printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$titel_message" ""

message="Installerar program!"
message_length=${#message}
spaces=$(( (${#separator} - message_length) / 2 ))
printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$message" "$separator"

message2="wget, libxft, libxinerama, xorg-xrandr, xwallpaper, rofi,
alsa-utils, base-devel, firefox, dolphin, xcompmgr, neofetch, 
noto-fonts-emoji, arandr, breeze-icons, bash-completion, xinit"
message2_length=${#message2}
spaces=$(( (${#separator} - message2_length) / 2 ))
 printf "%s%${spaces}s%s\n%s\n" "" "" "$message2" "$separator"

sudo apt update
sudo apt install -y wget
sudo apt install -y xwallpaper
sudo apt install -y rofi
sudo apt install -y firefox
sudo apt install -y dolphin
sudo apt install -y xcompmgr
sudo apt install -y neofetch
sudo apt install -y fonts-noto-color-emoji
sudo apt install -y arandr
sudo apt install -y breeze-icon-theme
sudo apt install -y bash-completion

sudo apt install -y build-essential
sudo apt install -y libx11-dev
sudo apt install -y libxft-dev
sudo apt install -y libxinerama-dev
sudo apt install -y libfreetype6-dev
sudo apt install -y libfontconfig1-dev
sudo apt install -y xinit

#Installerar flatpak
clear
titel_message_length=${#titel_message}
spaces=$(( (${#separator} - message_length) / 2 ))
printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$titel_message" ""

message="installerar flatpak"
message_length=${#message}
spaces=$(( (${#separator} - message_length) / 2 ))
printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$message" "$separator"

message2="The future of apps on Linux"
message2_length=${#message2}
spaces=$(( (${#separator} - message2_length) / 2 ))
 printf "%s%${spaces}s%s\n%s\n" "" "" "$message2" "$separator"
 
sudo apt install -y flatpak

#Installerar p7zip-gui
clear
titel_message_length=${#titel_message}
spaces=$(( (${#separator} - message_length) / 2 ))
printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$titel_message" ""

message="Installerar p7zip-gui"
message_length=${#message}
spaces=$(( (${#separator} - message_length) / 2 ))
printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$message" "$separator"

message2="p7zip-gui"
message2_length=${#message2}
spaces=$(( (${#separator} - message2_length) / 2 ))
 printf "%s%${spaces}s%s\n%s\n" "" "" "$message2" "$separator"

flatpak install flathub io.github.peazip.PeaZip

#installerar starship
clear
titel_message_length=${#titel_message}
spaces=$(( (${#separator} - message_length) / 2 ))
printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$titel_message" ""

message="installerar starship"
message_length=${#message}
spaces=$(( (${#separator} - message_length) / 2 ))
printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$message" "$separator"


    sudo mv $arbets_dir/Starship_conf/starship.toml ~/.config/
    echo "Flyttar starship.toml"
    curl -sS https://starship.rs/install.sh | sh -s -- --yes

#Skapar mapp för bakgrundsbilder och flyttar dom till mappen!
clear
titel_message_length=${#titel_message}
spaces=$(( (${#separator} - message_length) / 2 ))
printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$titel_message" ""

message="Skapar mapp för bakgrundsbilder och flyttar dom till mappen!"
message_length=${#message}
spaces=$(( (${#separator} - message_length) / 2 ))
printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$message" "$separator"

mkdir -p ~/Bilder/Wallpapers

mv $arbets_dir/Wallpapers/ ~/Bilder/

#Fixar dwm
clear
titel_message_length=${#titel_message}
spaces=$(( (${#separator} - message_length) / 2 ))
printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$titel_message" ""

message="Fixar dwm, st, slstatus"
message_length=${#message}
spaces=$(( (${#separator} - message_length) / 2 ))
printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$message" "$separator"

message2="Fixar dwm, st, slstatus. Så dom funkar!"
message2_length=${#message2}
spaces=$(( (${#separator} - message2_length) / 2 ))
 printf "%s%${spaces}s%s\n%s\n" "" "" "$message2" "$separator"

mkdir -p ~/.config/suckless
cd $arbets_dir/dwm_saker
for app in "dwm" "st" "slstatus"; do
    sudo mv "$app" ~/.config/suckless
    echo "Moving $app"
done
for app in "dwm" "st" "slstatus"; do
    cd ~/.config/suckless/"$app"
    echo "Installing $app"
    sudo make clean install
done
#Fixar RC
clear
titel_message_length=${#titel_message}
spaces=$(( (${#separator} - message_length) / 2 ))
printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$titel_message" ""

message="Flyttar bashrc, xinitrc"
message_length=${#message}
spaces=$(( (${#separator} - message_length) / 2 ))
printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$message" "$separator"

cd $arbets_dir/RC_conf
for app in ".bashrc" ".xinitrc"; do
    mv "$app" ~/
    echo "Moving $app"
done


sudo mkdir -p /usr/share/fonts/TTF
sudo mv $arbets_dir/Fonts/JetBrainsMonoNLNerdFontMono-Regular.ttf /usr/share/fonts/TTF/

cd ~/
rm -rf $arbets_dir

startx
