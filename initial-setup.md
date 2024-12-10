
# Tweaks and configuration for Fedora KDE after initial install
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

## Configure flatpak remotes
Remove the Fedora flatpak remotes and add the Flathub flatpak remote.

``` 
# Delete fedora remotes
flatpak remote-delete fedora
flatpak remote-delete fedora-testing

# Add flathub remote as user (remove --user flag to install as system)
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