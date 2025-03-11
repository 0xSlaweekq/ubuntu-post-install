#!/usr/bin/env bash

############################ Theme #######################################

# https://www.opendesktop.org/p/1136805/
# cd ~
# wget https://raw.githubusercontent.com/0xSlaweekq/setup/main/Linux/theme/ocs-url_3.1.0-0ubuntu1_amd64.deb
# sudo apt install -y ./ocs-url_3.1.0-0ubuntu1_amd64.deb

## Set dark mode
# gsettings set org.gnome.shell.ubuntu color-scheme prefer-dark

sudo add-apt-repository -y ppa:papirus/papirus
sudo apt update
sudo apt dist-upgrade

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

# Widgets
# Application Tittle
# Plasma Drawer
# tiled menu
# latte spacer separator
# Inline clock
# big sur inline battery
