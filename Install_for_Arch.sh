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

#
picom_animations() {
    # Clone the repository in the home/build directory
    mkdir -p ~/build
    if [ ! -d ~/build/picom ]; then
        if ! git clone https://github.com/FT-Labs/picom.git ~/build/picom; then
            echo "Failed to clone the repository"
            return 1
        fi
    else
        echo "Repository already exists, skipping clone"
    fi

    cd ~/build/picom || { echo "Failed to change directory to picom"; return 1; }

    # Build the project
    if ! meson setup --buildtype=release build; then
        echo "Meson setup failed"
        return 1
    fi

    if ! ninja -C build; then
        echo "Ninja build failed"
        return 1
    fi

    # Install the built binary
    if ! sudo ninja -C build install; then
        echo "Failed to install the built binary"
        return 1
    fi

    echo "Picom animations installed successfully"
}

clone_config_folders() {
    # Ensure the target directory exists
    [ ! -d ~/.config ] && mkdir -p ~/.config

    # Iterate over all directories in config/*
    for dir in config/*/; do
        # Extract the directory name
        dir_name=$(basename "$dir")

        # Clone the directory to ~/.config/
        if [ -d "$dir" ]; then
            cp -r "$dir" ~/.config/
            echo "Cloned $dir_name to ~/.config/"
        else
            echo "Directory $dir_name does not exist, skipping"
        fi
    done
}

clone_config_folders

picom_animations

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
