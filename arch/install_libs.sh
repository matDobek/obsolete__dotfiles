#!/usr/bin/env bash

#===================
# Paru
#===================
# AUR - It contains package descriptions (PKGBUILDs) that allow you to compile a package from source with makepkg and then install it via pacman.
# Paru is helper for AUR packages, but can also manage 'pacman' official packages.
#
# Do I need to use both?
#   No. Paru is pacman + AUR
#
function install_paru() {
  if ! paru -v COMMAND &> /dev/null
  then
    cd /tmp
    git clone https://aur.archlinux.org/paru.git
    cd paru

    # cannot be run as root
    makepkg -si
  fi
}

#================
# Essentials
#================

sudo pacman -S --noconfirm base-devel # for building arch packages ( automake, autoconf, ... )
sudo pacman -S --noconfirm git

install_paru

#================
# Desktop Environment
#================

sudo pacman -S --noconfirm xorg
sudo pacman -S --noconfirm xorg-xinit
sudo pacman -S --noconfirm xorg-xev       # key discovery
sudo pacman -S --noconfirm xorg-xlsfonts  # list fonts in older formats ( usefull for dzen2 )

sudo pacman -S --noconfirm wmctrl     # window manager info
sudo pacman -S --noconfirm dzen2      # notifications
sudo pacman -S --noconfirm rofi       # launcher
sudo pacman -S --noconfirm picom      # pretty windows (shadows, transparency, ... )
sudo pacman -S --noconfirm feh        # image viewer ( set wallpaper )
sudo pacman -S --noconfirm conky      # system monitor, system info
sudo pacman -S --noconfirm neofetch   # command-line system information tool
paru -S --noconfirm eww-git           # allows to implement custom widgets in any window manager
paru -S --noconfirm vala tiramisu-git # desktop notifications, the UNIX way
paru -S --noconfirm betterlockscreen  # fast and sweet looking lockscreen

sudo pacman -S --noconfirm alsa-utils                 # dealing with hardware audio cards
sudo pacman -S --noconfirm pulseaudio pulseaudio-alsa # proxy for application layer
sudo pacman -S --noconfirm pavucontrol                # front-end for pulse

sudo pacman -S --noconfirm alacritty

sudo pacman -S --noconfirm xmonad
sudo pacman -S --noconfirm xmonad-contrib
xmonad --recompile

# ====================
# Terminal Tools
# ====================

sudo pacman -S --noconfirm tmux
sudo pacman -S --noconfirm z

sudo pacman -S --noconfirm bash-completion
sudo pacman -S --noconfirm bashtop             # terminal system monitor
sudo pacman -S --noconfirm curl
sudo pacman -S --noconfirm pv                  # monitor the progress of data through a pipe
sudo pacman -S --noconfirm redshift
sudo pacman -S --noconfirm the_silver_searcher # ag
sudo pacman -S --noconfirm xclip
sudo pacman -S --noconfirm maim                # screenshots :: taking
sudo pacman -S --noconfirm krita               # screenshots :: editing

# ====================
# Fonts
# ====================

pacman -S --noconfirm ttf-fira-code
paru -S --noconfirm nerd-fonts-fira-code
# Fonts for google chrome - to display unicode symbls ( ·)
sudo pacman -S --noconfirm noto-fonts
sudo pacman -S --noconfirm noto-fonts-emoji
paru -S --noconfirm  ttf-font-awesome
fc-cache -vf

#================
# Databases
#================

sudo pacman -S --noconfirm redis
sudo pacman -S --noconfirm postgresql
sudo pacman -S --noconfirm pgadmin4

# PostgreSQL init: https://wiki.archlinux.org/index.php/PostgreSQL

sudo systemctl enable redis.service
sudo systemctl enable postgresql.service
sudo systemctl start redis.service
sudo systemctl start postgresql.service

# ====================
# Docker
# ====================

paru -S --noconfirm docker
paru -S --noconfirm docker-compose

sudo usermod -aG docker $USER
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# ====================
# Kubernates
# ====================

sudo pacman -S --noconfirm kubectl

sudo pacman -S --noconfirm aws-cli
sudo pacman -S --noconfirm aws-vault

sudo pacman -S --noconfirm libsecret     # Library for storing and retrieving passwords and other secrets
sudo pacman -S --noconfirm gnome-keyring # Stores passwords and encryption keys

# ====================
# Other
# ====================

sudo pacman -S --noconfirm firefox
paru -S --noconfirm discord
paru -S --noconfirm spotify

#===================
# LaTeX
#===================
#   https://wiki.archlinux.org/title/TeX_Live
#
#   To install additional packages:
#     tlmgr install package_name
#===================

sudo pacman -Sy --noconfirm texlive-most

#================
# Lanugages
#================

paru -S --noconfirm unzip asdf-vm

# as user, in home dir

asdf install elixir latest
asdf install erlang latest
asdf install ruby latest

asdf local ruby latest
asdf local elixir latest
asdf local erlang latest

#===================
# Language servers
#===================

# https://github.com/elixir-lsp/elixir-ls
# asdf exec gem install solargraph

#================
# NeoVim
#================

sudo pacman -S --noconfirm fzf
sudo pacman -S --noconfirm neovim

# Can I use asdf instead of global install?
sudo pacman -S --noconfirm python3
sudo pacman -S --noconfirm python-pip

# This should be done as USER
python3 -m pip install --user --upgrade pynvim
yarn global add neovim
gem install neovim

#================
# Steam installation
#================

#sudo pacman -S wine
#sudo pacman -S steam-manjaro
#sudo pacman -S nvidia-440xx-utils
#yay -S steam-fonts

#================
# Graphics card driver
#================

#
# WARN : you have to choose version manually
#
# lspci | grep -e VGA -e 3D
# pacman -S nvidia-440xx-utils
#

pacman -S --noconfirm nvidia

#================
# New , unordered
#================

# add me
paru -S --noconfirm xcolor farge # pick color from the screen

# Where?
# betterlockscreen -u ./xmonad/background.jpg

#
# Post Issues
#

# Chromium instead of google chrome

paru -S --noconfirm google-chrome

# No sound
sudo pacman -S --noconfirm alsa-utils

# no notifications?
# no border on top
curl https://sh.rustup.rs -sSf | sh
rustup toolchain install nightly
paru -S --noconfirm eww-git


# NVIDIA
# Grep Card
# lspci -k | grep -A 2 -E "(VGA|3D)"
# Lookup the drivers:
# https://nouveau.freedesktop.org/CodeNames.html

# graphics file manager
sudo pacman -S --noconfirm nemo

# to enable phoenix live reloading
sudo pacman -S --noconfirm inotify-tools

#sudo pacman -S --noconfirm zsh
#sudo pacman -S --noconfirm zsh-autosuggestions
#git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# sudo pacman -S --noconfirm fish
# curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
