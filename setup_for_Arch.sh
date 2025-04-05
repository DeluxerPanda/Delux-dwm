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
                ;;
        esac
    done
fi

function Installing() {
    print_message "Enabling multilib repository for Steam"

    sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
    sudo pacman -Sy --noconfirm --needed

    print_message "Updating system"
    sudo pacman -Syy --noconfirm

    print_message "Installing essential packages"
    sudo pacman -S --noconfirm base-devel git libx11 libxft xorg-server xorg-xinit bash-completion ttf-jetbrains-mono-nerd noto-fonts-emoji picom starship feh rofi

    print_message "Installing additional packages"
    sudo pacman -S --noconfirm fastfetch btop ffmpeg pcmanfm arandr steam bat github-cli xarchiver streamlink

    print_message "Installing Prism Launcher"
    latest_release=$(curl -s https://api.github.com/repos/PrismLauncher/PrismLauncher/releases/latest | grep "browser_download_url.*AppImage" | cut -d '"' -f 4)
    wget $latest_release -O prismlauncher.AppImage
    chmod +x prismlauncher.AppImage
    sudo mv prismlauncher.AppImage /usr/local/bin/

    sudo cp -r $work_dir/images/PrismLauncherIcon.png /usr/local/bin/

    sudo bash -c "cat <<'EOF' > /usr/share/applications/PrismLauncher.desktop
[Desktop Entry]
Name=Prism Launcher
Comment=An Open Source Minecraft launcher
Exec=/usr/local/bin/prismlauncher %u
Icon=/usr/local/bin/PrismLauncherIcon.png
Terminal=false
Type=Application
EOF"

    print_message "Installing Chatterino"
    latest_release=$(curl -s https://api.github.com/repos/Chatterino/chatterino2/releases/latest | grep "browser_download_url.*AppImage" | cut -d '"' -f 4)
    wget $latest_release -O Chatterino-x86_64.AppImage
    chmod +x Chatterino-x86_64.AppImage
    
    sudo mv Chatterino-x86_64.AppImage /usr/local/bin/
    
    sudo cp -r $work_dir/images/chatterinoIcon.png /usr/local/bin/
    
    sudo bash -c "cat <<'EOF' > /usr/share/applications/chatterino.desktop
[Desktop Entry]
Name=Chatterino
Comment=Chatterino IRC client
Exec=/usr/local/bin/chatterino %u
Icon=/usr/local/bin/chatterinoIcon.png
Terminal=false
Type=Application
EOF"

}

function CopyingFiles() {
    print_message "Copying files"

    cp -r $work_dir/config/starship.toml ~/.config/
    cp -r $work_dir/config/mimeapps.list ~/.config/

    mkdir -p ~/.config/rofi
    cp -r $work_dir/config/rofi/ ~/.config/
    mkdir -p ~/.config/fastfetch
    cp -r $work_dir/config/fastfetch/ ~/.config/

    cp -r $work_dir/config/.bash_profile ~/.bash_profile
    cp -r $work_dir/config/.bashrc ~/.bashrc

    sudo cp -r $work_dir/config/20-amdgpu.conf /etc/X11/xorg.conf.d/
}

function buildingPackages() {
    print_message "Building and installing dwm, st, slstatus, YaY"

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

    rm -rf yay
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ~/build
}

function setupAutologin() {
    print_message "Setting up autologin"

    # Get the current username
    USERNAME=$(logname)

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

    print_message "Now you can reboot your system"
}


Installing
CopyingFiles
buildingPackages
setupAutologin