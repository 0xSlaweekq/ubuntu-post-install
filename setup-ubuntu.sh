#!/usr/bin/env bash

##Color
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
C_OFF='\033[0m'        # Reset Color


## Get script directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

## Ubuntu version (number)
system="`lsb_release -rs`"

## Active icon theme
activeTheme=$(gsettings get org.gnome.desktop.interface icon-theme | tr -d "'")


########################## Programs ##################################

## Add repositories
echo -e "${YELLOW}Adding repositories...${C_OFF}"
sudo add-apt-repository -y ppa:papirus/papirus
sudo add-apt-repository -y ppa:flatpak/stable
sudo add-apt-repository -y ppa:kisak/kisak-mesa
sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer
sudo add-apt-repository -y ppa:atareao/telegram
sudo add-apt-repository -y ppa:graphics-drivers/ppa
# sudo add-apt-repository -y ppa:obsproject/obs-studio
sudo add-apt-repository -y ppa:papirus/papirus
sudo add-apt-repository -y multiverse
sudo add-apt-repository -y universe


wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
# wget -q https://dl-ssl.google.com/linux/linux_signing_key.pub -O- | sudo apt-key add -
# sudo add-apt-repository -y "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main"
sudo add-apt-repository -y "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo add-apt-repository -y "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main"

# $(lsb_release -cs)
# cd /etc/apt/sources.list.d
# sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com `sudo apt update 2>&1 | grep -o '[0-9A-Z]\{16\}$' | xargs`
sudo timedatectl set-local-rtc 1


## Update repositories
echo -e "${YELLOW}Updating repositories...${C_OFF}"
sudo apt update
sudo dpkg --add-architecture amd64
sudo dpkg --add-architecture i386
sudo apt update
sudo apt upgrade -y
sudo apt install --fix-broken -y
sudo apt autoclean -y
sudo apt autoremove --purge


## Programs to be removed
REMOVE_APT=(
	firefox
    yelp*
    gnome-logs
    seahorse
    gnome-contacts
    geary
    gnome-weather
    ibus-mozc
    mozc-utils-gui
    gucharmap
    simple-scan
    popsicle
    popsicle-gtk
    totem*
    lm-sensors*
    xfburn
    xsane*
    hv3
    exfalso
    parole
    quodlibet
    xterm
    redshift*
    drawing
    hexchat*
    thunderbird*
    transmission*
    transmission-gtk*
    transmission-common*
    webapp-manager
    celluloid
    hypnotix
    rhythmbox*
    librhythmbox-core10*
    rhythmbox-data
    mintbackup
    mintreport
    aisleriot
    gnome-mahjongg
    gnome-mines
    quadrapassel
    gnome-sudoku
    pitivi
    gnome-sound-recorder
    remmina*
)

## Programs to be installed with apt
PROGRAMS_APT=(
	## System
	ffmpeg
	net-tools
	ufw
    software-properties-common
    apt-transport-https
    sassc
    openssh-client
    cpu-x
    dpkg
    gpg
    make
    cmake
    build-essential
    g++
    gnupg
    clang
    dkms
    ca-certificates
    lsb-release
    bash-completion
    ubuntu-restricted-extras
    ppa-purge
    xz-utils
    gcc-multilib
    pkg-config
    gdebi
    gdebi-core
    ninja-build
    pass
    dconf-cli
    policykit-1

    ## Libs
    libssl-dev
    libcurl4-gnutls-dev
    libexpat1-dev
    libinih-dev
    libdbus-1-dev
    libsystemd-dev

	## CLI
	git
    git-core
    git-gui
    nano
	htop
	neofetch
    curl
    wget

	## Fonts
	fonts-firacode

	## Gnome
	chrome-gnome-shell
	dconf-editor
	gnome-shell-extensions
    gnome-shell-extension-manager
	gnome-tweaks

	## Apps
    flatpak
    krita
    vlc
    qbittorrent
    libreoffice
    sweeper
    grub-customizer
    microsoft-edge-stable
    code
    telegram
	code
	vlc
	virtualbox
    grub-customizer
    gparted
    unzip
    p7zip-rar
    p7zip-full
    rar
    unrar
    zip

    ## For Gnome
    gnome-browser-connector
    gnome-disk-utility
    gnome-software-plugin-flatpak
    gnome-shell-extension-manager
    gnome-tweaks
    chrome-gnome-shell

    ## plasma-discover-backend-flatpak
)

## Remove bloatware
echo -e "${BLUE}Removing bloatware...${C_OFF}"
for program_name in ${REMOVE_APT[@]}; do
	if dpkg -l | grep -q $program_name; then # If program is installed
		echo -e "${YELLOW}	[REMOVING] - $program_name ${C_OFF}"

		sudo apt remove "$program_name" -y -q
	fi
done
echo -e "${GREEN}Bloatware removed${C_OFF}"

## Install programs with apt
echo -e "${BLUE}Installing programs with apt...${C_OFF}"
for program_name in ${PROGRAMS_APT[@]}; do
	if ! dpkg -l | grep -q $program_name; then # If program is not installed
		echo -e "${YELLOW}	[INSTALLING] - $program_name ${C_OFF}"

		sudo apt install "$program_name" -y -q
	fi
done

# Just in case
sudo apt install -y --fix-broken --install-recommends
sudo apt install -y ./ocs-url_3.1.0-0ubuntu1_amd64.deb

