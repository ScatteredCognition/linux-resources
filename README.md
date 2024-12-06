# Fedora-KDE-setup-guide
My personal Fedora KDE setup guide.

# Tweaks and configuration for Fedora KDE
## dnf is too slow

- Open `dnf.conf` : `kwrite /etc/dnf/dnf.conf`
- Add/Change the following values.

```
# Download 20 packages simultaneously
max_parallel_downloads = 20

# Mirror must maintain download speed of atleast 256*1024 bytes (256KiB/s) for the duration of `timeout` value in seconds
minrate = 262144

# Mirror must maintain `minrate` amount of download speed in bytes for `timeout` value in seconds
timeout = 5  
```

## Install Noto fonts and Bangla language pack
Install all the Noto fonts and the `langpacks-bn` language pack.
```
run0 dnf install -y google-noto-fonts-all langpacks-bn
```

## Install, set and configure fish as the default shell
Install the `fish` shell.
```
run0 dnf install -y fish
```

Set `fish` as the default shell for current user.
```
echo "$USER" > username.txt
run0 usermod -s /usr/bin/fish $(cat username.txt)
rm -f username.txt
```

Configure `fish`
- Open `config.fish` : `kwrite ~/.config/fish/config.fish`
- Add/Change the following values.
```
if status is-interactive
# Commands to run in interactive sessions can go here

# Change the welcome message
set fish_greeting

# Replace sudo with run0
alias sudo 'run0'

end
```
## Configure flatpak remotes
Remove the Fedora flatpak remotes and add the Flathub flatpak remote.

``` 
# Delete fedora remotes
flatpak remote-delete fedora
flatpak remote-delete fedora-testing

# Add flathub remote as system
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Add flathub remote as user
flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```
## Configure RPMFusion
Configure RPMFusion and install restricted extras.

```
# Run elevated to avoid password prompt spam
run0 bash

# Install rpmfusion repos
dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Initial setup stuff
dnf config-manager setopt fedora-cisco-openh264.enabled=1
dnf update -y @core @multimedia

# Install rpmfusion tainted repos
dnf install -y rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted

# Install uncucked ffmpeg
dnf swap -y ffmpeg-free ffmpeg --allowerasing

# Install intel drivers
dnf install -y intel-media-driver libva-intel-driver

# Install uncucked amd drivers
dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
dnf swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld

# Install 32bit uncucked amd drivers (avoid)
#dnf swap -y mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686
#dnf swap -y mesa-vdpau-drivers.i686 mesa-vdpau-drivers-freeworld.i686

# Install uncucked nvidia drivers
dnf install -y libva-nvidia-driver

# Install 32bit uncucked nvidia drivers (avoid)
#dnf install -y libva-nvidia-driver.{i686,x86_64}

# Install dvd ripping library
dnf install libdvdcss

# Install tainted firmware
dnf --repo=rpmfusion-nonfree-tainted install "*-firmware"

```

# What things I need to do on a computer
## Web browsing
- [Brave Browser](https://brave.com/linux/) <br>
Add `--enable-features=TouchpadOverscrollHistoryNavigation` for touchpad gestures. <br>
Change Wayland flags from `chrome://flags` for Wayland support.
- KeePassXC : `sudo dnf install -y keepassxc` <br>
(needs [Sync stuff](#sync-stuff))

## Notetaking
- [Obsidian](https://obsidian.md/download) <br>
Add `--ozone-platform-hint=auto` for Wayland support.

## Sync stuff
<a id="sync-stuff"></a>
- Syncthing : `sudo dnf install -y syncthing` <br>
- Enable the service :
```
systemctl --user --now enable syncthing.service
```

## Office work
Do basic word processing, presentation and worksheet creation.
### Tools required
- LibreOffice : `sudo dnf install -y libreoffice`
- [OnlyOffice Desktop Editors](https://www.onlyoffice.com/download-desktop.aspx?from=desktop) (only supports Zotero online)
- [OpenBangla Keyboard](https://github.com/OpenBangla/OpenBangla-Keyboard/tree/e050df46b20d665cc564f90261c6c6c3f1e90008/tools/make-pkgs)
- [Microsoft Office](https://massgrave.dev) (inside a VM)
- [Zotero 7 (unofficial)](https://github.com/ryuuzaki42/Zotero_AppImage) <br>
If you encounter the error with Zotero 7 : <br>
```
libdbus-glib-1.so.2: cannot open shared object file: No such file or directory Couldn't load XPCOM
```
Install `dbus-glib` : `sudo dnf install -y dbus-glib`

## Graphics Design
- Krita : `sudo dnf install -y krita`
- GIMP : `sudo dnf install -y gimp`
- Affinity Suite (inside a VM)

## Virtual machines
Create and run VMs for Windows-only tools.
### Tools required
- virt-manager : `sudo dnf install -y virt-manager` <br> (needs additional setup, unfinished)
- [Windows virtIO guest drivers](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/) (download iso)
- RDP (optional)
- Intel iGPU SRIOV (someday soon)
- [VMWare Workstation](https://www.vmware.com/products/desktop-hypervisor/workstation-and-fusion) ([Mirror](https://www.techspot.com/downloads/189-vmware-workstation-for-windows.html)) (offers full DirectX acceleraion, better and faster, but you lose secure boot)
## Rust development
- [Visual Studio Code](https://code.visualstudio.com/download) <br>
Add `--ozone-platform-hint=auto` for Wayland support.
- git : `sudo dnf install -y git`
- rust & rust-analyzer : `sudo dnf install -y rust rust-analyzer`

