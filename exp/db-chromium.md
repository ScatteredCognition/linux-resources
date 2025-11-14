# Guide on setting up any Chromium browser inside a (Fedora) distrobox
## Setup the Distrobox
1. `distrobox create -n appbox-fedora --init --additional-packages "systemd" --pre-init-hooks ""`
2. `distrobox enter appbox-fedora -- sh -c db-fedora-essential.sh`
3. echo "max_parallel_downloads = 20" >> /etc/dnf/dnf.conf
4. sudo dnf update
5. sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
6. sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1
7. sudo dnf install rpmfusion-{free,nonfree}-release-tainted
8. sudo dnf swap ffmpeg-free ffmpeg --allowerasing
9, sudo dnf install libdvdcss intel-media-driver libva-intel-driver gnome-keyring libsecret pipewire xdg-desktop-portal-{gtk,gnome} flatpak, xdg-user-dirs{,-gtk} xdg-utils
## Chromium commands (as of Nov 13 2025)
`vivaldi --enable-features=AcceleratedVideoDecodeLinuxGL,AcceleratedVideoDecodeLinuxZeroCopyGL,AcceleratedVideoEncoder,TouchpadOverscrollHistoryNavigation,WaylandPerSurfaceScale,WaylandUiScale,MiddleClickAutoscroll --gtk-version=4`