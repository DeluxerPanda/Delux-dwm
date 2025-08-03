#!/bin/bash

titel_message="
 ██████╗ ███████╗██╗     ██╗   ██╗██╗  ██╗    ██████╗ ██╗    ██╗███╗   ███╗
 ██╔══██╗██╔════╝██║     ██║   ██║╚██╗██╔╝    ██╔══██╗██║    ██║████╗ ████║
 ██║  ██║█████╗  ██║     ██║   ██║ ╚███╔╝     ██║  ██║██║ █╗ ██║██╔████╔██║
 ██║  ██║██╔══╝  ██║     ██║   ██║ ██╔██╗     ██║  ██║██║███╗██║██║╚██╔╝██║
 ██████╔╝███████╗███████╗╚██████╔╝██╔╝ ██╗    ██████╔╝╚███╔███╔╝██║ ╚═╝ ██║
 ╚═════╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝    ╚═════╝  ╚══╝╚══╝ ╚═╝     ╚═╝                                          
"

print_message() {
    local message="$1"
    local message_length=${#message}
    local separator="-----------------------------------------------------------------------------"
    local spaces=$(( (${#separator} - message_length) / 2 ))
    printf "%s\n%${spaces}s%s\n%s\n" "$separator" "" "$message" "$separator"
}

work_dir=$(pwd)
USERNAME=$(logname)

if [ "$(id -u)" -eq 0 ]; then
    print_message "$titel_message"
    print_message "You can't run as root"
    exit 1
else
    print_message "$titel_message"
    print_message "Script starting"

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
                exit
                ;;
        esac
    done
fi

function Installing() {
    clear
    print_message "$titel_message"
    print_message "installing packages"

#updateing
    sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

    sudo pacman -Sy --noconfirm

    sudo pacman -Syy --noconfirm

#system
    sudo pacman -S --noconfirm base-devel git libx11 libxft xorg-server xorg-xinit wget curl git ffmpeg polkit-kde-agent java-runtime-common networkmanager

#fonts
    sudo pacman -S --noconfirm ttf-jetbrains-mono-nerd noto-fonts-emoji

#programs
    sudo pacman -S --noconfirm gimp rofi arandr xarchiver mpv streamlink flameshot firefox pavucontrol steam prismlauncher discord feh

#KDE apps
    sudo pacman -S --noconfirm kdeconnect dolphin

#terminal stuff 
    sudo pacman -S --noconfirm starship picom bash-completion bat fastfetch btop

# YAY
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd $work_dir
rm -rf yay-bin


#programs
yay -S --noconfirm chatterino2-bin visual-studio-code-bin

if lsusb | grep -q "GoXLRMini"; then
yay -S --noconfirm goxlr-utility
fi

}

function CopyingFiles() {
    clear
    print_message "$titel_message"
    print_message "Copying files"

#Scripts
    cp -r $work_dir/scripts ~/scripts
#StarShip
    cp -r $work_dir/config/starship.toml ~/.config/starship.toml
#MimeApps
    cp -r $work_dir/config/mimeapps.list ~/.config/mimeapps.list
#Rofi
    cp -r $work_dir/config/rofi/ ~/.config/rofi
#FastFetch
    cp -r $work_dir/config/fastfetch/ ~/.config/fastfetch
#Bash Profile
    cp -r $work_dir/config/.bash_profile ~/.bash_profile
#Bash RC
    cp -r $work_dir/config/.bashrc ~/.bashrc
#X Init RC
    cp -r $work_dir/config/.xinitrc ~/.xinitrc
#AMD GPU
    #sudo cp -r $work_dir/config/20-amdgpu.conf /etc/X11/xorg.conf.d/
}

function buildingPackages() {
    clear
    print_message "$titel_message"
    print_message "Building and installing dwm, st, slstatus"

    mkdir -p ~/build
    cd ~/build

    rm -rf dwm
    git clone https://github.com/DeluxerPanda/dwm.git
    cd dwm
    sudo make clean install
    cd ~/build

    rm -rf st
    git clone https://github.com/DeluxerPanda/st.git
    cd st
    sudo make clean install
    cd ~/build

    rm -rf slstatus
    git clone https://github.com/DeluxerPanda/slstatus.git
    cd slstatus
    sudo make clean install
    cd ~/build
}

function setupAutologin() {
    clear
    print_message "$titel_message"
    print_message "Setting up autologin"

    # Check if user exists
    if ! id "$USERNAME" &>/dev/null; then
        echo "User '$USERNAME' does not exist. Please create the user first."
        exit 1
    fi

    # Create systemd override directory if not exists
    sudo mkdir -p /etc/systemd/system/getty@tty1.service.d

    # Write the override configuration
    sudo bash -c "cat <<'EOF' > /etc/systemd/system/getty@tty1.service.d/override.conf
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin $USERNAME --noclear %I \$TERM
EOF"

    sudo systemctl enable getty@tty1

    clear
    curl -fsSL https://christitus.com/linux | sh
}

Installing
virtualization
CopyingFiles
buildingPackages
setupAutologin
