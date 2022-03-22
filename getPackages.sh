#!/bin/sh

pacman -Qqe | grep -v "$(awk '{print $1}' /desktopfs-pkgs.txt)" > ~/.dotfiles/AUR-package.txt

flatpak list --app --show-details | awk '{print "flatpak install --assumeyes --user \""$2"\" \""$1}' | cut -d "/" -f1 | awk '{print $0"\""}' > ~/.dotfiles/Flatpack-packages.txt

snap list > ~/.dotfiles/Snap-packages.txt
