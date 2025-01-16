#! /usr/bin/env bash

echo 'Install WhiteSur KDE, GTK & ICON theme'
echo '#################################################################'

# https://www.opendesktop.org/p/1136805/
cd ~
wget https://raw.githubusercontent.com/0xSlaweekq/setup/main/Linux/theme/ocs-url_3.1.0-0ubuntu1_amd64.deb
sudo apt install -y ./ocs-url_3.1.0-0ubuntu1_amd64.deb

sudo add-apt-repository -y ppa:papirus/papirus
sudo apt update
sudo apt dist-upgrade
# sudo apt install qt6-style-kvantum qt6-style-kvantum-themes

sudo apt install -y \
  qt5-style-kvantum qt5-style-kvantum-themes sassc libglib2.0-dev-bin \
  imagemagick dialog optipng x11-apps make extra-cmake-modules \
  qtdeclarative5-dev libqt5x11extras5-dev libx11-dev libkf5plasma-dev \
  libkf5iconthemes-dev libkf5windowsystem-dev libkf5declarative-dev \
  libkf5xmlgui-dev libkf5activities-dev build-essential libxcb-util-dev \
  gettext  git libkf5archive-dev libkf5notifications-dev \
  libxcb-util0-dev libsm-dev libkf5crash-dev kirigami2-dev \
  libkf5newstuff-dev libxcb-shape0-dev libxcb-randr0-dev libx11-xcb-dev \
  libkf5wayland-dev libwayland-dev libwayland-client0 libqt5waylandclient5-dev \
  qtwayland5-dev-tools plasma-wayland-protocols

git clone https://github.com/vinceliuice/grub2-themes.git
git clone https://github.com/vinceliuice/MacVentura-kde.git
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
git clone https://github.com/vinceliuice/McMojave-cursors.git

chmod +x ./grub2-themes/install.sh
chmod +x ./MacVentura-kde/install.sh
chmod +x ./WhiteSur-gtk-theme/install.sh
chmod +x ./WhiteSur-gtk-theme/tweaks.sh
chmod +x ./WhiteSur-icon-theme/install.sh
chmod +x ./McMojave-cursors/install.sh
chmod +x ./McMojave-cursors/build.sh
# make -C dash-to-dock install

# wallpapers / backgrounds
sudo cp -r /mnt/D/CRYPTO/ubuntu-post-install/wallpaper/* /usr/share/wallpapers/
sudo cp -r /mnt/D/CRYPTO/ubuntu-post-install/wallpaper/* $HOME/.local/share/wallpapers

## WhiteSur Grub
./grub2-themes/install.sh -t whitesur -i whitesur -s 2k -b

## Global theme
./MacVentura-kde/install.sh --round

## WhiteSur gtk
./WhiteSur-gtk-theme/install.sh -c Dark -t all -m --round --black --darker

## WhiteSur Icons
./WhiteSur-icon-theme/install.sh -t default -a -b

## WhiteSur Tweaks
./WhiteSur-gtk-theme/tweaks.sh -c Dark -t blue -F -c Dark -t blue

## McMojave cursors
cd ./McMojave-cursors
./build.sh
./install.sh
cd ~
sleep 3

echo '#################################################################'
echo 'Install done. Next Remove files'
echo '#################################################################'

rm -rf ./grub2-themes
rm -rf ./WhiteSur-gtk-theme
rm -rf ./WhiteSur-icon-theme
rm -rf ./dash-to-dock
rm -rf ./Wuthering-grub2-themes
rm -rf ./MacVentura-kde
rm -rf ./McMojave-cursors
rm -rf ./_build
rm -rf ./dist

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
