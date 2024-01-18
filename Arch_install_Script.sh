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
1: installerar: wget, libxft, libxinerama, xorg-xrandr, xwallpaper, rofi,
alsa-utils, base-devel, firefox, dolphin, xcompmgr, neofetch, 
noto-fonts-emoji, arandr, breeze-icons, bash-completion
2: installerar YAY
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
noto-fonts-emoji, arandr, breeze-icons, bash-completion"
message2_length=${#message2}
spaces=$(( (${#separator} - message2_length) / 2 ))
 printf "%s%${spaces}s%s\n%s\n" "" "" "$message2" "$separator"

sudo pacman -S --noconfirm --needed wget
sudo pacman -S --noconfirm --needed libxft
sudo pacman -S --noconfirm --needed libxinerama
sudo pacman -S --noconfirm --needed xorg-xrandr
sudo pacman -S --noconfirm --needed xwallpaper
sudo pacman -S --noconfirm --needed rofi
sudo pacman -S --noconfirm --needed alsa-utils
sudo pacman -S --noconfirm --needed base-devel
sudo pacman -S --noconfirm --needed firefox    
sudo pacman -S --noconfirm --needed dolphin
sudo pacman -S --noconfirm --needed xorg-xinit
sudo pacman -S --noconfirm --needed xcompmgr
sudo pacman -S --noconfirm --needed neofetch
sudo pacman -S --noconfirm --needed noto-fonts-emoji
sudo pacman -S --noconfirm --needed arandr
sudo pacman -S --noconfirm --needed breeze-icons
sudo pacman -S --noconfirm --needed bash-completion

#Installerar YAY
clear
titel_message_length=${#titel_message}
spaces=$(( (${#separator} - message_length) / 2 ))
printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$titel_message" ""

message="installerar YAY"
message_length=${#message}
spaces=$(( (${#separator} - message_length) / 2 ))
printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$message" "$separator"

message2="Fixar YAY"
message2_length=${#message2}
spaces=$(( (${#separator} - message2_length) / 2 ))
 printf "%s%${spaces}s%s\n%s\n" "" "" "$message2" "$separator"
 
git clone https://aur.archlinux.org/yay.git $arbets_dir/yay
cd $arbets_dir/yay
makepkg -si --noconfirm
cd $arbets_dir

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

yay -S --noconfirm p7zip-gui

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

mkdir -p ~/Bilder/Bakgrundsbilder

mv $arbets_dir/Bakgrundsbilder/ ~/Bilder/

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