# Options for shell in vscode
mkdir -p $HOME/.local/share/trusted.gpg.d
xdg-mime default code.desktop text/plain
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
eval $(/usr/bin/gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
code --locate-shell-integration-path bash

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo systemctl daemon-reload
sudo dpkg --configure -a
bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"

# Install Flatpak packages
flatpak install -y flathub \
  com.discordapp.Discord com.github.tchx84.Flatseal \
  io.github.mimbrero.WhatsAppDesktop org.kde.isoimagewriter \
  com.github.sdv43.whaler org.onlyoffice.desktopeditors com.usebottles.bottles \
  com.github.Matoking.protontricks net.davidotek.pupgui2
  # com.obsproject.Studio com.github.d4nj1.tlpui \
  # com.getpostman.Postman io.dbeaver.DBeaverCommunity
  # net.lutris.Lutris com.playonlinux.PlayOnLinux4 org.audacityteam.Audacity

# Flatpak permissions
sudo flatpak override --filesystem=/usr/lib/x86_64-linux-gnu/GL \
  --filesystem=host --share=network --socket=x11 --socket=wayland \
  --system-talk-name=org.freedesktop.NetworkManager \
  --system-talk-name=org.freedesktop.resolve1 \
  --talk-name=org.freedesktop.Notifications

# Group management for Flatpak and networking
sudo groupadd -f network
sudo groupadd -f flatpak
sudo usermod -aG network,sudo,flatpak $(whoami)
groups $(whoami)

# Install Tenderly CLI
curl -sSL https://raw.githubusercontent.com/Tenderly/tenderly-cli/master/scripts/install-linux.sh | sudo sh
tenderly login --authentication-method access-key --access-key FWrGeuFEOTmwzUdD4Glm1BRl1ov5hNLJ --force

# Install VirtualBox
sudo apt install -y virtualbox
# sudo newgrp vboxusers
sudo usermod -aG vboxusers $(whoami)
sudo adduser $(whoami) vboxusers
sudo apt install -y virtualbox-dkms xserver-xorg-core cpu-checker

# Install Hysteria
echo 'Installing Hysteria...'
wget -q https://github.com/HyNetwork/hysteria/releases/download/v1.3.0/hysteria-linux-amd64
chmod +x hysteria-linux-amd64
sudo mv hysteria-linux-amd64 /usr/local/bin/hysteria

## Remove junk and update
echo -e "${YELLOW}Updating, upgrading and cleaning system...${C_OFF}"
sudo apt update && sudo apt dist-upgrade -y
sudo apt autoclean
sudo apt autoremove -y

curl -L https://foundry.paradigm.xyz | bash
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
foundryup

## Checklist
echo -e "\nInstalled APT's:"
for program_name in ${PROGRAMS_APT[@]}; do
	if dpkg -l | grep -q $program_name; then
		echo -e "	${GREEN}[INSTALLED] - $program_name ${C_OFF}"
	else
		echo -e "	${RED}[NOT INSTALLED] - $program_name ${C_OFF}"
	fi
done

echo
echo "############################################"
echo -e "${GREEN}System and Programs - Done${C_OFF}"
echo "############################################"




############################ Theme #######################################

## Set dark mode
gsettings set org.gnome.shell.ubuntu color-scheme prefer-dark

## WhiteSur Theme
echo -e "Installing WhiteSur Theme..."
git clone -q https://github.com/vinceliuice/grub2-themes.git
git clone -q https://github.com/vinceliuice/WhiteSur-gtk-theme.git
git clone -q https://github.com/vinceliuice/WhiteSur-icon-theme.git

sudo chmod +x $SCRIPT_DIR/grub2-themes/install.sh
sudo chmod +x $SCRIPT_DIR/WhiteSur-gtk-theme/install.sh
sudo chmod +x $SCRIPT_DIR/WhiteSur-gtk-theme/tweaks.sh
sudo chmod +x $SCRIPT_DIR/WhiteSur-icon-theme/install.sh

# wallpapers / backgrounds
sudo cp -r $SCRIPT_DIR/wallpaper/* /usr/share/backgrounds/
sudo cp -r $SCRIPT_DIR/wallpaper/* $HOME/.local/share/backgrounds
sudo cp -r $SCRIPT_DIR/wallpaper/* /usr/share/wallpapers/
sudo cp -r $SCRIPT_DIR/wallpaper/* $HOME/.local/share/wallpapers

## WhiteSur Grub
sudo $SCRIPT_DIR/grub2-themes/install.sh -t whitesur -i whitesur -s 2k -b
cd WhiteSur-gtk-theme

## WhiteSur gtk
sudo $SCRIPT_DIR/WhiteSur-gtk-theme/install.sh -c Dark -t all -m -N mojave \
	--round --black --darker

## WhiteSur Tweaks
sudo $SCRIPT_DIR/WhiteSur-gtk-theme/tweaks.sh -c Dark -t blue \
	-F -c Dark -t blue

## WhiteSur Icons
sudo $SCRIPT_DIR/WhiteSur-icon-theme/install.sh -t default -a -b
sleep 3
cd $SCRIPT_DIR

## Load all settings
# dconf load / < dconf-backup.txt

sudo rm -rf ./grub2-themes
sudo rm -rf ./WhiteSur-gtk-theme
sudo rm -rf ./WhiteSur-icon-theme
sudo rm -rf ./dash-to-dock
sudo rm -rf ./_build
sudo rm -rf ./dist

echo
echo "############################################"
echo -e "${GREEN}Theme - Done${C_OFF}"
echo "############################################"
echo -e "Changes will be applied after restarting the computer"

echo -e "${GREEN}Done! Changes will be applied after reboot${C_OFF}"
