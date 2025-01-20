#! /usr/bin/env bash

# // !/usr/bin/env bash #####

##Color
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
C_OFF='\033[0m'        # Reset Color


## Get script directory
SCRIPT_DIR=/mnt/D/CRYPTO/ubuntu-post-install

sudo apt install -y lsb-release
## Ubuntu version (number)
system="`lsb_release -rs`"


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
sudo add-apt-repository -y multiverse
sudo add-apt-repository -y universe


# Adding keys
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
rm microsoft.gpg
# wget -q https://dl-ssl.google.com/linux/linux_signing_key.pub -O- | sudo apt-key add -

# Adding repos
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" >> /etc/apt/sources.list.d/vscode.list'
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/microsoft.gpg] https://packages.microsoft.com/repos/edge stable main" >> /etc/apt/sources.list.d/microsoft-edge.list'
# sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

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

## Programs to be installed with apt
## System
sudo apt install -y ffmpeg net-tools ufw software-properties-common \
	apt-transport-https sassc openssh-client cpu-x dpkg gpg make \
	cmake build-essential g++ gnupg clang dkms ca-certificates \
	lsb-release bash-completion ubuntu-restricted-extras ppa-purge \
	xz-utils gcc-multilib pkg-config gdebi gdebi-core ninja-build \
	pass dconf-cli policykit-1 fonts-firacode

## Libs
sudo apt install -y libssl-dev libcurl4-gnutls-dev libexpat1-dev \
	libinih-dev libdbus-1-dev libsystemd-dev

## CLI
sudo apt install -y git git-gui \
    nano htop neofetch curl wget

## Apps
sudo apt install -y flatpak krita vlc qbittorrent libreoffice \
	sweeper grub-customizer virtualbox gparted \
	unzip p7zip-rar p7zip-full rar unrar zip \
	microsoft-edge-stable code telegram
sudo apt install -y --fix-broken --install-recommends

## For outline
sudo apt install -y libfuse2t64

## For Gnome
# sudo apt install -y  gnome-browser-connector gnome-disk-utility \
# 	gnome-software-plugin-flatpak gnome-shell-extension-manager \
# 	gnome-tweaks chrome-gnome-shell	dconf-editor gnome-shell-extensions
	# plasma-discover-backend-flatpak

# Just in case
echo "Downloading package keys and .deb files..."
cd ~
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B05498B7
# wget https://github.com/jgraph/drawio-desktop/releases/download/v24.5.3/drawio-amd64-24.5.3.deb
# wget https://github.com/hiddify/hiddify-next/releases/download/v2.5.7/Hiddify-Debian-x64.deb
# wget https://raw.githubusercontent.com/0xSlaweekq/setup/main/Linux/theme/ocs-url_3.1.0-0ubuntu1_amd64.deb
# wget https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb
# wget https://download.anydesk.com/linux/anydesk_6.1.1-1_amd64.deb

sudo apt install -y $SCRIPT_DIR/ocs-url_3.1.0-0ubuntu1_amd64.deb
sudo apt install -y $SCRIPT_DIR/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb
sudo apt install --fix-broken -y
sudo apt install -y -f
sudo systemctl daemon-reload

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
. ~/.bashrc
foundryup

echo
echo "############################################"
echo -e "${GREEN}System and Programs - Done${C_OFF}"
echo "############################################"

# # install qemu
# sudo apt update
# sudo apt install -y \
#   cpu-checker bridge-utils libvirt-daemon-system libvirt-clients \
#   virt-manager virtinst qemu-kvm
# sudo adduser $USER libvirt
# sudo adduser $USER kvm
# sudo systemctl enable --now libvirtd
# sudo systemctl start libvirtd
# sudo systemctl status libvirtd
# sudo usermod -aG kvm $USER
# sudo usermod -aG libvirt $USER
# virt-manager

# # dotNet
# sudo apt update && \
#   sudo apt install -y \
#   dotnet-sdk-8.0 aspnetcore-runtime-8.0 dotnet-runtime-8.0 zlib1g ca-certificates \
#   libc6 libgcc-s1 libicu74 liblttng-ust1 libssl3 libstdc++6 libunwind8

# cd ~
# wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
# chmod +x ./dotnet-install.sh
# ./dotnet-install.sh --channel 6.0
# ./dotnet-install.sh --channel 7.0
# ./dotnet-install.sh --version latest
# rm ./dotnet-install.sh


############################ Theme #######################################

## Set dark mode
# gsettings set org.gnome.shell.ubuntu color-scheme prefer-dark

