#!/bin/bash
ROFI_VERSION="1.7.5"
set -o errexit

#setup
echo "Before we start, please confirm a few things."
echo "Your home directory is able to be written to."
echo "The latest version of Rofi is ${ROFI_VERSION}."
read -p "If these are true, press enter to start installation. If not, kindly stop the setup script and edit the appropriate values. [response]: " throwawayvariable

#functions
add_themes() {
	old=${PWD}
	d=$(mktemp -u)
	git clone --depth=1 "https://github.com/${1}" $d
	cd ${d}
	chmod +x ${3}
	echo "${2}" | "./${3}"
	cd ..
	rm -rf ${d}
	cd ${old}
}

add_special_cnf() {
	d="${HOME}/.config/${1}"
	mkdir -p ${d}
	echo "DOTFILE [${1}] to ${d}/${2}.."
	cp ./special_df/${1} ${d}/${2}
}



if [ "$(id -u)" -eq 0 ]; then
	echo "Please do not run as root.";
	exit 1;
fi;

echo "Installing base packages..."
sudo apt update
sudo apt install -y haskell-stack brightnessctl bison libnm0 libnm-dev libnotify-bin flex xcb libxcb-icccm4-dev libxcb-ewmh-dev libxcb-cursor-dev libpango1.0-dev libstartup-notification0-dev libgdk-pixbuf2.0-dev check feh autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev
sudo apt install -y imagemagick mpd gir1.2-nm-1.0 network-manager x11-xserver-utils vim polybar build-essential i3 macchanger bat curl git zsh zsh-syntax-highlighting zsh-autosuggestions python3-pip
sudo pip3 install pywal pygobject

#networkmanager
sudo systemctl enable NetworkManager.service
sudo systemctl start NetworkManager.service

echo "Installing rust and cargo..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
cargo install lsd

echo "Installing powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
sudo chsh -s /usr/bin/zsh ${USER}

echo "Installing BetterLockScreen..."
add_themes Raymo111/i3lock-color.git 1 install-i3lock-color.sh
sudo bash -c 'wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | bash -s system latest true'
sudo ln -s /usr/local/bin/betterlockscreen /usr/bin/betterlockscreen
mkdir -p "${HOME}/.config/i3"
blscreen="${HOME}/.config/i3/lockscreenbackgroundpapers"
cp -r lockscreen_wallpapers ${blscreen}
betterlockscreen -u ${blscreen}/lockscreen.jpg

echo "Installing networkmanager-dmenu..."
olddir=${PWD}
cd ~
git clone --depth=1 https://github.com/firecat53/networkmanager-dmenu
cd networkmanager-dmenu
sudo mv networkmanager_dmenu /usr/bin
sudo chmod +x /usr/bin/networkmanager_dmenu
cd ..
rm -rf networkmanager-dmenu
cd ${olddir}

echo "Installing Rofi..."
olddir=${PWD}
cd ~
wget "https://github.com/davatorium/rofi/releases/download/${ROFI_VERSION}/rofi-${ROFI_VERSION}.tar.gz"
tar xf rofi-${ROFI_VERSION}.tar.gz
rm rofi-${ROFI_VERSION}.tar.gz
cd rofi-${ROFI_VERSION}
mkdir build
cd build
../configure
make
sudo make install
cd ../..
rm -r rofi-${ROFI_VERSION}
cd ${olddir}

echo "Adding dotfiles.."
cp -r ./dotfiles/. ~
add_special_cnf i3 config
cp -r ./special_df/networkmanager-dmenu ~/.config

echo "Adding themes..."
add_themes adi1090x/polybar-themes.git 1 setup.sh
add_themes adi1090x/rofi.git 1 setup.sh

#change polybar cuts theme so that it uses betterlockscreen vs ugly i3lock
sed -i s/i3lock/thisisreplacedsothatbetterlockscreenworkslol/g ~/.config/polybar/cuts/scripts/powermenu.sh
sed -i s/'betterlockscreen -l'/'betterlockscreen -l dimblur'/g ~/.config/polybar/cuts/scripts/powermenu.sh

echo "All done! Make sure you set your terminal emulator to use /usr/bin/zsh!"
echo "Even better, boot into I3 WM for maximum glory"
read -p "Now, press enter to reboot: " blah
sudo reboot now
