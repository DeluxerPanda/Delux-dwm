#!/bin/bash
titel_message="
 ██████╗ ███████╗██╗     ██╗   ██╗██╗  ██╗    ██████╗ ██╗    ██╗███╗   ███╗
 ██╔══██╗██╔════╝██║     ██║   ██║╚██╗██╔╝    ██╔══██╗██║    ██║████╗ ████║
 ██║  ██║█████╗  ██║     ██║   ██║ ╚███╔╝     ██║  ██║██║ █╗ ██║██╔████╔██║
 ██║  ██║██╔══╝  ██║     ██║   ██║ ██╔██╗     ██║  ██║██║███╗██║██║╚██╔╝██║
 ██████╔╝███████╗███████╗╚██████╔╝██╔╝ ██╗    ██████╔╝╚███╔███╔╝██║ ╚═╝ ██║
 ╚═════╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝    ╚═════╝  ╚══╝╚══╝ ╚═╝     ╚═╝                                          
"
separator="-----------------------------------------------------------------------------"


if [ "$(id -u)" -eq 0 ]; then


printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$titel_message" ""

message="You can't run as root"
message_length=${#message}
spaces=$(( (${#separator} - message_length) / 2 ))

printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$message" "$separator"

exit 1
else

printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$titel_message" ""

message="Script starting"
message_length=${#message}
spaces=$(( (${#separator} - message_length) / 2 ))
printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$message" "$separator"
echo -ne "
 1. Install AUR helper and rate mirrors.
 2. Update the system.
 3. Install dependencies.
 4. Install Picom animations.
 5. Install DWM and Slstatus.
 6. Ask the user if they want to move 20-amdgpu.conf to /etc/X11/xorg.conf.d/.
"
printf "%s\n%${spaces}s%s\n%s\n" "$separator"

while true; do

read -p "Do you want to run this script? (y/n) " yn

case $yn in
	[yY] | [jJ] | [sS][oO] | [yY][eE][sS] | [jJ][aA] )
		echo "ok, we will proceed"
		break
		;;
	[nN] | [nN][oO] | [nN][eE][iI][nN] )
		echo "exiting..."
		exit
		;;
	* )
		echo "invalid response"
		;;
esac

done

fi



if [ -z "$work_dir" ]; then
    work_dir=$(pwd)
fi
sudo pacman -Sy
#Installing: AUR helper and Rate mirrors
message="Installing: AUR helper and Rate mirrors"
message_length=${#message}
spaces=$(( (${#separator} - message_length) / 2 ))

printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$message" "$separator"

command_exists() {
    which $1 >/dev/null 2>&1
}

            if ! command_exists yay && ! command_exists paru; then
        echo "Installing yay as AUR helper..."
          sudo ${PACKAGER} --noconfirm -S base-devel || { echo -e "${RED}Failed to install base-devel${RC}"; exit 1; }
          cd /opt && sudo git clone https://aur.archlinux.org/yay-git.git && sudo chown -R ${USER}:${USER} ./yay-git
          cd yay-git && makepkg --noconfirm -si || { echo -e "${RED}Failed to install yay${RC}"; exit 1; }
      else
          echo "Aur helper already installed"
      fi
      if command_exists yay; then
          AUR_HELPER="yay"
      elif command_exists paru; then
          AUR_HELPER="paru"
      else
          echo "No AUR helper found. Please install yay or paru."
          exit 1
      fi
      if ! command_exists rate-mirrors; then
      ${AUR_HELPER} --noconfirm -S rate-mirrors-bin
        fi
      if [ -s /etc/pacman.d/mirrorlist ]; then
          sudo cp -r /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
      fi
      echo "checking out mirrors..."
      sudo rate-mirrors --top-mirrors-number-to-retest=5 --disable-comments --save /etc/pacman.d/mirrorlist --allow-root arch

#Updating system
message="Updating system"
message_length=${#message}
spaces=$(( (${#separator} - message_length) / 2 ))

printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$message" "$separator"

sudo pacman -Syu --noconfirm

#Installing dependencies
message="Installing dependencies"
message_length=${#message}
spaces=$(( (${#separator} - message_length) / 2 ))

printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$message" "$separator"


sudo pacman -S --noconfirm base-devel libx11 libxinerama libxft imlib2 hicolor-icon-theme libconfig dbus libepoxy libev libglvnd libxcb libxext pcre2 pixman xcb-util-image xcb-util-renderutil asciidoc mesa meson uthash xorgproto python xorg-xprop xorg-xwininfo 


#Installing picom animations
message="Installing picom animations"
message_length=${#message}
spaces=$(( (${#separator} - message_length) / 2 ))

printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$message" "$separator"

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

#Installing starship
message="Installing starship"
message_length=${#message}
spaces=$(( (${#separator} - message_length) / 2 ))

printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$message" "$separator"

if [ -s ~/.config/starship.toml ]; then
     cp -r ~/.config/starship.toml ~/.config/starship.toml.bak
     else
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
    echo "starship installed successfully"
fi
     cp -r $work_dir/configs/starship.toml ~/.config/starship.toml
    echo "Moving starship.toml"




    echo "Copy Rofi config files"
    if [ -d ~/.config/rofi/ ]; then
        cp -r ~/.config/rofi ~/.config/rofi.bak
    fi
    mkdir -p ~/.config/rofi
    cp -r $work_dir/configs/rofi/powermenu.sh ~/.config/rofi/powermenu.sh
    chmod +x ~/.config/rofi/powermenu.sh
    cp -r $work_dir/configs/rofi/config.rasi ~/.config/rofi/config.rasi
    mkdir -p ~/.config/rofi/themes
    cp -r $work_dir/configs/rofi/themes/nord.rasi ~/.config/rofi/themes/nord.rasi
    cp -r $work_dir/configs/rofi/themes/sidetab-nord.rasi ~/.config/rofi/themes/sidetab-nord.rasi
    cp -r $work_dir/configs/rofi/themes/powermenu.rasi ~/.config/rofi/themes/powermenu.rasi



#Installing dwm, slstatus
message="Installing dwm, slstatus"
message_length=${#message}
spaces=$(( (${#separator} - message_length) / 2 ))

printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$message" "$separator"

for app in "dwm" "slstatus"; do

    echo "Going to $app"
    cd $work_dir/"$app"

    echo "Making $app"
    sudo make clean install

done

for app in ".bashrc" ".bash_profile"; do
  if [ -s ~/$app ]; then
    cp -r ~/$app ~/$app.bak
 fi
     echo "Moving $app"
    cp -r $work_dir/configs/"$app" ~/
done

#moving fonts

sudo mkdir -p /usr/share/fonts/TTF
sudo cp -r $work_dir/Fonts/JetBrainsMonoNLNerdFontMono-Regular.ttf /usr/share/fonts/TTF/
fc-cache

cd $work_dir

while true; do

read -p "Do you want to move 20-amdgpu.conf to /etc/X11/xorg.conf.d/ (y/n) " yn

case $yn in
	[yY] | [jJ] | [sS][oO] | [yY][eE][sS] | [jJ][aA] )
		echo "Moving 20-amdgpu.conf to /etc/X11/xorg.conf.d/"
		sudo cp -r $work_dir/configs/20-amdgpu.conf /etc/X11/xorg.conf.d/20-amdgpu.conf
		break
		;;
	[nN] | [nN][oO] | [nN][eE][iI][nN] )
		message="The script is done"
        message_length=${#message}
        spaces=$(( (${#separator} - message_length) / 2 ))
        printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$message" "$separator"
		exit
		;;
	* )
		echo "invalid response"
		;;
esac

done

		message="The script is done"
        message_length=${#message}
        spaces=$(( (${#separator} - message_length) / 2 ))
        printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$message" "$separator"



