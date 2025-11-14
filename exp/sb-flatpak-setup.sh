#!/usr/bin/env bash

# Check if running as root
if [[ $EUID -ne 0 ]]; then
  echo "Error: This script must be run as root." >&2
  exit 1
fi

## Remove fedora repos
flatpak remote-delete fedora 2>/dev/null
flatpak remote-delete fedora-testing 2>/dev/null

## Add flathub repos
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
#flatpak remote-add --if-not-exists flathub-user https://flathub.org/repo/flathub.flatpakrepo

## Add GNOME Apps and Flatpak essentials
flatpak install flathub -y \
org.gnome.baobab \
org.gnome.Calculator \
org.gnome.Calendar \
org.gnome.clocks \
org.gnome.Contacts \
org.gnome.Decibels \
org.gnome.Firmware \
org.gnome.Logs \
org.gnome.Loupe \
org.gnome.Maps \
org.gnome.Music \
org.gnome.Papers \
org.gnome.SimpleScan \
org.gnome.Snapshot \
org.gnome.SoundRecorder \
org.gnome.TextEditor \
org.gnome.Showtime \
org.gnome.Weather \
org.gnome.seahorse.Application \
org.gnome.font-viewer \
io.github.flattool.Ignition \
page.tesk.Refine \
net.nokyan.Resources \
com.github.johnfactotum.Foliate \
org.gnome.World.PikaBackup \
com.mattjakeman.ExtensionManager \
com.github.tchx84.Flatseal \
dev.bragefuglseth.Keypunch \
com.belmoussaoui.Authenticator \
org.mozilla.firefox \
org.torproject.torbrowser-launcher \
org.qbittorrent.qBittorrent \
dev.vencord.Vesktop \
org.gnome.Fractal \
org.telegram.desktop \
org.onlyoffice.desktopeditors \
md.obsidian.Obsidian \
com.obsproject.Studio \
org.localsend.localsend_app \
org.libretro.RetroArch \
org.kde.krita \
org.kde.kdenlive \
it.mijorus.gearlever \
org.fedoraproject.MediaWriter \
com.usebottles.bottles \
com.ranfdev.DistroShelf