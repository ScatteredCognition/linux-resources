# Linux resources
Github repo to archive and share my resources regarding linux.
- If you want to install normal Fedora - [(guide)](guides/initial-setup.md)

## Fedora Quick Start
- Install Fedora Silverblue/Kinoite. [(torrent)](https://torrents.fedoraproject.org/)
- Rebase to Chondro or Shurjo image.
- NOTE : EACH RPM-OSTREE OVERLAY DOES GIGABYTES OF DISK WRITES, BETTER TO AVOID.
- Update The system. <br>
```bash
rpm-ostree update
systemctl reboot
```

- Setup RPMFusion (1/2). <br>
```bash
rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
systemctl reboot
```

- Setup RPMFusion (2/2). <br>
```bash
rpm-ostree update --uninstall rpmfusion-free-release --uninstall rpmfusion-nonfree-release --install rpmfusion-free-release --install rpmfusion-nonfree-release
rpm-ostree install rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted
```

- Install Intel drivers. <br>
`rpm-ostree install intel-media-driver libva-intel-driver`
- Install mesa-freeworld. <br>
```bash
rpm-ostree override remove mesa-va-drivers --install mesa-va-drivers-freeworld
rpm-ostree override remove mesa-vdpau-drivers --install mesa-vdpau-drivers-freeworld
# If vdpau errors out, then
rpm-ostree install mesa-vdpau-drivers-freeworld
```

- Install gstreamer plugins. <br>
```bash
rpm-ostree install gstreamer1-plugin-libav gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld gstreamer1-plugins-ugly gstreamer1-vaapi --allow-inactive
```

- Install ffmpeg. <br>
```bash
rpm-ostree override remove fdk-aac-free libavcodec-free libavdevice-free libavfilter-free libavformat-free libavutil-free libpostproc-free libswresample-free libswscale-free ffmpeg-free --install ffmpeg
```

- Install shells. <br>
`rpm-ostree install fish tcsh zsh nu`
- Install apps and utilities. <br>
`rpm-ostree install syncthing distrobox git android-tools firewall-config`
- Install Bangla language stuff. <br>
`rpm-ostree install langpacks-bn <path_to_OpenBangla_Keyboard.rpm>`
- Enable Flathub repo & delete Fedora flatpak repos <br>
  ```bash
  ## Delete fedora remotes
  flatpak remote-delete fedora
  flatpak remote-delete fedora-testing
  
  ## Add flathub remote as user (use --system flag to install as system)
  ## Should get auto-installed with the latest images
  flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  ```

- Change the default user shell : [`fish`](guides/fish-shell.md)
- If using Full Disk Encryption with LUKS : [TPM autounlock](guides/tpm-autounlock.md)
- Enable syncthing service: <br>
  `systemctl --user --now enable syncthing.service`


## NOTE:
- Install VSCode, OnlyOffice, Obsidian, LM Studio and Virtualbox as appimages, use [Gear Lever](https://flathub.org/apps/it.mijorus.gearlever) from Flathub.
- Compiling OpenBangla Keyboard - [(guide)](guides/obk-compile.md)
- Useful flags for Electron apps or Chromium - [(guide)](guides/electron-args-flags.md)
- Setup OpenBangla Keyboard in KDE (TODO)
