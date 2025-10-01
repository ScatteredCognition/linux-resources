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
flatpak remote-add --if-not-exists flathub-user https://flathub.org/repo/flathub.flatpakrepo

## Add GNOME Apps and Flatpak essentials
flatpak install flathub -y \
org.gnome.baobab \ # Disk Usage Analyzer
org.gnome.Calculator \ # Calculator
org.gnome.Calendar \ # Calendar
org.gnome.clocks \ # Clocks
org.gnome.Contacts \ # Contacts
org.gnome.Decibels \ # Audio Player
org.gnome.Firmware \ # Firmware
org.gnome.Logs \ # Logs
org.gnome.Loupe \ # Image Viewer
org.gnome.Maps \ # Maps
org.gnome.Music \ # Music
org.gnome.SimpleScan \ # Document Scanner
org.gnome.Snapshot \ # Camera
org.gnome.SoundRecorder \ # Sound Recorder
org.gnome.TextEditor \ # Text Editor
org.gnome.Showtime \ # Video Player
org.gnome.Weather \ # Weather
org.gnome.seahorse.Application \ # Passwords and Keys
org.gnome.font-viewer \ # Font Viewer

io.github.flattool.Ignition \ # Ignition
page.tesk.Refine \ # Refine
net.nokyan.Resources \ # Resources
com.github.johnfactotum.Foliate \  # Foliate 
org.gnome.World.PikaBackup \ # Pika Backup
com.mattjakeman.ExtensionManager \ # Extension Manager
com.github.tchx84.Flatseal \ # Flatseal
dev.bragefuglseth.Keypunch \ # Keypunch
com.belmoussaoui.Authenticator \ # Authenticator


## Add extra apps
org.mozilla.firefox \ # Firefox
org.torproject.torbrowser-launcher \ # Tor Browser
org.qbittorrent.qBittorrent \ # qBittorrent
dev.vencord.Vesktop \ # Vesktop
org.gnome.Fractal \ # Fractal
org.telegram.desktop \ # Telegram
org.onlyoffice.desktopeditors \ # OnlyOffice
md.obsidian.Obsidian \ # Obsidian
com.obsproject.Studio \ # OBS Studio
org.localsend.localsend_app \ # LocalSend
org.libretro.RetroArch \ # RetroArch
org.kde.krita \ # Krita
org.kde.kdenlive \ # Kdenlive
it.mijorus.gearlever \ # Gear Lever
org.fedoraproject.MediaWriter \ # Media Writer
com.usebottles.bottles \ # Bottles
com.ranfdev.DistroShelf # DistroShelf