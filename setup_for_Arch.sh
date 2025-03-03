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

    if [ -z "$work_dir" ]; then
        work_dir=$(pwd)
    fi

    # Enabling multilib repository for Steam
    print_message "Enabling multilib repository for Steam"
    sudo sed -i '/#\[multilib\]/s/^#//' /etc/pacman.conf
    sudo sed -i '/#Include = \/etc\/pacman.d\/mirrorlist/s/^#//' /etc/pacman.conf

    # Updating system
    print_message "Updating system"
    sudo pacman -Syy --noconfirm
    sudo pacman -S --noconfirm base-devel git libx11 libxft xorg-server xorg-xinit bash-completion ttf-jetbrains-mono-nerd noto-fonts-emoji bat
    sudo pacman -S --noconfirm fastfetch rofi btop picom starship feh ffmpeg pcmanfm arandr steam flatpak

    flatpak install -y flathub org.prismlauncher.PrismLauncher
    flatpak install -y flathub com.chatterino.chatterino
    flatpak install -y flathub io.github.shiftey.Desktop
    flatpak install -y flathub com.visualstudio.code

    cp -r $work_dir/config/starship.toml ~/.config/starship.toml
    cp -r $work_dir/config/mimeapps.list ~/.config/mimeapps.list

    echo "Moving starship.toml"
    echo "Copy Rofi config files"

    mkdir -p ~/.config/rofi
    cp -r $work_dir/config/rofi/ ~/.config/rofi/

    echo "Copy fastfetch config file"
    cp -r $work_dir/config/fastfetch/ ~/.config/fastfetch/

    # Installing dwm, slstatus
    print_message "Installing dwm, st, slstatus"
    rm -rf dwm
    git clone https://github.com/DeluxerPanda/dwm.git
    cd dwm
    sudo make clean install
    cd $work_dir

    rm -rf st
    git clone https://github.com/DeluxerPanda/st.git
    cd st
    sudo make clean install
    cd $work_dir

    rm -rf slstatus
    git clone https://github.com/DeluxerPanda/slstatus.git
    cd slstatus
    sudo make clean install
    cd $work_dir

    for app in ".bashrc" ".bash_profile"; do
        echo "Moving $app"
        cp -r $work_dir/config/"$app" ~/
    done

    sudo cp -r $work_dir/config/20-amdgpu.conf /etc/X11/xorg.conf.d/20-amdgpu.conf

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

    print_message "Setting up systemd service and timer för Flatpak"
    echo "Updating Flatpak applications..."
    flatpak update -y

    # Setup systemd service and timer
    echo "Setting up systemd service and timer..."
    sudo cp -r $work_dir/services/flatpak-update.service /etc/systemd/system/flatpak-update.service
    sudo systemctl daemon-reload
    sudo systemctl enable --now flatpak-update.service
    echo "Systemd service and timer set up successfully!"

    print_message "Klart"
fi