## WhiteSur Theme
echo -e "Installing WhiteSur Theme..."
sudo apt install -y \
  qt5-style-kvantum qt5-style-kvantum-themes libglib2.0-dev-bin \
  imagemagick dialog optipng x11-apps make extra-cmake-modules \
  qtdeclarative5-dev libqt5x11extras5-dev libx11-dev libkf5plasma-dev \
  libkf5iconthemes-dev libkf5windowsystem-dev libkf5declarative-dev \
  libkf5xmlgui-dev libkf5activities-dev build-essential libxcb-util-dev \
  gettext  git libkf5archive-dev libkf5notifications-dev \
  libxcb-util0-dev libsm-dev libkf5crash-dev kirigami2-dev \
  libkf5newstuff-dev libxcb-shape0-dev libxcb-randr0-dev libx11-xcb-dev \
  libkf5wayland-dev libwayland-dev libwayland-client0 libqt5waylandclient5-dev \
  qtwayland5-dev-tools plasma-wayland-protocols

cd ~
git clone https://github.com/vinceliuice/grub2-themes.git
git clone https://github.com/vinceliuice/MacVentura-kde.git
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
git clone https://github.com/vinceliuice/McMojave-cursors.git

chmod +x $HOME/grub2-themes/install.sh
chmod +x $HOME/MacVentura-kde/install.sh
chmod +x $HOME/WhiteSur-gtk-theme/install.sh
chmod +x $HOME/WhiteSur-gtk-theme/tweaks.sh
chmod +x $HOME/WhiteSur-icon-theme/install.sh
chmod +x $HOME/McMojave-cursors/install.sh
chmod +x $HOME/McMojave-cursors/build.sh
# make -C dash-to-dock install

# wallpapers / backgrounds
SCRIPT_DIR=/mnt/D/CRYPTO/ubuntu-post-install
sudo cp -r $SCRIPT_DIR/wallpaper/* /usr/share/backgrounds/
sudo cp -r $SCRIPT_DIR/wallpaper/* $HOME/.local/share/backgrounds
sudo cp -r $SCRIPT_DIR/wallpaper/* /usr/share/wallpapers/
sudo cp -r $SCRIPT_DIR/wallpaper/* $HOME/.local/share/wallpapers

## WhiteSur Grub
$HOME/grub2-themes/install.sh -t whitesur -i whitesur -s 2k -b

## Global theme
$HOME/MacVentura-kde/install.sh --round

## WhiteSur gtk
$HOME/WhiteSur-gtk-theme/install.sh -c Dark -t all -m --round --black --darker

## WhiteSur Icons
$HOME/WhiteSur-icon-theme/install.sh -t default -a -b

## WhiteSur Tweaks
$HOME/WhiteSur-gtk-theme/tweaks.sh -c Dark -t blue -F -c Dark -t blue

## McMojave cursors
cd $HOME/McMojave-cursors
./build.sh
./install.sh
cd ~
sleep 3

## Load all settings
# dconf load / < dconf-backup.txt

echo '#################################################################'
echo 'Install done. Next Remove files'
echo '#################################################################'

rm -rf $HOME/grub2-themes
rm -rf $HOME/WhiteSur-gtk-theme
rm -rf $HOME/WhiteSur-icon-theme
rm -rf $HOME/dash-to-dock
rm -rf $HOME/MacVentura-kde
rm -rf $HOME/McMojave-cursors
rm -rf $HOME/_build
rm -rf $HOME/dist

# Widgets
# Application Tittle
# Plasma Drawer
# tiled menu
# latte spacer separator
# Inline clock
# big sur inline battery

cd /lib/firmware
sudo wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/iwlwifi-so-a0-gf-a0-89.ucode
sudo modprobe -r iwlwifi
sudo modprobe iwlwifi
sudo dmesg | grep iwlwifi
echo '#################################################################'
echo 'Read'
echo '# https://www.linuxuprising.com/2020/10/whitesur-macos-big-sur-like-gtk-gnome.html'
echo '# https://www.youtube.com/watch?v=DX_gQTQLUZc'
echo 'Install Widgets'
echo '# Application Tittle, Plasma Drawer, tiled menu, latte spacer'
echo '# latte separator, Inline clock, big sur inline battery'
echo '#################################################################'
echo "Remove done"
echo '#################################################################'

echo
echo "############################################"
echo -e "${GREEN}Theme - Done${C_OFF}"
echo "############################################"
echo -e "Changes will be applied after restarting the computer"

echo -e "${GREEN}Done! Changes will be applied after reboot${C_OFF}. Reboot now? (y/n)"
read -r RESTART
if [[ $RESTART == "y" || $RESTART == "Y" ]]; then
    sudo reboot now
else
    echo "${GREEN}Done! Changes will be applied after reboot${C_OFF}"
fi

# sudo nano /etc/apparmor.d/outline-client
# # This profile allows everything and only exists to give the
# # application a name instead of having the label "unconfined"

# abi <abi/4.0>,
# include <tunables/global>

# profile outlineclient /home/msi/Applications/Outline-Client_26d5e77d3783669d5cd6642e7d72f257.AppImage flags=(default_allow) {
#   userns,

#   # Site-specific additions and overrides. See local/README for details.
#   include if exists <local/outline-client>
# }
# sudo systemctl reload apparmor.service
