#!/usr/bin/env python3
import os, sys, subprocess as subproc, getpass
import curses

# ANSI color codes
class ansi_colors:
    RED = "\033[31m"
    GREEN = "\033[32m"
    YELLOW = "\033[33m"
    BLUE = "\033[34m"
    RESET = "\033[0m"

def run_command(command, npasswd=""):
    try:
        if npasswd == "":
            print(f"{ansi_colors.GREEN}Running: {command}")
            subproc.run(command, shell=True, check=True)
            print(f"{ansi_colors.RESET}")

        else:
            print(f"{ansi_colors.YELLOW}Running with sudo: {command}")
            full_command = f"echo {npasswd} | sudo -S {command}"
            subproc.run(full_command, shell=True, check=True)
            print(f"{ansi_colors.RESET}")

    except subproc.CalledProcessError as e:
        print(f"{ansi_colors.RED}Command failed: {command}", file=sys.stderr)
        print(f"{ansi_colors.RESET}")
        pass

def tui_runner(stdscr):
    stdscr.clear()
    stdscr.addstr(0, 0, "Press q to quit")
    stdscr.addstr(1, 0, "Choose an option: 1) Yes  2) No")
    stdscr.refresh()
    stdscr.getch()

def flatpak_repo_rm(repo_info, npasswd=""):
    for repo_name, repo_url in repo_info:
        run_command(f"flatpak remote-delete {repo_name}", npasswd)

def flatpak_repo_add(repo_info, whosusing="user", npasswd=""):
    for repo_name, repo_url in repo_info:
        if whosusing == "user":
            run_command(f"flatpak remote-add --user --if-not-exists {repo_name} {repo_url}")
        else:
            if whosusing == "system":
                run_command(f"flatpak remote-add --system --if-not-exists {repo_name} {repo_url}", npasswd)

def flatpak_app_install(app_list, whosusing="user", repo_name="flathub", npasswd=""):
    app_string = " ".join(app_list)
    if whosusing == "user":
        run_command(f"flatpak install {repo_name} --user -y" + app_string)
    else:
        if whosusing == "system":
            if npasswd != "":
                run_command(f"flatpak install {repo_name} --system -y " + app_string, npasswd)
            else:
                run_command(f"flatpak install {repo_name} --system -y " + app_string)


def main():
    # Get sudo password
    sudopasswd = getpass.getpass(prompt="Enter your sudo password: ")

    # Flatpak repos
    fedora_repo = [
        ("fedora", "None"),
        ("fedora-testing", "None")
    ]

    flathub_repo = [
        ("flathub", "https://flathub.org/repo/flathub.flatpakrepo")
    ]

    gnome_nightly_repo = [
        ("gnome-nightly", "https://nightly.gnome.org/gnome-nightly.flatpakrepo")
    ]
    
    elementary_os_repo = [
        ("elementary", "https://flatpak.elementary.io/repo.flatpakrepo")
    ]
    
    # Remove repos
    flatpak_repo_rm(fedora_repo, sudopasswd) # Remove Fedora repos

    # Add repos
    flatpak_repo_add(flathub_repo, sudopasswd, "system") # Add Flathub System repo
    flatpak_repo_add(flathub_repo, sudopasswd, "user") # Add Flathub User repo
    flatpak_repo_add(gnome_nightly_repo, sudopasswd, "user") # Add GNOME Nightly repo
    flatpak_repo_add(elementary_os_repo, sudopasswd, "user") # Add Elementary OS repo

    # List of apps
    gnome_core_apps = [

        ## GNOME Core Apps
        "org.gnome.Decibels", # Audio Player
        "org.gnome.Calculator", # Calculator
        "org.gnome.Calendar", # Calendar
        "org.gnome.Snapshot", # Camera
        "org.gnome.clocks", # Clocks
        "org.gnome.Connections", # Connections
        "org.gnome.Contacts", # Contacts
        "org.gnome.baobab", # Disk Usage Analyzer
        "org.gnome.SimpleScan", # Document Scanner
        "org.gnome.Papers", # Document Viewer
        "org.gnome.font-viewer", # Font Viewer
        "org.gnome.Loupe", # Image Viewer
        "org.gnome.Logs", # Logs
        "org.gnome.Maps", # Maps
        "org.gnome.Music", # Music
        "org.gnome.TextEditor", # Text Editor
        "org.gnome.Showtime", # Video Player
        "org.gnome.Weather", # Weather
        "org.gnome.Epiphany", # Web
        ## Extra essentials (Stuff you'd use when you're using GNOME or not using KDE)
        "org.gnome.SoundRecorder", # Sound Recorder
        "org.gnome.Firmware", # Firmware
        "page.tesk.Refine", # Refine (GNOME Tweaks Alternative)
        "com.mattjakeman.ExtensionManager", # Extension Manager
        "net.nokyan.Resources", # Resources
        "org.gnome.seahorse.Application", # Passwords and Keys
        "org.gnome.Fractal", # Fractal
        "io.github.flattool.Ignition", # Ignition
        "com.github.johnfactotum.Foliate", # Foliate
        "com.github.tchx84.Flatseal", # Flatseal
        "org.gnome.World.PikaBackup", # Pika Backup
        "it.mijorus.gearlever", # Gear Lever
        "com.ranfdev.DistroShelf" # Distro Shelf
    ]

    essential_apps = [
        "org.gnome.World.PikaBackup", # Pika Backup
        "com.github.tchx84.Flatseal", # Flatseal
        "dev.bragefuglseth.Keypunch", # Keypunch
        "it.mijorus.gearlever", # Gear Lever
        "com.ranfdev.DistroShelf", # Distro Shelf
        "com.usebottles.bottles", # Bottles
        "com.belmoussaoui.Authenticator", # Authenticator
        "org.mozilla.firefox", # Firefox
        "org.torproject.torbrowser-launcher", # Tor Browser
        "org.qbittorrent.qBittorrent", # qBittorrent
        "dev.vencord.Vesktop", # Vesktop
        "com.slack.Slack", # Slack
        "org.telegram.desktop", # Telegram Desktop
        "org.onlyoffice.desktopeditors", # OnlyOffice
        "md.obsidian.Obsidian", # Obsidian
        "com.obsproject.Studio", # OBS Studio
        "org.localsend.localsend_app", # LocalSend
        "org.libretro.RetroArch", # RetroArch
        "org.gimp.GIMP", # GIMP
        "org.kde.krita", # Krita
        "org.kde.kdenlive", # Kdenlive
        "org.fedoraproject.MediaWriter", # Fedora Media Writer
        "org.virt_manager.virt-manager", # Virt-Manager
        "org.virt_manager.virt_manager.Extension.Qemu" # Virt-Manager QEMU Extension
    ]
    
    # Install apps
    flatpak_app_install(list(set(gnome_core_apps + essential_apps)), "system", "flathub")

if __name__ == "__main__":
    main()
